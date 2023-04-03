
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${local.name}-demo"
  retention_in_days = 5
  tags              = merge(local.tags, { VPC = "logs" })
}



resource "aws_flow_log" "example" {
  iam_role_arn             = aws_iam_role.x5324-network-diag-vpc-flow-logs.arn
  log_destination          = aws_cloudwatch_log_group.log_group.arn
  traffic_type             = "ALL"
  vpc_id                   = var.vpc_id
  max_aggregation_interval = 60
  tags                     = merge(local.tags, { VPC = "logs" })
}
