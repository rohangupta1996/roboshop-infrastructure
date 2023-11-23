module "vpc" {
  source = "git::https://github.com/rohangupta1996/tf-module-vpc.git"
  env    = var.env
  tags   = var.tags

  for_each      = var.vpc
  vpc_cidr      = each.value["vpc_cidr"]
  public_subnet = each.value["public_subnet"]
  private_subnet = each.value["private_subnet"]
}