locals {
  name    = "5324-network-diag"
  preprod = "ppe"

  tags = {
    project     = local.name
    project_id  = "5324"
    Environment = var.envirenment
  }

  IsDev                   = var.envirenment == "Development" ? 1 : 0
  create_internet_gateway = var.number_of_instances > 0 ? true : false
}

variable "envirenment" {
  type        = string
  description = "Name of envirenment that we deploy"
}

variable "policies" {
  type = map(string)
  default = {
    "AmazonSSMManagedInstanceCore" = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    #"AmazonSSMManagedInstanceCore" = "arn:aws:iam::aws:policy/PUT_THE_PREMISSION OF YOUR CHOOSE"
  }
}

variable "instance_type" {
  type        = string
  description = "Type of the instance"
}

variable "number_of_instances" {
  type        = number
  description = "Number of instance to create"
}

variable "vpc_sub_id" {
  type        = string
  description = "Copy vpc id from console"
}

variable "subnet_id" {
  type        = string
  description = "Copy subnet id from console"
}

variable "vpc_id" {
  type        = string
  description = "(optional) describe your variable"
}