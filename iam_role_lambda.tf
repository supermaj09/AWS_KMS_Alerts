resource "aws_iam_role" "kms_lambda_exec" {
  name = "kms-lambda-remediation-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })
}
resource "aws_iam_policy" "kms_rotation_policy" {
  name = "KMSRotationPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["kms:EnableKeyRotation", "kms:DescribeKey"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "kms_rotation_attach" {
  role       = aws_iam_role.kms_lambda_exec.name
  policy_arn = aws_iam_policy.kms_rotation_policy.arn
}









