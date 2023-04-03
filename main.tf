data "aws_ami" "amzn_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "web" {
  depends_on           = [aws_internet_gateway.gw]
  ami                  = data.aws_ami.amzn_linux_2.id
  instance_type        = var.instance_type
  count                = var.number_of_instances
  iam_instance_profile = aws_iam_instance_profile.x5324-network-diag-ssm-profile.name

  vpc_security_group_ids = ["${var.vpc_sub_id}"]
  subnet_id              = var.subnet_id

  tags = merge(local.tags, {
    Instance_number = "Instance-${count.index + 1}"
  })
}


resource "aws_iam_instance_profile" "x5324-network-diag-ssm-profile" {
  name = "${local.name}-SSM-Instance-Profile"
  role = aws_iam_role.x5324-network-diag-ssm.name
}

resource "aws_internet_gateway" "gw" {
  count  = local.create_internet_gateway ? 1 : 0
  vpc_id = var.vpc_id

  tags = {
    Name = local.name
  }
}