resource "tls_private_key" "this" {
  algorithm     = "RSA"
  rsa_bits      = 4096
}

resource "aws_key_pair" "this" {
  key_name      = var.keypair-name // terraform.workspace
  public_key    = tls_private_key.this.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      echo "${tls_private_key.this.private_key_pem}" > "${var.keypair-name}".pem
    EOT
  }

   tags                        =  merge(
                                   {
                                     Name        = "Terraform_Demo_KEYPAIR.${var.name}"
                                     Environment = var.environment
                                   },
                                   var.tags
                                     )
}

data "aws_ami" "latest-amazon-linux" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "my_first_instance" {
    ami           = "${data.aws_ami.latest-amazon-linux.id}"
    instance_type = "t2.micro"
    key_name                    =  aws_key_pair.this.key_name
    subnet_id                   =  var.Public_subnet_1
    associate_public_ip_address =  var.associate_public_ip_address
    tags                        =  merge(
                                   {
                                     Name        = "public_ec2.${var.name}"
                                     Environment = var.environment
                                   },
                                   var.tags
                                     )
}






#resource "aws_instance" "public_instance_module" {
#  ami                         =  var.ami
#  instance_type               =  var.instance_type
#  key_name                    =  aws_key_pair.this.key_name
#  subnet_id                   =  var.Public_subnet_1
#  #security_groups             = [var.ems_ops_public_sg]
#  associate_public_ip_address =  var.associate_public_ip_address
#  tags                        =  merge(
#                                   {
#                                     Name        = "public_ec2.${var.name}"
#                                     Environment = var.environment
#                                   },
#                                   var.tags
#                                     )
#
#}