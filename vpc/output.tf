output "arns_vpc"{
 value = module.vpc.public_subnet_arns
}

output "subnet"{
 value = var.cidr_subnet_public[1]
}

output "env"{
 value = var.tags["env"]
}