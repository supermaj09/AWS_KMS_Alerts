resource "aws_cloudwatch_log_metric_filter" "key_policy_change" {
  name           = "kms_key_policy_change"
  log_group_name = "/aws/cloudtrail/kms"
  pattern        = "$.eventName = \"PutKeyPolicy\""
  metric_transformation {
    name      = "KeyPolicyChanged"
    namespace = "KMSMonitoring"
    value     = "1"
  }
}
resource "aws_cloudwatch_metric_alarm" "key_policy_change_alarm" {
  alarm_name          = "KMSKeyPolicyChanged"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "KeyPolicyChanged"
  namespace           = "KMSMonitoring"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.kms_alerts.arn]
}
resource "aws_sns_topic" "kms_alerts" {
  name = "kms-alert-topic"
}
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.kms_alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"
}















