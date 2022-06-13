resource "aws_vpc" "tf-devenv-vpc" {
  cidr_block           = "10.42.0.0/16"
  enable_dns_hostnames = true

  tags = {
    "Name"    = "tf-devenv-vpc"
    "Project" = "tf-devenv"
  }
}

resource "aws_subnet" "tf-devenv-public-subnet" {
  vpc_id                  = aws_vpc.tf-devenv-vpc.id
  cidr_block              = "10.42.42.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1a"

  tags = {
    "Name"    = "tf-devenv-public-subnet"
    "Project" = "tf-devenv"
  }
}

resource "aws_internet_gateway" "tf-devenv-internet-gateway" {
  vpc_id = aws_vpc.tf-devenv-vpc.id

  tags = {
    "Name"    = "tf-devenv-internet-gateway"
    "Project" = "tf-devenv"
  }
}

resource "aws_route_table" "tf-devenv-route-table" {
  vpc_id = aws_vpc.tf-devenv-vpc.id

  tags = {
    "Name"    = "tf-devenv-route-table"
    "Project" = "tf-devenv"
  }
}

resource "aws_route" "tf-devenv-route" {
  route_table_id         = aws_route_table.tf-devenv-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-devenv-internet-gateway.id
}

resource "aws_route_table_association" "tf-devenv-route-table-association" {
  subnet_id      = aws_subnet.tf-devenv-public-subnet.id
  route_table_id = aws_route_table.tf-devenv-route-table.id
}

resource "aws_security_group" "tf-devenv-security-group" {
  name        = "tf-devenv-security-group"
  description = "Allow all from local IP"
  vpc_id      = aws_vpc.tf-devenv-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.my_local_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name"    = "tf-devenv-security-group"
    "Project" = "tf-devenv"
  }
}

resource "aws_key_pair" "tf-devenv-key-pair" {
  key_name   = "tf-devenv-key-pair"
  public_key = file("${var.my_local_credential_key}.pub")

  tags = {
    "Name"    = "tf-devenv-key-pair"
    "Project" = "tf-devenv"
  }
}

resource "aws_instance" "tf-devenv-ec2" {
  // Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-04-20
  ami                    = "ami-0dc5e9ff792ec08e3"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tf-devenv-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.tf-devenv-security-group.id]
  subnet_id              = aws_subnet.tf-devenv-public-subnet.id

  user_data = file("userdata-docker-compose.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    "Name"    = "tf-devenv-ec2"
    "Project" = "tf-devenv"
  }
}
