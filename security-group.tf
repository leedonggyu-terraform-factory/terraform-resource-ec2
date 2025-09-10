resource "aws_security_group" "ec2" {
    for_each = var.items

    name = "${each.key}-ec2-sg"
    description = "${each.key}-ec2-sg"
    vpc_id = each.value.vpc_id

    tags = {
        Name = "${each.key}-ec2-sg"
    }
}