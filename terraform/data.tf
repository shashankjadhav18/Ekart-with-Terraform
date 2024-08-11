data "aws_ami" "ubuntu22" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "id"
    values = ["ubuntu/images/hvm-ssd/Ubuntu Server 24.04 LTS-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "aws_ami" {
  value = data.aws_ami.ubuntu22.id
}

data "aws_availability_zones" "available" {
  state = "available"
}