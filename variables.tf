variable "aws_access_key" {
  description = "The AWS access key."
}
variable "aws_secret_key" {
  description = "The AWS secret key."
}

variable "ssh_key_name" {
  description = "The aws ssh key name."
  default = ""
}
variable "ssh_key_file" {
  description = "The ssh public key for using with the cloud provider."
  default = ""
}

variable "region" {
  description = "The AWS region to create resources in."
  default = "eu-central-1"
}
variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}


/* ECS Cluster config */
variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default = "test"
}

variable "ecs_amis" {
  default = {
    eu-central-1 = "ami-e012d48f"
  }
}

variable "ecs_instance_type" {
  default = "t2.micro"
}

variable "ecs_autoscale_min" {
    default = "1"
    description = "Minimum autoscale (number of EC2)"
}
variable "ecs_autoscale_max" {
    default = "10"
    description = "Maximum autoscale (number of EC2)"
}
variable "ecs_autoscale_desired" {
    default = "4"
    description = "Desired autoscale (number of EC2)"
}
