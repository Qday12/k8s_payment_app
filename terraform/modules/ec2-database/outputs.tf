output "instance_id" {
  description = "ID of the EC2 database instance"
  value       = aws_instance.db_vm.id
}

output "instance_private_ip" {
  description = "Private IP of the database instance"
  value       = aws_instance.db_vm.private_ip
}

output "instance_private_dns" {
  description = "Private DNS of the database instance"
  value       = aws_instance.db_vm.private_dns
}

output "security_group_id" {
  description = "Security group ID of the database instance"
  value       = aws_security_group.db_vm.id
}

output "data_volume_id" {
  description = "ID of the EBS data volume"
  value       = aws_ebs_volume.db_data.id
}

output "db_endpoint" {
  description = "Database connection endpoint"
  value       = "${aws_instance.db_vm.private_ip}:5432"
}

output "db_host" {
  description = "Database host (private IP)"
  value       = aws_instance.db_vm.private_ip
}

output "db_port" {
  description = "Database port"
  value       = "5432"
}
