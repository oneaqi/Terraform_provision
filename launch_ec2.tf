provider "aws" {
  region     = "${var.region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

resource "aws_security_group" "test_sg" {
  name = "test_sg"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port   = "9200"
    to_port     = "9200"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
ami = "${var.ami}"
instance_type = "t2.micro"
key_name = "${var.key_name}"
vpc_security_group_ids = ["${aws_security_group.test_sg.id}"]
associate_public_ip_address = true
subnet_id = "${var.subnet_id}"
tags  ={
Name = "Yuqi-terraform"
}
}
