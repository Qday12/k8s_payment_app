# Kubernetes Architecture

## Namespaces

```
finpay-eks-cluster
├── production (main workloads: payment-api, payment-worker)
└── kube-system (K8s system components, AWS Load Balancer Controller)
```

**Rationale:** Namespace isolation for security and resource management

## Workload Architecture

### Deployment: payment-api

```yaml
Replicas: 2 (min), 8 (max via HPA)

Container:
  Image: {AWS_ACCOUNT}.dkr.ecr.eu-central-1.amazonaws.com/finpay/payment-api:v1.0.0
  Port: 8080

  Resources:
    Requests: cpu=250m, memory=512Mi
    Limits: cpu=1000m, memory=1Gi

  Environment Variables:
    - APP_ENV=production
    - DB_URL=jdbc:postgresql://{RDS_ENDPOINT}:5432/payments
    - DB_USER={from Secret}
    - DB_PASSWORD={from Secret}
    - LOG_LEVEL=INFO

  Health Checks:
    Liveness: GET /actuator/health (delay=60s, period=10s)
    Readiness: GET /actuator/ready (delay=30s, period=5s)
    Startup: GET /actuator/health (failureThreshold=30, period=5s)

  Security:
    runAsNonRoot: true
    runAsUser: 1001
    readOnlyRootFilesystem: true

Strategy:
  Type: RollingUpdate
  MaxSurge: 1
  MaxUnavailable: 0 (zero downtime - requirement #2)

Node Placement:
  nodeSelector:
    node-group: application

Anti-Affinity:
  Spread across different nodes and AZs
```

**Rationale:**
- Min 2 replicas for HA
- RollingUpdate with MaxUnavailable=0 for zero downtime
- Health checks ensure traffic only to healthy pods
- Runs on application node group (t3.large instances) for adequate resources

### Deployment: payment-worker

```yaml
Replicas: 2 (min), 6 (max via HPA)

Container:
  Image: {AWS_ACCOUNT}.dkr.ecr.eu-central-1.amazonaws.com/finpay/payment-worker:v1.0.0
  Port: 8090

  Resources:
    Requests: cpu=500m, memory=512Mi
    Limits: cpu=2000m, memory=1Gi

  Environment Variables:
    - APP_ENV=production
    - DB_URL=jdbc:postgresql://{RDS_ENDPOINT}:5432/payments
    - DB_USER={from Secret}
    - DB_PASSWORD={from Secret}
    - LOG_LEVEL=INFO

  Health Checks:
    Liveness: GET /actuator/health (delay=45s, period=10s)
    Readiness: GET /actuator/ready (delay=20s, period=5s)

  Security:
    runAsNonRoot: true
    runAsUser: 1001
    readOnlyRootFilesystem: true

Strategy:
  Type: RollingUpdate
  MaxSurge: 1
  MaxUnavailable: 0

Node Placement:
  nodeSelector:
    node-group: application
```

**Rationale:**
- Higher CPU request (500m vs 250m) for background processing
- Independent scaling from payment-api
- Runs on application node group alongside payment-api

## Services

### Service: payment-api-service
```yaml
Type: ClusterIP
Port: 8080
Selector: app=payment-api
```

### Service: payment-worker-service
```yaml
Type: ClusterIP
Port: 8090
Selector: app=payment-worker
```

## Ingress

### AWS Load Balancer Controller
- Deployed in `kube-system` namespace
- Creates AWS Application Load Balancer (ALB)
- Handles SSL/TLS termination at ALB level
- Integrates with ACM for certificate management

### Ingress: payment-api-ingress
```yaml
Host: api.finpay.com
TLS: Enabled (ACM certificate)

Rules:
  - Path: /payments → payment-api-service:8080
  - Path: /actuator/health → payment-api-service:8080

Annotations:
  alb.ingress.kubernetes.io/scheme: internet-facing
  alb.ingress.kubernetes.io/target-type: ip
  alb.ingress.kubernetes.io/subnets: public-subnet-a,public-subnet-b
  alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS": 443}]'
  alb.ingress.kubernetes.io/ssl-redirect: '443'
  alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:eu-central-1:...
  alb.ingress.kubernetes.io/healthcheck-path: /actuator/health
  alb.ingress.kubernetes.io/success-codes: '200'
```

**Rationale:**
- AWS Load Balancer Controller creates ALB
- Only payment-api exposed publicly
- payment-worker remains internal
- Layer 7 load balancing with path-based routing

## Auto-Scaling (HPA)

### HPA: payment-api
```yaml
Min Replicas: 2
Max Replicas: 8

Metrics:
  - CPU: target 70%
  - Memory: target 80%

Behavior:
  Scale Up: Add 100% pods every 60s (fast response)
  Scale Down: Remove 10% pods every 60s (gradual)
```

**Rationale:** Handles peak hours and traffic spikes. Automatic.

### HPA: payment-worker
```yaml
Min Replicas: 2
Max Replicas: 6

Metrics:
  - CPU: target 75%

Behavior:
  Scale Up: Add 100% pods every 30s (fast for CPU-bound work)
  Scale Down: Remove 10% pods every 60s
```

**Rationale:** CPU-focused scaling for background processing workload.

## Configuration Management

### ConfigMap: payment-config
```yaml
Data:
  APP_ENV: "production"
  LOG_LEVEL: "INFO"
  DB_URL: "jdbc:postgresql://finpay-rds.xxxx.eu-central-1.rds.amazonaws.com:5432/payments"
  # RDS Multi-AZ deployment in dedicated database subnets (10.0.20.0/24, 10.0.21.0/24)
```

### Secret: payment-db-secret
```yaml
Type: Opaque
Data:
  DB_USER: {base64 encoded, sourced from AWS Secrets Manager}
  DB_PASSWORD: {base64 encoded, sourced from AWS Secrets Manager}
```

**Rationale:**
- Can use AWS Secrets Manager CSI driver for automatic sync

## Resource Quotas (production namespace)

```yaml
Hard Limits:
  requests.cpu: "15"
  requests.memory: 36Gi
  limits.cpu: "30"
  limits.memory: 72Gi
  pods: "40"
```

**Rationale:** Prevents resource exhaustion. Cost control (requirement #6). Quota aligned with actual cluster capacity: 2-6 application nodes (t3.large) + 2 system nodes (t3.medium) = ~8-16 vCPU available.

## Pod Disruption Budgets

### PDB: payment-api-pdb
```yaml
minAvailable: 1
```

### PDB: payment-worker-pdb
```yaml
minAvailable: 1
```

## Monitoring & Logging

### Logging
- Fluent Bit DaemonSet collects logs (runs on all nodes - both application and system node groups)
- Forwarded to CloudWatch Logs
- Retention: 30 days

### Metrics
- Metrics Server (for HPA)
- CloudWatch Container Insights (cluster metrics)
- Spring Boot Actuator metrics from /actuator/prometheus

### Alerts
- Pod restart rate > 5 in 5 min
- HPA at max replicas (scaling limit)
- API response time > 2s
- Worker CPU > 85% for 10 min

## Security

### Network Policies (Optional - if required)
```yaml
Default: Deny all ingress/egress

Allowed:
  - payment-api → payment-worker (port 8090)
  - payment-api → RDS (port 5432)
  - payment-worker → RDS (port 5432)
  - All → kube-dns (port 53)
  - Ingress Controller → payment-api (port 8080)
```

**Rationale:** Zero-trust networking.

### RBAC
- ServiceAccount for each app
- IRSA annotations for AWS access
- Least privilege permissions

## Deployment Strategy (Zero Downtime)

1. New image pushed to ECR
2. Update deployment manifest with new tag
3. RollingUpdate begins:
   - Create 1 new pod
   - Wait for readiness probe to pass
   - Terminate 1 old pod
   - Repeat
4. MaxUnavailable=0 ensures no capacity loss
5. PDB ensures min 1 pod always available

**Rationale:** zero downtime deployments

