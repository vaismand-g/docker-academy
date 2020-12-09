/*
****1
Google:
terraform provider aws
https://www.terraform.io/docs/providers/index.html

Copiamos el primer código que aparece

*****2
Podemos ver que no tiene el plugin, lo instalamos y quizas mostramos la diferencia
entre VS Code e IntelliJ

*****3
Les paso la liga de principal documentacion de AWS en Terraform
https://registry.terraform.io/providers/hashicorp/aws/latest/docs

*****4
Ejecutamos con plan y apply --> se explicara


****5
"Truco"
Agrego la VPC (Paso anterior)

*****6
Recuerdan que cuando se inicia una maquina hay diferentes setups?
VPC, Security Groups...

Nos seguimos con los "Argument Reference", yo les apoyaré con la VPC, pero
la idea principal de tener aquí la arquitectura es crear todo la de información

*/



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Selecting VPC
data "aws_vpc" "selected" {
  id = "vpc-07e132078b21bd3f3"
}

# Create an Instance
resource "aws_instance" "secondHomerTestEc2" {
  ami = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  subnet_id = "subnet-0c976721683396a69"
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-02233ec37777ca238"]
  key_name = "homero-ec2-keys"
  user_data = <<EOF
#! /bin/bash
sudo yum update
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl stop firewalld
sudo echo "Hello World from $(hostname -f)" > /var/www/html/index.html
EOF
  tags = {
    Name = "secondHomerTestEc2"
  }
}

