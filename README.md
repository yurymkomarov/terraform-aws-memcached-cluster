# AWS ElastiCache Memcached Cluster

This module provides AWS ElastiCache Cluster resources:
- AWS ElastiCache Cluster
- AWS ElastiCache subnet group
- security group

# Input variables
- `name` - Name that will be used in resources names and tags
- `node_type` - The Amazon ElastiCache node type
- `vpc_id` - The identifier of the VPC in which to create the security group
- `vpc_subnets` - A list of subnet IDs to launch resources in
- `vpc_cidr_block` - The VPC CIDR IP range for security group ingress rule for access to AWS EFS storage

# Output variables
- `elasticache_cluster`
    - `cache_nodes` - List of node objects including `id`, `address`, `port` and `availability_zone`
    - `configuration_endpoint` - The configuration endpoint to allow host discovery
    - `cluster_address` - The DNS name of the cache cluster without the port appended
- `security_group`
    - `id` - The ID of the security group
    - `arn` - The ARN of the security group
    - `vpc_id` - The VPC ID
    - `owner_id` - The owner ID
    - `name` - The name of the security group
    - `description` - The description of the security group
    - `ingress` - The ingress rules
    - `egress` - The egress rules
