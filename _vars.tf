variable "region" {
  default = "ap-northeast-2"
}

variable "backend_s3" {
  default = "devops-tf-backend-dc"
}

variable "vpc_key" {
  default = "vpc/terraform.tfstate"
}

variable "tags" {}
variable "env" {}
variable "name" {}
variable "owner" {}

variable "cluster_version" {}
variable "cluster_endpoint_private_access" {}
variable "cluster_endpoint_public_access" {}

variable "worker_instance_type" {}
variable "worker_instance_count" {}
variable "worker_key_name" {}

variable "trusted_role_services" {}
variable "custom_role_policy_arns" {}
variable "additional_policy_actions" {}
variable "enable_irsa" {}