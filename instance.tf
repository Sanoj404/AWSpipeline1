resource "aws_instance" "webserver" {
  # creating webservers in each subnets using count.
  count           = length(var.subnets_cidr)
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = "bpxeukey"
  security_groups = [aws_security_group.webserver.id]
  subnet_id       = element(aws_subnet.public_subnet.*.id, count.index)
  user_data       = file("install.sh")
  tags = {
    "Name" = "Masterserver-${count.index + 1}"
  }
}
#output "public_ip" {
#description = "List of public IP addresses assigned to the instances, if applicable"
#value = aws_instance.webserver(*).public_ip
#}