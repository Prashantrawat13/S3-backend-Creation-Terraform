output "S3-bucket-name" {
  value       = aws_s3_bucket.s3-backend-30-11.bucket
  description = "The name of the S3 bucket created"
}

output "S3-object-key" {
  value       = aws_s3_object.State-File.key
  description = "The key of the S3 object created for the state file"
}