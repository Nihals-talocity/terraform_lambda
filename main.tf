resource "aws_iam_role" "handler_lambda" {
  name = "handler-lambda"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "handler_lambda_policy" {
  role       = aws_iam_role.handler_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "handler" {
  function_name = "handler"

 
  s3_bucket = "jdhandler"
  s3_key    = "Jdhandler.zip"

  runtime = "python3.9"
  handler = "lambda_function.lambda_handler"

 # source_code_hash = data.archive_file.lambda_handler.output_base64sha256

  role = aws_iam_role.handler_lambda.arn
}



resource "aws_lambda_function" "filter" {
  function_name = "filter"

 
  s3_bucket = "jdfilter"
  s3_key    = "Jdfilter.zip"

  runtime = "python3.9"
  handler = "function.handler"

 # source_code_hash = data.archive_file.lambda_handler.output_base64sha256

  role = aws_iam_role.handler_lambda.arn
}