resource "aws_lambda_function" "enable_kms_rotation" {
  function_name = "EnableKMSKeyRotation"
  role          = aws_iam_role.kms_lambda_exec.arn
  runtime       = "python3.12"
  handler       = "index.lambda_handler"
  timeout       = 60
  filename         = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
}
# Save this Python code in a file (e.g., `index.py`) and zip it as `lambda_function_payload.zip`
# Python code:
# import boto3
# import json
#
# def lambda_handler(event, context):
#     kms = boto3.client('kms')
#     key_id = json.loads(event['invokingEvent'])['configurationItem']['resourceId']
#     try:
#         kms.enable_key_rotation(KeyId=key_id)
#         return {"status": "Rotation enabled", "key": key_id}
#     except Exception as e:
#         return {"status": "Error", "message": str(e)}















