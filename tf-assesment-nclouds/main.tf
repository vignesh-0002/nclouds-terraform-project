#module "vpc"{
#       source                       = "./modules/vpc-module"
#       cidr                         = var.cidr
#       enable_dns_hostnames         = var.enable_dns_hostnames
#       enable_dns_support           = var.enable_dns_support
#
#       name                         = var.name
#       environment                  = var.environment
#      
#       
#       
#       Public_sn_cidr_1             = var.Public_sn_cidr_1
#       Public_sn_cidr_2             = var.Public_sn_cidr_2
#       Private_sn_cidr_1            = var.Private_sn_cidr_1
#       Private_sn_cidr_2            = var.Private_sn_cidr_2
#       public_subnet_az             = var.public_subnet_az
#       private_subnet_az_1          = var.private_subnet_az_1
#       private_subnet_az_2          = var.private_subnet_az_2
#       RT_cidr                      = var.RT_cidr 
#}
#
#module "ec2"{
#         source = "./modules/ec2-module"
#
#         name                         = var.name
#         environment                  = var.environment
#       
#
#         Public_subnet_1              = module.vpc.public_subnet_1
#
#         keypair-name                 = var.keypair-name
#         instance_type                = var.instance_type
#         associate_public_ip_address  = var.associate_public_ip_address
#         
#}
#
#module "RDS" {
#         source               = "./modules/rds-module"
#         subnet_grp_name      = var.subnet_grp_name
#         engine               = var.engine
#         identifier           = var.identifier
#         allocated_storage    = var.allocated_storage
#         engine_version       = var.engine_version
#         instance_class       = var.instance_class
#         username             = var.username
#         password             = var.password
#         skip_final_snapshot  = var.skip_final_snapshot
#         publicly_accessible  = var.publicly_accessible
#         Private_subnet_1     = module.vpc.private_subnet_1
#         Private_subnet_2     = module.vpc.private_subnet_2
#         rds_pg_name          = var.rds_pg_name
#         rds_family           = var.rds_family
#}