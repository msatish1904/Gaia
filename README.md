## Introduction

Terraform module which creates Network ACL resources on your AWS account.

## Description

Provision [Network ACL](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) and its [inbound outbound rules]( https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html )

This module provides recommended settings:

- Creates multiple Network ACLs ( public, private and database) as required
- Creates multiple inbound and outbound rules


## Installation

```shell

git clone https://git.altimetrik.com/bitbucket/scm/cloudauto/tf-mod-nacl.git
cd tf-mod-nacl

Update with required and appropriate details in the respective field 

```
## To run this example you need to execute below

To initialize the Terraform directory, run the following command:
```hcl
terraform init
```
To generate an execution plan, run the following command:
```hcl
terraform plan
```
To apply the execution plan, run the following command:
```hcl
terraform apply
```
Note that this example may create resources which cost money. Run ``` terraform destroy``` when you don't need these resources.

Requirements

| Name      | Version    |
| --------- |------------|
| terraform | `>= 1.4.6` |
# Inputs

| Name                       | Description                                                                             | Type              | Default  | Required |
|----------------------------|-----------------------------------------------------------------------------------------|-------------------|----------|:--------:|
| region                     | Location of network acls                                                                | `string`          | "us-east-1" |   yes    |
| name                       | Desired name for the network ACL resources                                              | `string`          | ""       |   yes    |
| vpc_id                     | The ID of the associated VPC.                                                           | `string`          | ""       |   yes    |
| public_subnet_ids          | A list of public subnet IDs to apply the ACL to                                         | `list(string)`    | ""       |   yes    |
| private_subnet_ids         | A list of private subnet IDs to apply the ACL to                                        | `list(string)`    | []       |   yes    |
| data_subnet_ids              | A list of database subnet IDs to apply the ACL to                                       | `list(string)`    | []       |   yes    |
| public_network_acl         | Whether to use dedicated network ACL (not default) and custom rules for public subnet   | `bool`            | `true`   |   yes    |
| private_network_acl        | Whether to use dedicated network ACL (not default) and custom rules for private subnet  | `bool`            | `true`   |   yes    |
| data_network_acl             | Whether to use dedicated network ACL (not default) and custom rules for database subnet | `bool`            | `true`   |   yes    |
| public_inbound_acl_rules   | inbound rules for public subnets network ACLs                                           | `list(map(string))`| `[]`     |   yes    |
| private_inbound_acl_rules  | inbound rules for private subnets network ACLs                                          | `list(map(string))` | `[]`     |   yes    |
| data_inbound_acl_rules       | inbound rules for database subnets network ACLs                                         | `list(map(string))` | `[]`     |   yes    |
| public_outbound_acl_rules  | outbound rules for public subnets network ACLs                                          | `list(map(string))` | `[]`     |   yes    |
| private_outbound_acl_rules | outbound rules for public subnets network ACLs                                          | `list(map(string))` | `[]`     |   yes    |
| data_outbound_acl_rules      | outbound rules for public subnets network ACLs                                          | `list(map(string))` | `[]`     |   yes    |
| tags                       | Common baseline tags. List of tags can be found in the module example below             | `map(string)`     | {}       |   yes    |  

# Example of module usage (nacl.tf)
`To create Network ACL`
### `NOTE : Below given is just a reference, please update the details and rules as per your requirements.`
```hcl
module "nacl" {
  source                = "git::https://git.altimetrik.com/bitbucket/scm/cloudauto/tf-mod-nacl.git?ref=master"
  region                = "us-east-1"
  vpc_id                = "vpc-0xxxxxxxxxxxxx7"
  public_subnet_ids     = ["subnet-0aaaaaaaaaaaaa90", "subnet-0fbbbbbbbbbbbbbb2"]
  private_subnet_ids    = ["subnet-06ccccccccccc4c", "subnet-0dddddddddddddd6a"]
  data_subnet_ids         = ["subnet-05eeeeeeeeeeeeeeee4c", "subnet-0fffffffffffffff7"]
  name                  = "nacl"

  public_network_acl    = "true"
  private_network_acl   = "true"
  data_network_acl      = "true"

  ##Sample NACL rules##
  public_inbound_acl_rules = [
    {
    protocol    = "all"
    rule_number = 100
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
#    from_port   = 80
#    to_port     = 80
   },
    {
    protocol    = "tcp"
    rule_number = 101
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
  }
  ]

  public_outbound_acl_rules = [
    {
    protocol    = "all"
    rule_number = 100
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
#    from_port   = 443
#    to_port     = 443
  },
  {
    protocol    = "tcp"
    rule_number = 101
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 8080
    to_port     = 8080
  }
  ]
  
  private_inbound_acl_rules = [
    {
    protocol    = "tcp"
    rule_number = 100
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
   }
  ]

 private_outbound_acl_rules = [
    {
    protocol    = "tcp"
    rule_number = 101
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 8000
    to_port     = 8000
   }
  ]
  
  data_inbound_acl_rules = [
    {
    protocol    = "tcp"
    rule_number = 100
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 3306
    to_port     = 3306
   }
  ]
  
  data_outbound_acl_rules = [
    {
    protocol    = "tcp"
    rule_number = 100
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 3306
    to_port     = 3306
   }
  ]

  tags = {
    "Project"     = ""     ## The name of the project that the resource is used for.
    "Application" = ""     ## The name of the application or feature of that the resource belongs to.
    "Owner"       = ""     ## The email address of the person or team that owns the resource (@altimetrik.com)
    "Environment" = ""     ## The environment in which the resource is used. Allowed values are "Test", "QA", "Staging", "Development", "Non-Prod", "Sandbox", "UAT", "Prod"
  }
}

## Terraform backend block to manage state files
terraform {
  backend "s3" {
    bucket         = ""   ## Provide the S3 bucket name created for storing the state files
    key            = ""   ## Name of the object to store the state file Ex: nacl.tfstate
    region         = ""   ## S3 bucket region
    encrypt        = "true"
    dynamodb_table = ""   ## Name of the DynamoDB table
  }
}
```


## Example outputs.tf to export the outputs

```hcl
output "public_id" {
  description = "The ID of the created public network ACL"
  value       = module.nacl.public_id
}

output "private_id" {
  description = "The ID of the created private network ACL"
  value       = module.nacl.private_id
}

output "data_id" {
  description = "The ID of the created DB network ACL"
  value       = module.nacl.data_id
}

output "public_arn" {
  description = "The ARN of the created public network ACL."
  value       = module.nacl.public_arn
}

output "private_arn" {
  description = "The ARN of the created private network ACL."
  value       = module.nacl.private_arn
}

output "data_arn" {
  description = "The ARN of the created DB network ACL."
  value       = module.nacl.data_arn
}

output "associated_public_subnets" {
  description = "A list of public subnet IDs which is associated with the network ACL( must be under the given the VPC)."
  value       = module.nacl.associated_public_subnets
}

output "associated_private_subnets" {
  description = "A list of private subnet IDs which is associated with the network ACL( must be under the given the VPC)."
  value       = module.nacl.associated_private_subnets
}

output "associated_data_subnets" {
  description = "A list of DB subnet IDs which is associated with the network ACL( must be under the given the VPC)."
  value       = module.nacl.associated_data_subnets
}

output "vpc_id" {
  description = "The VPC ID in which the network acl is created "
  value = module.nacl.vpc_id
}
```

## Outputs


| Name                       | Description                                                                                              |
|----------------------------|----------------------------------------------------------------------------------------------------------|
| public_id                  | The ID of the created public network ACL                                                                 |
| private_id                 | The ID of the created private network ACL                                                                |
| data_id                    | The ID of the created database network ACL                                                               |
| public_arn                 | The ARN of the created public network ACL.                                                               |
| private_arn                | The ARN of the created private network ACL.                                                              |
| data_arn                   | The ARN of the created database network ACL.                                                             |
| associated_public_subnets  | A list of public subnet IDs which is associated with the network ACL( must be under the given the VPC)   |
| associated_private_subnets | A list of private subnet IDs which is associated with the network ACL( must be under the given the VPC)  |
| associated_data_subnets    | A list of database subnet IDs which is associated with the network ACL( must be under the given the VPC) |
| vpc_id                     | The VPC ID in which the network acl is created                                                           |



| Version    | Description                              |
| --------- |------------------------------------------|
| 1.0.0     | Initial version of Network ACL resources |
-----------------------------------------
