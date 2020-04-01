resource "aws_security_group" "demo" {
  name        = "terraform-demo"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "demo-ingress-http" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.demo.id
  source_security_group_id = aws_security_group.demo.id
  to_port                  = 80
  type                     = "ingress"
}

