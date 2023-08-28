data "aws_caller_identity" "current" {}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "devops-practice-with-ansible"
  owners      = [data.aws_caller_identity.current.account_id]
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags                   = {
    name = var.component
  }
}

  resource "null resource" "provisioner"  {
    provisioner "remote-exec" {

    connection {
      host = aws_instance.ec2.public_ip
      user     = "centos"
      password = "DevOps321"

    }

    inline = [
      "ansible-pull -i localhost, -u https://github.com/rohangupta1996/roboshop-ansible.git roboshop.yml -e role_name= ${var.component}"
    ]
  }

}

#security group
resource "aws_security_group" "sg" {
  name        ="${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}
resource "aws_route53_record" "ec2" {
  zone_id = Z07976502M6F7LN0JRVET
  name    = "$(var.component)-dev.rohandevops.online"
  type    = "A"
  ttl     = 300
  records = aws_instance.ec2.private_ip
}


variable "component" {}
variable "instance_type" {}
variable "env" {
  default = "dev"
}
variable "password" {}