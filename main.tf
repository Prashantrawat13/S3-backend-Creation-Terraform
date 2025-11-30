resource "aws_s3_bucket" "Buckets3" {
  bucket = "bucket17112025" # Name of the S3 bucket
  region = "ap-south-1"

  tags = {
    Name = "Terraform_s3_bucket"
  }
}

resource "aws_s3_object" "State-File" {
  bucket = aws_s3_bucket.bucket17112025.bucket # Reference to the S3 bucket created above
  key    = "State-File/file/terraform.tfstate" # Path to the state file in the S3 bucket


  depends_on = [aws_s3_bucket.bucket17112025]
}