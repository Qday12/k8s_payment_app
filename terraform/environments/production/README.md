# FinPay Production Infrastructure

This directory contains the production environment Terraform configuration for the FinPay Payment Platform.

## Quick Start

### 1. Prerequisites

- AWS CLI configured
- Terraform >= 1.5.0
- Appropriate AWS permissions

### 2. Configure Variables

```bash
nano terraform.tfvars
```

**Important:** Update `cloudwatch_alarm_email` with your email address.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan & Apply

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

**Expected duration:** 20-30 minutes

### 5. Configure kubectl

```bash
aws eks update-kubeconfig --region eu-central-1 --name finpay-production-eks
kubectl get nodes
```

## What Gets Deployed

- **VPC:** 10.0.0.0/16 with 6 subnets across 2 AZs
- **EKS:** Kubernetes 1.28 cluster with 2 node groups (4 nodes total)
- **RDS:** PostgreSQL 16 Multi-AZ (db.t3.medium)
- **NAT Gateways:** 2 (one per AZ)
- **Security Groups:** 4 (ALB, EKS control plane, EKS nodes, RDS)
- **Secrets Manager:** Database credentials and app config
- **CloudWatch:** Log groups, alarms, and dashboard

## Estimated Cost

**~$497-737 per month**

See `../../terraform.md` for detailed cost breakdown.

## Post-Deployment

After infrastructure is created:

1. Install AWS Load Balancer Controller (for Ingress)
2. Install Fluent Bit (for logging)
3. Deploy payment applications using Helm

See `../../terraform.md` for detailed instructions.

## Outputs

View all outputs:
```bash
terraform output
```

Key outputs:
- `eks_cluster_name` - EKS cluster name
- `eks_cluster_endpoint` - Kubernetes API endpoint
- `rds_endpoint` - Database endpoint
- `configure_kubectl` - kubectl configuration command

## Documentation

For complete documentation, see: `../../terraform.md`

## Remote State Backend

To enable remote state storage:

1. Deploy backend resources:
   ```bash
   cd ../../bootstrap/backend
   terraform init
   terraform apply
   ```

2. Uncomment backend block in `main.tf`

3. Re-initialize:
   ```bash
   terraform init -migrate-state
   ```

## Maintenance

### Update infrastructure
```bash
terraform plan -out=tfplan
terraform apply tfplan
```

### Scale nodes
Edit `terraform.tfvars` and update node counts, then apply.

### Destroy (use with caution!)
```bash
terraform destroy
```

## Troubleshooting

See the Troubleshooting section in `../../terraform.md`.

## Support

Contact DevOps team for assistance.
