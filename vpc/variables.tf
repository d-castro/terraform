variable "vpc_name" {
  type      = string
  default   = "diego"
}

variable "cidr_subnet_public" {
  type      = list(string)
  default   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "tags" {
  type = map    
  default = {
      "env" = "prod"
      "projeto" = "vpc"
    }
}