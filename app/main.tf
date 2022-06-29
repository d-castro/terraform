module "turma08_app" {
    source          = "./modules/turma08_app"
    cidr_block      =  var.cidr_block
    vpc_name        = "turma-08"
    project         = "turma-08_modulo"
    env             = var.env
    create_zone_dns = false
}

output "ip_app" {
    value = module.turma08_app.app_public_ip
}