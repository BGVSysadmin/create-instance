terraform {
  backend "atlas" {
    name    = "cloudhesive/infrastructure"
    address = "https://atlas.hashicorp.com"
  }
}

# Specify the provider and access details
provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

# Lookup the correct AMI based on the region specified
data "aws_ami" "amazon_windows_2012R2" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["Windows_Server-2012-R2_RTM-English-64Bit-Base-Hardened-KMS"]
  }
}

resource "aws_instance" "all-in-one" {
  instance_type = "t2.large"
  ami           = "${data.aws_ami.amazon_windows_2012R2.image_id}"
}

output "ip" {
  value = "${aws_instance.all-in-one.private_ip}"
}