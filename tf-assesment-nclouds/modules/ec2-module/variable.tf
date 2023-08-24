variable "name" {}
variable "environment" {}
variable "tags" {
  type    = map(string)
  default = {
    created_by = "Vignesh_Selvaraj"
  }
}



#ec2_variable
variable "keypair-name"                  {}
variable "instance_type"                 {}
variable "Public_subnet_1"               {}
variable "associate_public_ip_address"   {}
