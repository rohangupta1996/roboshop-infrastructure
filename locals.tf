locals {
  ##Private Subnet
  #private_subnet_ids = { for k, v in module.vpc["main"].private_subnet : k => tomap({"id" = v.id, "availability_zone" = v.availability_zone}) }
  #private_subnet_ids = [for k, v in module.vpc["main"].private_subnet : v.id]
  db_subnet_ids = tolist([module.vpc["main"].private_subnet["db-az1"].id, module.vpc["main"].private_subnet["db-az2"].id])
}
