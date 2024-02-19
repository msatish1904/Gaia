variable "region"{
  description = "Location of network acls"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Desired name for the network ACL resources."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the associated VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs to apply the ACL to."
  type        = list(string)
  default     = []
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs to apply the ACL to."
  type        = list(string)
  default     = []
}

variable "data_subnet_ids" {
  description = "A list of database subnet IDs to apply the ACL to."
  type        = list(string)
  default     = []
}

variable "public_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for public subnets"
  type        = bool
  default     = true
}

variable "private_network_acl" {
  description = "Whether to use dedicated private network ACL (not default) and custom rules for private subnets"
  type        = bool
  default     = true
}

variable "data_network_acl" {
  description = "Whether to use dedicated database network ACL (not default) and custom rules for database subnets"
  type        = bool
  default     = true
}

variable "public_inbound_acl_rules" {
  description = "inbound rules for public subnets network ACLs"
  type        = list(map(string))
}

variable "private_inbound_acl_rules" {
  description = "inbound rules for private subnets network ACLs"
  type        = list(map(string))
}

variable "data_inbound_acl_rules" {
  description = "inbound rules for database subnets network ACLs"
  type        = list(map(string))
}


variable "public_outbound_acl_rules" {
  description = "outbound rules for public subnets network ACLs"
  type        = list(map(string))
}

variable "private_outbound_acl_rules" {
  description = "outbound rules for private subnets network ACLs"
  type        = list(map(string))
}

variable "data_outbound_acl_rules" {
  description = "outbound rules for database subnets network ACLs"
  type        = list(map(string))
}

variable "tags" {
  
  description = "Any tags that should be present on the resources."
  type        = map(string)
  default     = {}
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# variable "vpc_cidr" {
#   description = "CIDR block for the VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "enable_dns_hostnames" {
#   description = "Enable DNS hostnames for the VPC"
#   type        = bool
#   default     = false
# }

# variable "enable_dns_support" {
#   description = "Enable DNS support for the VPC"
#   type        = bool
#   default     = true
# }

# variable "tenancy" {
#   description = "Tenancy option for the VPC"
#   type        = string
#   default     = "default"
# }