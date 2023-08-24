variable "name" {}
variable "environment" {}
variable "s3_bucketname" {
  type    = string
  default = "tfstate-backup-vignesh"
}
variable "Dynamodb_name" {
  type    = string
  default = "tf-lock"
}
#subnet
variable "Public_sn_cidr_1"    {}
variable "Public_sn_cidr_2"    {}
variable "Private_sn_cidr_1"   {}
variable "Private_sn_cidr_2"   {}
variable "private_subnet_az_1" {}
variable "private_subnet_az_2" {}
variable "public_subnet_az"    {}

#vpc_variable
variable "cidr"                 {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support"   {}

#RT_variable
variable "RT_cidr" {}

#ec2_variable
variable "keypair-name"                  {}
variable "instance_type"                 {}
variable "associate_public_ip_address"   {}


#RDS
variable "subnet_grp_name"      {}
variable "engine"               {}                    
variable "identifier"           {}                    
variable "allocated_storage"    {}                    
variable "engine_version"       {}                    
variable "instance_class"       {}                    
variable "username"             {}                    
variable "password"             {}                   
variable "skip_final_snapshot"  {}                    
variable "publicly_accessible"  {}                    
variable "rds_pg_name"          {} 
variable "rds_family"           {} 