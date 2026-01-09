# Deployment Guide

## Prerequisites

- AWS CLI configured with SSO/credentials
- Terraform >= 1.5.0
- kubectl
- Helm

---

## Deploy Infrastructure

### 1. Bootstrap (One-time setup)

```bash
# Create S3 backend
cd terraform/bootstrap/backend
terraform init
terraform apply

# Create ECR and IAM for CI/CD
cd ../ecr-IAM
terraform init
terraform apply
```

### 2. Deploy Main Infrastructure

```bash
cd terraform/env/prod

# Initialize
terraform init

# Deploy
terraform plan -out=tfplan
terraform apply tfplan

# Configure kubectl
aws eks update-kubeconfig --name finpay-production-eks --region eu-central-1
```

---

## Deploy Application

### 1. Deploy Helm Chart

```bash
# Deploy to prod
helm upgrade --install finpay-app ./k8s/finpay-app \
  -f k8s/finpay-app/values-prod.yaml \
  --namespace prod \
  --create-namespace

# Verify deployment
kubectl get pods -n prod
kubectl get ingress -n prod
```

### 2. Verify Application

```bash
# Get ALB URL
ALB_URL=$(kubectl get ingress payment-api -n prod -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Test health endpoint
curl -H "Host: api.finpay.com" http://$ALB_URL/actuator/health

# Test payment endpoint
curl -X POST http://$ALB_URL/payments \
  -H "Host: api.finpay.com" \
  -H "Content-Type: application/json" \
  -d '{
    "amountInCents": 10000,
    "currency": "USD",
    "customerId": "cust_123"
  }'

'
curl http://$ALB_URL/payments/[ID] \
  -H "Host: api.finpay.com"

```

# Destroy Guide

Follow this order to avoid dependency errors:

## 1. Delete Helm Application

```bash
# Delete application
helm uninstall finpay-app -n prod

# Wait for ALB deletion
aws elbv2 describe-load-balancers --region eu-central-1 | grep k8s-prod

# Delete namespace
kubectl delete namespace prod
```

## 2. Destroy Terraform Infrastructure

```bash
cd terraform/env/prod

# Destroy all resources
terraform destroy
```

## 3. Destroy Bootstrap (Optional)

```bash
# Delete ECR and IAM
cd terraform/bootstrap/ecr-IAM
terraform destroy

# Delete S3 backend (LAST STEP - deletes state!)
cd ../backend
terraform destroy
```

