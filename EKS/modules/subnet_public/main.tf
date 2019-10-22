## Public subnet
resource "aws_subnet" "public" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.subnet_cidr}"
  availability_zone = "${var.subnet_az}"

  tags = "${
    map(
      "Name", "public_${var.subnet_name}",
      "kubernetes.io/cluster/${var.cluster_name}", "shared",
      "kubernetes.io/role/internal_elb", "1",
    )
  }"
}

## Internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "public_${var.subnet_name}"
  }
}

## Routing table
resource "aws_route_table" "public_route_table" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "public_${var.subnet_name}"
  }
}

resource "aws_route" "gateway_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

## Associate the routing table to public subnet
resource "aws_route_table_association" "rt_assn" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
