terraform {
  experiments = [variable_validation]
}

variable "name" {
  type        = string
  description = "Name that will be used in resources names and tags."
  default     = "terraform-aws-memcached-cluster"
}

variable "node_type" {
  type        = string
  description = "The Amazon ElastiCache node type."
  default     = "cache.t3.micro"

  validation {
    condition     = contains(["cache.t3.micro", "cache.t3.small", "cache.t3.medium", "cache.m5.large", "cache.m5.xlarge", "cache.m5.2xlarge", "cache.m5.4xlarge", "cache.m5.12xlarge", "cache.m5.24xlarge"], var.elasticache_instance_type)
    error_message = "Must be a valid ElastiCache node type."
  }
}

variable "vpc_id" {
  type        = string
  description = "The identifier of the VPC in which to create the security group."
}

variable "vpc_subnets" {
  type        = list(string)
  description = "A list of subnet IDs to launch resources in."
}

variable "vpc_cidr_block" {
  type        = string
  description = "The VPC CIDR IP range for security group ingress rule for access to ElastiCache cluster."

  validation {
    condition     = can(regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/(0|[1-9]|1[0-9]|2[0-9]|3[0-2]))$", var.vpc_cidr_block))
    error_message = "CIDR parameter must be in the form x.x.x.x/0-32."
  }
}
