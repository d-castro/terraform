variable "instance_type" {
  type = map(any)
  default = {
    dev  = "t2.small"
    qa   = "t3.small"
    prod = "t3.medium"
  }
}

variable "env" {
  type    = string
  default = "dev"
}

variable "project" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "cidr_block2" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "app_docker" {
  type = map(any)
  default = {
    tag   = "1.0.0"
    port  = "8000"
    image = "skacko-api"
  }
}






variable "instance_count" {
  type = map(any)
  default = {
    dev  = "1"
    qa   = "2"
    prod = "4"
  }
}

variable "instance_type_mongodb" {
  type    = string
  default = "t2.small"
}



variable "mongodb_version" {
  type    = string
  default = "5.0.2"
}



variable "create_zone_dns" {
  type    = bool
  default = true
}

