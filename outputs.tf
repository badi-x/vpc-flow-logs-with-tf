
output "instance_ips" {
  value = [for i in aws_instance.web : i.public_ip]
}

/*
output "instance_two_ip_addr" {
    value = aws_instance.web.public_ip[count.index +1]
    description = "The private IP address of the main server instance."
}
*/

output "role" {
  value       = aws_iam_instance_profile.x5324-network-diag-ssm-profile.name
  description = "The private IP address of the main server instance."
}

output "role_arn" {
  value       = aws_iam_instance_profile.x5324-network-diag-ssm-profile.arn
  description = "The private IP address of the main server instance."
}