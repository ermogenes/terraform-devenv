output "public-ip" {
  value = aws_instance.tf-devenv-ec2.public_ip
}

output "public-dns" {
  value = aws_instance.tf-devenv-ec2.public_dns
}

output "http-url" {
  value = "http://${aws_instance.tf-devenv-ec2.public_dns}/"
}

output "ssh-command" {
  value = "ssh -i ${var.my_local_credential_key} ubuntu@${aws_instance.tf-devenv-ec2.public_ip}"
}
