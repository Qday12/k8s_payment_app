# Cloud Infrastructure Architecture (AWS)

## Region
**eu-central-1**

## VPC Design
```
VPC: 10.0.0.0/16
├── Public Subnets (2 AZs)
│   ├── 10.0.1.0/24 (eu-central-1a)
│   └── 10.0.2.0/24 (eu-central-1b)
├── Private Subnets (2 AZs) - EKS Worker Nodes
│   ├── 10.0.10.0/24 (eu-central-1a)
│   └── 10.0.11.0/24 (eu-central-1b)
└── Database Subnets (2 AZs) - RDS
    ├── 10.0.20.0/24 (eu-central-1a)
    └── 10.0.21.0/24 (eu-central-1b)
```

**Why 2 AZs:** High availability

## Core Services

### 1. EKS (Elastic Kubernetes Service)
- **Version:** 1.28+
- **Control Plane:** Managed by AWS (multi-AZ by default)
- **Node Groups:**

  **Application Node Group:**
  - Instance: t3.medium
  - Min: 2, Max: 6
  - Spread across both AZs
  - HPA (Horizontal Pod Autoscaler) enabled
  - Runs payment-api and payment-worker pods


### 2. RDS PostgreSQL
- **Engine:** PostgreSQL 16
- **Instance:** db.t3.medium
- **Deployment:** Multi-AZ (primary in AZ-A, standby in AZ-B)
- **Storage:** 100GB GP3 SSD
- **Backups:** 7-day retention
- **Location:** Dedicated database subnets (10.0.20.0/24, 10.0.21.0/24) - no public access

### 3. ECR (Container Registry)
- **Repositories:**
  - `finpay/payment-api`
  - `finpay/payment-worker`
- **Image scanning:** Enabled (Trivy integration)
- **Lifecycle:** Keep last 10 tagged images

### 4. Application Load Balancer (ALB)
- **Type:** Application Load Balancer
- **Scheme:** Internet-facing
- **Subnets:** Both public subnets
- **Target:** EKS worker nodes (via Ingress Controller)
- **SSL/TLS:** ACM certificate (HTTPS enforced)

## Networking

### Internet Gateway (IGW)
- Attached to VPC
- Routes internet traffic to/from public subnets

### NAT Gateway
- 2 NAT Gateways (one per AZ)
  - NAT-A in public subnet 10.0.1.0/24 (eu-central-1a)
  - NAT-B in public subnet 10.0.2.0/24 (eu-central-1b)
- Private subnets in each AZ route outbound traffic through their respective NAT
- Required for: ECR pulls, external API calls, OS updates

### Security Groups

**ALB Security Group:**
- Inbound: 80/443 from 0.0.0.0/0
- Outbound: To EKS nodes

**EKS Node Security Group:**
- Inbound: From ALB, inter-node communication
- Outbound: All (for ECR, updates, etc.)

**RDS Security Group:**
- Inbound: Port 5432 from EKS node security group ONLY
- Outbound: None

## Monitoring & Logging

### CloudWatch
- **Logs:**
  - EKS control plane logs
  - Application logs from pods (via Fluent Bit)
- **Metrics:**
  - Container Insights for cluster metrics
  - Custom metrics from apps
- **Alarms:**
  - High CPU/memory
  - Pod restart count
  - RDS CPU > 90%

## Secrets Management

### AWS Secrets Manager
- Store: DB credentials (username, password)
- Access: Via IRSA (IAM Roles for Service Accounts)
- Rotation: 90-day automatic rotation

## IAM Roles

**EKS Node Role:**
- ECR pull permissions
- CloudWatch logs write
- Basic EC2 permissions

**Pod Execution Roles (via IRSA):**
- payment-api: Secrets Manager read access
- payment-worker: CloudWatch metrics write

**Rationale:** Least privilege access.

## Cost Estimation (Monthly, eu-central-1)

| Service | Cost |
|---------|------|
| EKS control plane | $73 |
| EC2 application nodes (2-6x t3.large) | $120-360 |
| EC2 system nodes (2x t3.medium) | $60 |
| RDS db.t3.medium Multi-AZ | $115 |
| ALB | $25 |
| NAT Gateways (2x) | $64 |
| CloudWatch, ECR, data transfer | $40 |
| **Total** | **~$497-737/month** |


## High Availability Strategy

| Component | HA Mechanism |
|-----------|--------------|
| EKS Control Plane | Managed by AWS (multi-AZ) |
| Worker Nodes | Spread across 2 AZs |
| RDS | Multi-AZ with auto-failover (~60s) |
| ALB | Multi-AZ by default |


