module "asg" {
    source          = "./modules/asg"
    cidr_block      = var.cidr_block
    cidr_block2     = var.cidr_block2
    vpc_name        = "turma-08"
    project         = "turma-08-diego"
    env             = var.env
}