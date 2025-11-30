// s3 backend creation 

/*
terraform {
  backend "s3" {
    bucket  = "s3-backend-30-11"             # Name of the S3 bucket
    key     = "State-File/terraform.tfstate" # Path to state file in the S3 bucket
    region  = "ap-south-1"
    encrypt = true
  }
}
*/


// End of s3 backend creation

# To access the Above S3 backend creation code, remove the comment syntax (/*):in line 3 and (*/): in line 12.