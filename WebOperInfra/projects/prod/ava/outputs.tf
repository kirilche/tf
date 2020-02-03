output "vpc" {
  value = "${module.vpc.name}"
}

output "vpc_region" {
  value = "${module.vpc.region}"
}

output "subnet_public" {
  value = "${module.subnet_public.name}"
}

output "subnet_public_az" {
  value = "${module.subnet_public.az}"
}

output "subnet_public_id" {
  value = "${module.subnet_public.id}"
}

output "subnet_private_01" {
  value = "${module.subnet_private_01.name}"
}

output "subnet_private_01_id" {
  value = "${module.subnet_private_01.id}"
}

output "subnet_private_01_az" {
  value = "${var.subnet_private_01_az}"
}

output "security_group_demo-node_id" {
  value = "${module.security_groups.demo-node_id}"
}

output "security_group_demo-cluster_id" {
  value = "${module.security_groups.demo-cluster_id}"
}

output "iam_arn1" {
  value = "${module.iam.iam_role_arn_cluster}"
}

output "iam_arn2" {
  value = "${module.iam.iam_role_arn_node}"
}

output "endpoint" {
  value = "${module.eks.endpoint}"
}

#
# Outputs
#

locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${module.iam.iam_role_arn_node}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.endpoint}
    certificate-authority-data: ${module.eks.ca}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}
