
output "iam_role_arn_cluster" {
  description = "ARN of IAM role"
  value       = "${aws_iam_role.demo-cluster.arn}"
}

output "iam_role_arn_node" {
  description = "ARN of IAM role"
  value       = "${aws_iam_role.demo-node.arn}"
}