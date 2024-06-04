output "arn" {
  value = aws_acm_certificate.cert.arn
}

output "validation" {
  value = aws_acm_certificate.cert.domain_validation_options
}
