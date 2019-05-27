resource "aws_api_gateway_rest_api" "api" {
  name        = "production-ready-serverless-${var.my_name}"
}

resource "aws_api_gateway_deployment" "api" {
  depends_on = [
    "aws_api_gateway_integration.get_index_lambda",
    "aws_api_gateway_integration.get_restaurants_lambda"
  ]

  lifecycle {
    create_before_destroy = true
  }

  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "dev"

  variables {
    deployed_at = "${timestamp()}"
  }
}

# GET-INDEX
resource "aws_api_gateway_method" "get_index_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_index_lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_method.get_index_get.resource_id}"
  http_method = "${aws_api_gateway_method.get_index_get.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.get_index.invoke_arn}"
}

resource "aws_lambda_permission" "apigw_get_index" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.get_index.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.api.execution_arn}/*/*"
}

# GET-RESTAURANTS
resource "aws_api_gateway_resource" "get_restaurants" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "restaurants"
}

resource "aws_api_gateway_method" "get_restaurants_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.get_restaurants.id}"
  http_method   = "GET"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "get_restaurants_lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_method.get_restaurants_get.resource_id}"
  http_method = "${aws_api_gateway_method.get_restaurants_get.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.get_restaurants.invoke_arn}"
}

resource "aws_lambda_permission" "apigw_get_restaurants" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.get_restaurants.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.api.execution_arn}/*/*"
}