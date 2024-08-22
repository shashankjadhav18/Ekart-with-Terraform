# Retrieve the latest Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu22" {
  most_recent = true
  owners      = ["amazon"] 
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Output the AMI ID
output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu22.id
  description = "The ID of the latest Ubuntu 22.04 LTS AMI"
}

# Get the list of available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}
