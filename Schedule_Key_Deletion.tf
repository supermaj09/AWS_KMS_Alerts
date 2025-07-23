resource "aws_cloudwatch_log_metric_filter" "kms_deletion_filter" {
  name           = "kms_key_deletion_filter"
  log_group_name = "/aws/cloudtrail/kms"
  pattern        = "{ ($.eventName = \"ScheduleKeyDeletion\") }"
  metric_transformation {
    name      = "KeyDeletionAttempt"
    namespace = "KMSMonitoring"
    value     = "1"
  }
}
resource "aws_cloudwatch_metric_alarm" "kms_key_deletion_alarm" {
  alarm_name          = "KMSKeyDeletionAttempt"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "KeyDeletionAttempt"
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











