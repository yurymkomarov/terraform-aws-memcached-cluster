resource "random_id" "this" {
  byte_length = 1

  keepers = {
    vpc_subnets = join("", var.vpc_subnets)
  }
}

resource "aws_elasticache_cluster" "this" {
  az_mode           = "cross-az"
  node_type         = var.node_type
  subnet_group_name = aws_elasticache_subnet_group.this.id
  engine            = "memcached"
  num_cache_nodes   = length(var.vpc_subnets)
  cluster_id        = "${var.name}-${random_id.this.hex}"

  tags = {
    Name      = var.name
    Module    = path.module
    Workspace = terraform.workspace
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.name}-${random_id.this.hex}"
  subnet_ids = var.vpc_subnets

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "this" {
  name        = "${var.name}-${random_id.this.hex}"
  description = "Security groups for ${var.name}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.name
    Module    = path.module
    Workspace = terraform.workspace
  }

  lifecycle {
    create_before_destroy = true
  }
}
