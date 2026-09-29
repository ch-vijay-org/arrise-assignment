environment = "dev"

owner = "DevOpsTeam"

ami_id = "ami-0abcdef1234567890"

instances = {

  web01 = {
    instance_type   = "t3.micro"
    key_name        = "web-key"
    volume_type     = "gp3"
    volume_size     = 20
    prevent_destroy = false
  }

  app01 = {
    instance_type   = "t3.small"
    key_name        = "app-key"
    volume_type     = "gp2"
    volume_size     = 30
    prevent_destroy = false
  }

  db01 = {
    instance_type   = "m5.large"
    key_name        = "db-key"
    volume_type     = "io2"
    volume_size     = 100
    prevent_destroy = true
  }

  cache01 = {
    instance_type   = "t3.medium"
    key_name        = "cache-key"
    volume_type     = "gp3"
    volume_size     = 40
    prevent_destroy = false
  }

  jumpbox01 = {
    instance_type   = "t3.nano"
    key_name        = "jumpbox-key"
    volume_type     = "gp3"
    volume_size     = 10
    prevent_destroy = false
  }
}
