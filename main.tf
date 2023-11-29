module "vpc" {
  source = "git::https://github.com/rohangupta1996/tf-module-vpc.git"
  env    = var.env
  tags   = var.tags
  default_route_table = var.default_route_table
  default_vpc_id = var.default_vpc_id

  for_each      = var.vpc
  vpc_cidr      = each.value["vpc_cidr"]
  public_subnet = each.value["public_subnet"]
  private_subnet = each.value["private_subnet"]
}

module "docdb" {
  source = "git::https://github.com/rohangupta1996/tf-module-docdb.git"
  env    = var.env
  tags   = var.tags

  subnet_ids                   = local.db_subnet_ids

  for_each                     = var.docdb
  engine                       = each.value["engine"]
  engine_version               = each.value["engine_version"]
  backup_retention_period      = each.value["backup_retention_period"]
  preferred_backup_window      = each.value["preferred_backup_window"]
  skip_final_snapshot          = each.value["skip_final_snapshot"]
  no_of_instances              = each.value["no_of_instances"]
  instance_class               = each.value["instance_class"]

}


output "vpc" {
  value = local.db_subnet_ids
}
