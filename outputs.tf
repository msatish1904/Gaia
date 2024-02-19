output "public_id" {
  description = "The ID of the created public network ACL"
  value       = concat(aws_network_acl.public_nacl.*.id, [""])[0]
}

output "private_id" {
  description = "The ID of the created private network ACL"
  value       = concat(aws_network_acl.private_nacl.*.id, [""])[0]
}

output "data_id" {
  description = "The ID of the created db network ACL"
  value       = concat(aws_network_acl.data_nacl.*.id, [""])[0]
}

output "public_arn" {
  description = "The ARN of the created public network ACL."
  value       = concat(aws_network_acl.public_nacl.*.arn, [""])[0]
}

output "private_arn" {
  description = "The ARN of the created private network ACL."
  value       = concat(aws_network_acl.private_nacl.*.arn, [""])[0]
}

output "data_arn" {
  description = "The ARN of the created DB network ACL."
  value       = concat(aws_network_acl.data_nacl.*.arn, [""])[0]
}

output "associated_public_subnets" {
  description = "A list of public subnet IDs which is associated with the network ACL( must be under the given the VPC)."
  value       = concat(aws_network_acl.public_nacl.*.subnet_ids, [""])[0]
}

output "associated_private_subnets" {
  description = "A list of private subnet IDs which is associated with the network ACL( must be under the given the VPC)."
  value       = concat(aws_network_acl.private_nacl.*.subnet_ids, [""])[0]
}

output "associated_data_subnets" {
  description = "A list of DB subnet IDs which is associated with the network ACL( must be under the given the VPC)."
  value       = concat(aws_network_acl.data_nacl.*.subnet_ids, [""])[0]
}

output "vpc_id" {
  description = "The VPC ID in which the network acl is created "
  value = concat(aws_network_acl.public_nacl.*.vpc_id, [""])[0]
}