name                         = "nClouds"
environment                  = "test"



#vpc
cidr                         = "10.0.0.0/16"
enable_dns_hostnames         =  false
enable_dns_support           =  true


#SN_values
Public_sn_cidr_1             = "10.0.0.0/24"         
Public_sn_cidr_2             = "10.0.1.0/24" 
Private_sn_cidr_1            = "10.0.2.0/24" 
Private_sn_cidr_2            = "10.0.3.0/24" 
#private_subnet_az            = "ap-south-1a"
private_subnet_az_1          = "ap-south-1a"
private_subnet_az_2          = "ap-south-1b"
public_subnet_az             = "ap-south-1b"

#RT
RT_cidr                      = "0.0.0.0/0"

#ec2

keypair-name                 = "nclouds"
instance_type                = "t2.micro"
associate_public_ip_address  =  true

#RDS


 engine               = "mysql"
 identifier           = "myrdsinstance"
 allocated_storage    = 20
 engine_version       = "8.0.33"
 instance_class       = "db.t3.micro"
 username             = "admin"
 password             = "admin123"
 skip_final_snapshot  = true
 publicly_accessible  = false
 subnet_grp_name      = "rds-sn-grp"
 rds_pg_name          = "rds-pg"
 rds_family           = "mysql8.0"