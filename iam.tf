resource "aws_iam_role" "x5324-network-diag-ssm" {
  name = "${local.name}-SSM-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "x5324-network-diag" {
  for_each   = var.policies
  policy_arn = each.value
  # policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role = aws_iam_role.x5324-network-diag-ssm.name
}
/*
resource "aws_iam_role_policy_attachment" "x5324-network-diagmulti" {
  policy_arn = aws_iam_policy.x5324-network-diag-multi-policy.arn
  role       = aws_iam_role.x5324-network-diag-ssm.name
}
*/

resource "aws_iam_role" "x5324-network-diag-vpc-flow-logs" {
  name = "${local.name}-vpc-flow-logs"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "Service" : "vpc-flow-logs.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "x5324-network-diag-vpc-flow-logs" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = aws_iam_role.x5324-network-diag-vpc-flow-logs.name
}

/*
resource "aws_iam_policy" "x5324-network-diag-multi-policy" {
  name        = "${local.name}-Multiple-policy"
  path        = "/"
  description = "${local.name}-Multiple-policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
    tags = merge(local.tags, {
    Multiple-role = "Policy-for-many-roles"
    SSM = "SSM-TAG"
  })
}
*/