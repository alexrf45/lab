output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.site.id
}


output "domain_name" {
  description = "Website endpoint"
  value       = aws_s3_bucket_website_configuration.site.website_endpoint
}


output "validation" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = flatten(module.certs.validation)
}

output "arn" {
  value = module.certs.arn
}


