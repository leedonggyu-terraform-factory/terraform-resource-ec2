data "aws_ami" "ec2" {
    for_each = var.items

    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["al2023-ami-2023.*-arm64"]
    }
    filter {
        name = "architecture"
        values = ["arm64"]
    }
}

resource "aws_instance" "ec2" {
    for_each = var.items

    ami = try(each.value.ami , data.aws_ami.ec2[each.key].id)
    instance_type = try(each.value.instance_type, "t4g.small")
    subnet_id = each.value.subnet_id
    vpc_security_group_ids = [aws_security_group.ec2[each.key].id]
    iam_instance_profile = aws_iam_instance_profile.ec2_profile[each.key].name

    tags = {
        Name = "${each.key}-ec2"
    }
}