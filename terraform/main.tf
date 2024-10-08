resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    name = "ekart_project"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    name = "ekart_subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ekart"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # public 
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "ekart"
  }
}

# Route Table Association
resource "aws_route_table_association" "rta" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}
# Generate a new private key
resource "tls_private_key" "ekart_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key locally
resource "local_file" "ekart_key" {
  content  = tls_private_key.ekart_key.private_key_pem
  filename = "F:/DevOps Projects/DevOps Shack - Ekart project/Keys/ekart_key.pem"
}

# Extract and save the public key
resource "local_file" "ekart_key_pub" {
  content  = tls_private_key.ekart_key.public_key_openssh
  filename = "F:/DevOps Projects/DevOps Shack - Ekart project/Keys/ekart_key.pub"
}

# Create an AWS Key Pair using the public key
resource "aws_key_pair" "ekart_key" {
  key_name   = "ekart_key"
  public_key = local_file.ekart_key_pub.content
}


resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 30000
    to_port = 32768
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
  ingress {
    from_port = 3000
    to_port = 10000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8081
    to_port     = 8081
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

  tags = {
    Name = "ekart_sg"
  }
}


resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu22.id
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
  instance_type = var.instance_type
  key_name = aws_key_pair.ekart_key.key_name
  associate_public_ip_address = true
  subnet_id     = aws_subnet.public.id
  security_groups = [aws_security_group.main.id]

  tags = {
    Name = "jenkins"
  }
}


resource "aws_instance" "sonarqube" {
  ami           = data.aws_ami.ubuntu22.id
  instance_type = var.instance_type
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
  associate_public_ip_address = true
  key_name = aws_key_pair.ekart_key.key_name
  subnet_id     = aws_subnet.public.id
  security_groups = [aws_security_group.main.id]

  tags = {
    Name = "sonarqube"
  }
}

resource "aws_instance" "nexus" {
  ami           = data.aws_ami.ubuntu22.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = aws_key_pair.ekart_key.key_name
  subnet_id     = aws_subnet.public.id
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
  security_groups = [aws_security_group.main.id]
  
  tags = {
    Name= "Nexus"
  }
  
}


