output "app_hostname" {
  value = "${aws_instance.app.tags.Name}"
}

output "app_private_ip" {
  value = "${aws_instance.app.private_ip}"
}

