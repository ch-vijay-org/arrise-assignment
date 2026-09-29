variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "owner" {
  description = "Resource owner"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instances" {
  description = "Map of EC2 instances"

  type = map(object({
    instance_type = string
    key_name      = string
    volume_type   = string
    volume_size   = number
    prevent_destroy = optional(bool, false)
  }))
}
