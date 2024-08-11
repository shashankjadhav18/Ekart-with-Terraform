variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for public subnets"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "t3.medium"
}

