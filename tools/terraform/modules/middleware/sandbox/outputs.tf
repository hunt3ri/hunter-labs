output "public_dns" {
  description = "Public DNS addresses"
  value       = aws_instance.ubuntu_cluster.*.public_dns
}
