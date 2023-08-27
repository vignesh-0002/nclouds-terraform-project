# Nclouds-tf-assessment
In this section, we  how to create an EC2 and RDS using Terraform.
 
### This project includes:
* How to create a VPC and its components.
* How to create an EC2 and RDS using the vpc we have created.
* Also we are going to create a s3 bucket and Dynamodb for setting up a remote backend.

### Terraform code overview:
* In this terraform we have applied the concepts like modules, variables, tfvars, etc..  for code reusablity.

## 1. TF_Provider
A provider in Terraform is a plugin that enables interaction with an API. This includes Cloud providers and Software-as-a-service providers. The providers are specified in the Terraform configuration code. They tell Terraform which services it needs to interact with.

In our case we are using AWS cloud platform so out provider will look like the following script.

```
#provider

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
```
* In this code we have provide the terraform provider as AWS,
And the version as 5.0.
* Also we have provided AWS secrets as profile, and our AWS region.

## 2. Module Structure


```
$ tree complete-module/
.
├── README.md
├── main.tf
├── variables.tf
├── demo.tfvars
├── provider.tf
├── ...
├── modules/
│   ├── ec2/
│   │   ├── variables.tf
│   │   ├── ec2.tf
│   │   
│   │   
│   ├── VPC/
    ├── ├── output.tf
    ├── ├── subnet.tf
    ├── ├── RT.tf
    ├── ├── vpc.tf
    ├── ├── variable.tf 
│   ├── RDS/
        ├── RDS.tf
        ├── variable
```
##### 2.1 Why are we going for a module concept?
- When the infrastructure as code grows high in volume and more repeated resources are being written then we have to organize and optimize them. So this is the reason to use `modules`

#### 2.2 What are those high volume and repeated resources mean ?
- high volume ie, when we are at the end of our project we will be ending up by creating categories of resources such as Network, Compute, Database, Storage, IAM, etc. And each of this category has sereval resource so we are designing our IaC such a way that we create abstracts for each category of resource
- repeated resources ie, we will be ending up creating multiple ec2 machines, iam roles, buckets etc. Inorder to not to repeat the `resource` and its dependent blocks every time we need the same type of resource we are modularizing the resources

## 3. Let's see how to execute the TF script we have.

* On the above module structure our resource state file is going to be in the local, but our requirement is a remote backup. 
* so we are going to create a S3 bucket and a Dynamodb and going to setup a remort backup using the following steps:

We going to create a S3 and dynamodb manually which is going to be out the remote backend of our statefile.

#### 3.1 s3 and dynamo db creation
* You can use this script for creating S3 bucket and dynamodb in a separate terraform file or you can create resources manually.
* I am going to use this script in a separate terraform file.
  
```
#s3 bucket creation
resource "aws_s3_bucket" "statebackend" {
  bucket    = var.s3_bucketname
  versioning {
    enabled = true
  }
   server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }
    }

#create dynamo db

resource "aws_dynamodb_table" "state_lock" {
   name                     = var.Dynamodb_name        
   billing_mode             = "PAY_PER_REQUEST"  
   hash_key                 = "LockID"
   attribute {
       name                 = "LockID"
       type                 = "S"
   }

```

* After creating the S3 and dynamodb we are going to update our provider script to setup a remote backup.

```
backend "s3" {
  bucket               = "tfstate-backup-vignesh"
  dynamodb_table       = "tf-lock"
  key                  = "demo/tf.tfstate"
  region               = "ap-south-1"
  profile              = "737584674007_training" 
  encrypt              = true
}
```

* Bucket is nothing but the name of the s3 bucket we have created.
* Dynamodb_table is the name of the table we have created.
* Also need to provide the AWS region and the AWS profile, Also we need to encrypt the file or not?
* After updating the above block the backend.tf file will look like the following code block.

```
terraform {
  
backend "s3" {
  bucket               = "tfstate-backup-vignesh"
  dynamodb_table       = "tf-lock"
  key                  = "demo/tf.tfstate"
  region               = "ap-south-1"
  profile              = "737584674007_training" 
  encrypt              = true
}
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
```

> Now we are going to initialize the working directory containing Terraform configuration files.

 > use this command to apply our code -- terraform apply -var-file="demo.tfvars"

 * Now you may ask why we are using this  tfvars file.

#### 3.2 what is *.tfvars?

* Terraform allows you to define variable files called *. tfvars to create a reusable file for all the variables for a project.

* The difference between variable and tfvars is, that variables.tf is where you declare your variables, while terraform. tfvars is where you assign values to those variables. In other words, variables.tf is like a form that needs to be filled out and terraform.

###  Understood *.tfvars, Correct !!!

* Now let's back to our topic, We have applied the code that is going to create a VPC, EC2, and RDS.
* Once after applying the code it will spin up the resources we have configured in our code.
* The architecture of the resources we create will look like the image attached below. 

#### 3.3 Architecture diagram of the code we design should look like this:
 
![Screenshot from 2023-08-25 13-33-40](https://github.com/Vignesh2k21/Nclouds-tf-assesment/assets/87553373/55b39363-bdfb-4d49-808d-9b272e50116f)


#### 3.4 Cleaning up!

* For cleaning up the environment we can migrate the state from s3 to local For that we need to mute the following from the provider,


```
backend "s3" {
  bucket               = "tfstate-backup-vignesh"
  dynamodb_table       = "tf-lock"
  key                  = "demo/tf.tfstate"
  region               = "ap-south-1"
  profile              = "737584674007_training" 
  encrypt              = true
}
```

* Then use the following command
```terraform init -migrate-state```

* Now use terraform destroy command 
```terraform destroy -var-file="demo.tfvars" ```

* Now all the resources will be destroyed except the S3 we need to clean up the bucket and we can destroy the bucket.

# That's it for this Hands-on! 
