locals {
  ##Private Subnet
  private_subnet_ids = { for k, v in module.vpc["main"].private_subnet : k => v.id }
}
