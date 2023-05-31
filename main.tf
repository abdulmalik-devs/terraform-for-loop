# Data source for aws vpc
data "aws_vpc" "default_vpc" {
  default = true
}

# Data source for subnets
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

# Ec2
resource "aws_instance" "ec2_instances" {
  for_each = { for index, instance_type in var.instance_types : index => instance_type }

  ami                     = "ami-007855ac798b5175e"  # Replace with your desired AMI ID
  instance_type           = each.value
  subnet_id               = data.aws_subnets.subnets.ids[each.key]
  vpc_security_group_ids  = [aws_security_group.instance_sg[each.key].id]
  tags = {
    Name = "EC2-${each.value}"
  }
}

# Create security groups with different rules
resource "aws_security_group" "instance_sg" {
  for_each = { for idx, rule in var.security_group_rules : idx => rule }

  name        = "instance_sg_${each.key + 1}"
  description = "Instance Security Group ${each.key + 1}"
 
  ingress {
    from_port   = each.value.port
    to_port     = each.value.port
    protocol    = each.value.protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
