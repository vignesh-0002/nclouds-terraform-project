terraform {
  
#backend "s3" {
#  bucket               = "tfstate-backup-vignesh"
#  dynamodb_table       = "tf-lock"
#  key                  = "demo/tf.tfstate"
#  region               = "ap-south-1"
#  profile              = "737584674007_training" 
#  encrypt              = true
#}
  required_providers {
    aws                  = {
                             source  = "hashicorp/aws"
                             version = "~> 5.0"
                           }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile                = "737584674007_training" 
  region                 = "ap-south-1"
}
