output "vm_ip" {
  value = aws_instance.webapp.public_ip
}