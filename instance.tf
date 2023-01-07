data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

}

resource "aws_key_pair" "br_auth" {
  key_name   = "brkey"
  public_key = file("./brkey.pub")
}


resource "aws_instance" "webapp" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.br_auth.id
  vpc_security_group_ids = [aws_security_group.sg-br.id]
  subnet_id              = aws_subnet.br-subnet.id
  tags = {
    Name = "br"
  }
}
