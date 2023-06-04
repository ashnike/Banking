# main.tf

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
  ami                    = "ami-077053fb4029de92f"  # Ubuntu 20.04 LTS
  instance_type          = "t2.micro"
  key_name               = "dunk"
  associate_public_ip_address = false
  subnet_id              = "subnet-0562d4cfa17651f09"
  vpc_security_group_ids = ["sg-0924a40823e9bfc02"]
  vpc_id                 = "vpc-0d32271ecfc781ab6"

  tags = {
    Name = "terra-test"
  }
}

resource "aws_eip_association" "my_eip_association" {
  instance_id   = aws_instance.my_instance.id
  allocation_id = "eipassoc-091f5368e17f521b9"
}

output "public_ip" {
  value = aws_eip_association.my_eip_association.public_ip
}
