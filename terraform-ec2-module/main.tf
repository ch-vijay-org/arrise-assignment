provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  for_each = var.instances

  ami           = var.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size

    # Required only for io1/io2
    iops = contains(["io1", "io2"], each.value.volume_type) ? 3000 : null
  }

  tags = {
    Name        = each.key
    Environment = var.environment
    Owner       = var.owner
  }

  lifecycle {
    prevent_destroy = each.value.prevent_destroy
  }
}
