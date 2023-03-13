module "acm" {
  source                                 = "./acm"
  domain_name                            = var.domain_name
  fqdn_name                              = local.fqdn.web_name
  cloudfront_distribution_domain_name    = module.s3.cloudfront_distribution_domain_name
  cloudfront_distribution_hosted_zone_id = module.s3.cloudfront_distribution_hosted_zone_id
  providers = {
    aws = aws.virginia
  }
}

module "s3" {
  source             = "./s3"
  fqdn_name          = local.fqdn.web_name
  bucket_name        = local.bucket.name
  acm_certificate_id = module.acm.acm_certificate_id
}


# =================
# S3 Object Update
# =================
module "distribution_files" {
  source   = "hashicorp/dir/template"
  base_dir = "../frontend/react-app/build"
}

resource "aws_s3_object" "multiple_objects" {
  for_each     = module.distribution_files.files
  bucket       = module.s3.s3_bucket_web_id
  key          = each.key
  source       = each.value.source_path
  content_type = each.value.content_type
  etag         = filemd5(each.value.source_path)
}
