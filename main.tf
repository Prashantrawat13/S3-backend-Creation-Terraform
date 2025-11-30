resource "aws_s3_bucket" "s3-backend-30-11" {
  bucket = "s3-backend-30-11" # Name of the S3 bucket
  region = "ap-south-1"

  tags = {
    Name = "s3-backend-30-11"
  }
}

resource "aws_s3_object" "State-File" {
  bucket = aws_s3_bucket.s3-backend-30-11.bucket # Reference to the S3 bucket created above
  key    = "State-File/terraform.tfstate"        # Path to the state file in the S3 bucket


  depends_on = [aws_s3_bucket.s3-backend-30-11]
}