resource "aws_ssm_parameter" "table_name" {
  name = "/big-mouth-${var.my_name}/${var.stage}/table_name"
  type = "String"
  value = "${aws_dynamodb_table.restaurants_table.name}"
}

resource "aws_ssm_parameter" "url" {
  name = "/big-mouth-${var.my_name}/${var.stage}/url"
  type = "String"
  value = "${aws_api_gateway_deployment.api.invoke_url}"
}

resource "aws_ssm_parameter" "stream_name" {
  name = "/big-mouth-${var.my_name}/${var.stage}/stream_name"
  type = "String"
  value = "${aws_kinesis_stream.orders_stream.name}"
}