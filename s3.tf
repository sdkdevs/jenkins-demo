resource "aws_s3_bucket" "mfreccia_s3_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"
  tags = var.tags
}

resource "aws_instance" {}
