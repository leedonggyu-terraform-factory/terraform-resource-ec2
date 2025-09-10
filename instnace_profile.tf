resource "aws_iam_role" "ec2_role" {
    for_each = var.items

    name = "${each.key}-ec2-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

// attach ssmcore
resource "aws_iam_role_policy_attachment" "ssmcore" {
    for_each = var.items
    role = aws_iam_role.ec2_role[each.key].name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_profile" {
    for_each = var.items

    name = "${each.key}-ec2-profile"
    role = aws_iam_role.ec2_role[each.key].name
}
  