variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "cluster_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role for EKS nodes"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS nodes"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for EKS control plane"
  type        = list(string)
}

variable "cluster_security_group_id" {
  description = "Security group ID for EKS cluster control plane"
  type        = string
}

variable "enabled_log_types" {
  description = "List of control plane logging types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

# Application Node Group Variables
variable "application_node_instance_types" {
  description = "Instance types for application node group"
  type        = list(string)
  default     = ["t3.large"]
}

variable "application_node_capacity_type" {
  description = "Capacity type for application nodes (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "application_node_desired_size" {
  description = "Desired number of application nodes"
  type        = number
  default     = 2
}

variable "application_node_min_size" {
  description = "Minimum number of application nodes"
  type        = number
  default     = 2
}

variable "application_node_max_size" {
  description = "Maximum number of application nodes"
  type        = number
  default     = 6
}

# EKS Add-on Versions
variable "vpc_cni_addon_version" {
  description = "Version of VPC CNI add-on"
  type        = string
  default     = "v1.16.0-eksbuild.1"
}

variable "coredns_addon_version" {
  description = "Version of CoreDNS add-on"
  type        = string
  default     = "v1.11.1-eksbuild.4"
}

variable "kube_proxy_addon_version" {
  description = "Version of kube-proxy add-on"
  type        = string
  default     = "v1.29.0-eksbuild.1"
}

variable "ebs_csi_addon_version" {
  description = "Version of EBS CSI driver add-on"
  type        = string
  default     = "v1.28.0-eksbuild.1"
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
