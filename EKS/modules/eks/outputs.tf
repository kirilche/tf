output "version" {
  value = "${aws_eks_cluster.demo.version}"
}

output "endpoint" {
  value = "${aws_eks_cluster.demo.endpoint}"
}

output "ca" {
  value = "${aws_eks_cluster.demo.certificate_authority.0.data}"
}
