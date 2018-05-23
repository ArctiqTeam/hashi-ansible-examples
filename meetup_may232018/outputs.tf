output "address" {
  value = "${aws_instance.web.public_ip}"
}

output "ssh" {
  value = "ssh -o pubkeyauthentication=no ${aws_instance.web.tags.sshUser}@${aws_instance.web.public_ip}"
}
