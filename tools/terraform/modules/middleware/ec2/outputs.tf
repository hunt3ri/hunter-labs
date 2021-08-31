//output "ubuntu_cluster_dns" {
//  description = "Public DNS addresses"
//  value       = aws_instance.ubuntu_cluster.*.public_dns
//}

output "labs_cluster_dns" {
  description = "Public DNS addresses"
  value       = aws_instance.ec2_cluster.*.public_dns
}
