output "iam_role_arn_cluster" {
  description = "ARN of IAM role"
  value       = "${aws_iam_role.demo-cluster.arn}"
}

output "iam_role_arn_node" {
  description = "ARN of IAM role"
  value       = "${aws_iam_role.demo-node.arn}"
}

output "instance_profile_name" {
  description = "ARN of IAM role"
  value       = "${aws_iam_instance_profile.demo-node.name}"
}
