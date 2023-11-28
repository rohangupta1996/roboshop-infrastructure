locals {
  ##Private Subnet
  #private_subnet_ids = { for k, v in module.vpc["main"].private_subnet : k => tomap({"id" = v.id, "availability_zone" = v.availability_zone}) }
  #private_subnet_ids = [for k, v in module.vpc["main"].private_subnet : v.id]
  db_subnet_ids = tolist([module.vpc["main"].private_subnet["db-az1"].id, module.vpc["main"].private_subnet["db-az2"].id])
  app_subnet_ids = tolist([module.vpc["main"].private_subnet["app-az1"].id, module.vpc["main"].private_subnet["app-az2"].id])
  web_subnet_ids = tolist([module.vpc["main"].private_subnet["web-az1"].id, module.vpc["main"].private_subnet["web-az2"].id])
}
