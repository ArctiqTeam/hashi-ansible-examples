resource "aws_key_pair" "tf-key" {
  key_name   = "tf-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+aKXUVC6BEJVHYoUW0aemVV5gujXEeToZycvIX9g9pT6ike45rucuNMtp73yq0/I/JLGveWD1dcQZ3IwoRn9yabcdCcY9dxgM2jknmYj/E+++7LLk8VXN/VQmHc986OzmGHIKyLX2xPp8Z1eiqqRgvUgSyNdqu1UXz24umT8dbz2Ob6Bq+bJ+ooji8FY4n4ukyQuHHWQ+AFqvnX9GNL0Ql/OEeMUoOQJ4M5EhNLEnGyM28CZ8XkDIwpDMwqEmqbafVP7RLJM6mMvfXWWRlWLeYaut2mmCasnYHzYaVLuFAze5Eukp2XYpKBjeHbtAKKGWiR6u65Y4W262li+S66UJ ansible"
}
resource "aws_instance" "web" {
  count = 2
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = "${var.root_volume_size}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }
  key_name = "tf-key"
  subnet_id = "subnet-a1803e9d"
  associate_public_ip_address = true
  vpc_security_group_ids = [
    "sg-f384b18d"
  ]
  tags {
    Name = "web-${count.index}"
    sshUser = "centos"
    Group = "webservers"
    Project = "aws_demo"
  }
}
resource "aws_instance" "db" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = "${var.root_volume_size}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }
  key_name = "tf-key"
  subnet_id = "subnet-a1803e9d"
  associate_public_ip_address = true
  vpc_security_group_ids = [
    "sg-f384b18d"
  ]
  tags {
    Name = "db1"
    sshUser = "centos"
    Group = "dbservers"
    Project = "aws_demo"
  }
}
resource "aws_instance" "lb" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = "${var.root_volume_size}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }
  key_name = "tf-key"
  subnet_id = "subnet-a1803e9d"
  associate_public_ip_address = true
  vpc_security_group_ids = [
    "sg-f384b18d"
  ]
  tags {
    Name = "lb1"
    sshUser = "centos"
    Group = "lbservers"
    Project = "aws_demo"
  }
}
resource "aws_instance" "nagios" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = "${var.root_volume_size}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }
  key_name = "tf-key"
  subnet_id = "subnet-a1803e9d"
  associate_public_ip_address = true
  vpc_security_group_ids = [
    "sg-f384b18d"
  ]
  tags {
    Name = "nagios"
    sshUser = "centos"
    Group = "monitoring"
    Project = "aws_demo"
  }
}
