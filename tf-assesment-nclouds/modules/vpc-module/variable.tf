variable "name" {}
variable "environment" {}
variable "tags" {
  type    = map(string)
  default = {
    created_by = "Vignesh_Selvaraj"

  }
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