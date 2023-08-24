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
}