output "ec2_id" {
  value = {
    for k, v in aws_instance.ec2 : k => v.id
  }
}

output "ec2_public_ip" {
  value = {
    for k, v in aws_instance.ec2 : k => v.public_ip
  }
}

output "ec2_private_ip" {
  value = {
    for k, v in aws_instance.ec2 : k => v.private_ip
  }
}

output "ec2_sg_ids" {
  value = {
    for k, v in aws_security_group.ec2 : k => v.id
  }
}
