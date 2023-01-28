resource "aws_internet_gateway" "self" {
  vpc_id = aws_vpc.self.id

  tags = {
    "Name" = "${var.project}-igw"
  }

  depends_on = [aws_vpc.self]
}

# NAT Elastic IP
resource "aws_eip" "main" {
  vpc = true

  tags = {
    Name = "${var.project}-ngw-ip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.project}-ngw"
  }
}

resource "aws_route" "main" {
  route_table_id         = aws_vpc.self.default_route_table_id
  nat_gateway_id         = aws_nat_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}