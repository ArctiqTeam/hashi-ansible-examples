resource "aws_key_pair" "tf-key" {
  key_name   = "tf-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGTkJRg8aWHUyIVYVIbMGR+j90eGkO6nYzAWit1vYANPY3PJMynRg47/IzFoh64oIW0/qSb0ZQh3VPkROY6ldojC3XH6dkj1Fwsvi/HFa8aTI7cFtGvqlYQ5O2mu9pXq2an6Pp0OopexlMKucOUO6wlvMf/X94r01CkQNDs3TFcfv3IOl2NcZC/1Y1D71KB/N2E8YO0y+KGzMoaH1eUepfTixbKrKtpF1yMjL2jPZgIbcUXkaDy7j3w/dLpKWr+gxSDIotbqSZ9KliYQod/UdoBKiYiRObnBBIe9V5PYpbcteVicVKJ0h9POafXCsPMpMVON7/+O8XaFhyi3u/yWYZ tim@tim-linux"
}

resource "aws_instance" "web" {
  count         = 1
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  root_block_device {
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }

  key_name                    = "tf-key"
  subnet_id                   = "subnet-a1803e9d"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "sg-f384b18d",
  ]

  tags {
    Name    = "web-${count.index}"
    sshUser = "centos"
    Group   = "webservers"
    Project = "aws_demo"
  }
}

# resource "aws_instance" "db" {
#   ami = "${lookup(var.AMIS, var.AWS_REGION)}"
#   instance_type = "t2.micro"
#   root_block_device {
#     volume_size = "${var.root_volume_size}"
#     delete_on_termination = "${var.volume_delete_on_termination}"
#   }
#   key_name = "tf-key"
#   subnet_id = "subnet-a1803e9d"
#   associate_public_ip_address = true
#   vpc_security_group_ids = [
#     "sg-f384b18d"
#   ]
#   tags {
#     Name = "db1"
#     sshUser = "centos"
#     Group = "dbservers"
#     Project = "aws_demo"
#   }
# }
# resource "aws_instance" "lb" {
#   ami = "${lookup(var.AMIS, var.AWS_REGION)}"
#   instance_type = "t2.micro"
#   root_block_device {
#     volume_size = "${var.root_volume_size}"
#     delete_on_termination = "${var.volume_delete_on_termination}"
#   }
#   key_name = "tf-key"
#   subnet_id = "subnet-a1803e9d"
#   associate_public_ip_address = true
#   vpc_security_group_ids = [
#     "sg-f384b18d"
#   ]
#   tags {
#     Name = "lb1"
#     sshUser = "centos"
#     Group = "lbservers"
#     Project = "aws_demo"
#   }
# }
# resource "aws_instance" "nagios" {
#   ami = "${lookup(var.AMIS, var.AWS_REGION)}"
#   instance_type = "t2.micro"
#   root_block_device {
#     volume_size = "${var.root_volume_size}"
#     delete_on_termination = "${var.volume_delete_on_termination}"
#   }
#   key_name = "tf-key"
#   subnet_id = "subnet-a1803e9d"
#   associate_public_ip_address = true
#   vpc_security_group_ids = [
#     "sg-f384b18d"
#   ]
#   tags {
#     Name = "nagios"
#     sshUser = "centos"
#     Group = "monitoring"
#     Project = "aws_demo"
#   }
# }

