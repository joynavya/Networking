provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "My_Server" {
  ami           = "ami-03fd334507439f4d1"
  instance_type = "t2.micro"

  key_name                    = aws_key_pair.my_Keypair.key_name
  subnet_id                   = aws_subnet.Subnet.id
  vpc_security_group_ids      = [aws_security_group.Security_Group.id]
  associate_public_ip_address = true

  tags = {
    Name = "New Server"
  }
}

resource "aws_key_pair" "my_Keypair" {
  key_name   = "my-keypair"
  public_key = file("my-key.pem.pub")

}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "Subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnet"
  }
}

resource "aws_internet_gateway" "Gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_security_group" "Security_Group" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Gateway.id
  }
  tags = {
    Name = "My_RT"
  }

}

resource "aws_route_table_association" "RT" {
  subnet_id      = aws_subnet.Subnet.id
  route_table_id = aws_route_table.RT.id
}
