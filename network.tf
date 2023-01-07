resource "aws_vpc" "br-vpc" {
  cidr_block = "10.168.0.0/16"

  tags = {
    Name = "vpc-br"
  }
}

resource "aws_subnet" "br-subnet" {
  vpc_id                  = aws_vpc.br-vpc.id
  cidr_block              = "10.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "sa-east-1b"

}

resource "aws_internet_gateway" "br_igw" {
  vpc_id = aws_vpc.br-vpc.id


  tags = {
    Name = "br-igw"
  }
}

resource "aws_route_table" "route-br" {
  vpc_id = aws_vpc.br-vpc.id

  tags = {
    Name = "public_rt"

  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.route-br.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.br_igw.id
}

resource "aws_route_table_association" "br-public-ass" {
  subnet_id      = aws_subnet.br-subnet.id
  route_table_id = aws_route_table.route-br.id
}




resource "aws_security_group" "sg-br" {
  name        = "django_app"
  description = "django-security-group"
  vpc_id      = aws_vpc.br-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-django"
  }
}