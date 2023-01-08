resource "aws_s3_bucket" "ventura_bucket" {
    bucket = "prod-proxy-app-db-config-dare-8042"

}
resource "aws_s3_bucket_acl" "ventura_bucket_acl" {
  bucket = aws_s3_bucket.ventura_bucket.id
  acl = "private"
}
resource "aws_s3_bucket_versioning" "ventura_bucket_versioning" {
    bucket = aws_s3_bucket.ventura_bucket.id
    versioning_configuration {
      status = "Enabled"
    }  
}
resource "aws_s3_bucket_public_access_block" "ventura_object_block" {
  bucket = aws_s3_bucket.ventura_bucket.id
  block_public_acls       = true  
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}