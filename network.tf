
# VPC Creation
resource "aws_vpc" "new_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "new_vpc"
  }
}
# internet gateway creation
resource "aws_internet_gateway" "new_ig" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = "new_ig"
  }
}
# Subnet creation 
resource "aws_subnet" "public_subnet" {
  count             = length(var.subnets_cidr)
  vpc_id            = aws_vpc.new_vpc.id
  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.subnets_cidr, count.index)
  tags = {
    Name = "subnet-${count.index + 1}"
  }
}

# Create route table, attach internet gateway and associate to subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.new_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new_ig.id
  }
  tags = {
    Name = "public_rt"
  }
}
# Attach route table with public subnets
resource "aws_route_table_association" "route_table_association" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}
# creation of security group
resource "aws_security_group" "webserver" {
  name        = "allow_http"
  description = "allow http inbound traffic"
  vpc_id      = aws_vpc.new_vpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allowing port 80"
    from_port   = "80"
    protocol    = "tcp"
    to_port     = "80"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allowing port 22"
    from_port   = "22"
    protocol    = "tcp"
    to_port     = "22"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allowing port ICMP"
    from_port   = "-1"
    protocol    = "icmp"
    to_port     = "-1"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allowing port 0"
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "newSGformasterservers"
  }
}
output "vpc" {
  value = aws_vpc.new_vpc
}