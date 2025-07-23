resource "aws_config_remediation_configuration" "kms_rotation_remediation" {
  config_rule_name = "kms-key-rotation-enabled"
  target_id        = aws_lambda_function.enable_kms_rotation.arn
  target_type      = "LAMBDA"

  parameter {
    name = "ResourceId"

    static_value = {
      values = ["RESOURCE_ID"]
    }
  }

  automatic                   = true
  maximum_automatic_attempts = 1
  retry_attempt_seconds       = 60
}
