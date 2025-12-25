resource "aws_security_group" "ec2" {
  for_each = var.items

  name        = "${each.key}-ec2-sg"
  description = "${each.key}-ec2-sg"
  vpc_id      = each.value.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "${each.key}-ec2-sg"
  }

  lifecycle {
    ignore_changes = [ingress]
  }
}
