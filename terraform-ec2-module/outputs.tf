output "instance_ids" {
  description = "Map of instance name to instance ID"

  value = {
    for name, instance in aws_instance.ec2 :
    name => instance.id
  }
}
output "private_ips" {
  description = "Map of instance name to private IP"

  value = {
    for name, instance in aws_instance.ec2 :
    name => instance.private_ip
  }
}
