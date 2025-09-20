resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "innovatemart-vpc"
  }
}


resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${count.index + 1}.0/24"
  availability_zone = "${var.aws_region}${element(["a", "b"], count.index)}"
  map_public_ip_on_launch = true

tags = {
  Name = "innovatemart-public-subnet-${count.index +  1}"
}
}


resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 101}.0/24"
  availability_zone = "${var.aws_region}${element(["a", "b"], count.index)}"

  tags = {
    Name = "innovatemart-private-subnet-${count.index + 1}"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "innovatemart-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.main.id 
  }

  tags = {Name = "innovatemart-public-rt"}
}

resource "aws_route_table_association" "public" {
  count = 2
  subnet_id = aws_subnet.public[count.index].id 
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {Name = "innovatemart-nat-eip"}
}


resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public[0].id
    tags = { Name = "innovatemart-nat-gw"}
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

tags = { Name ="innovatemart-private-rt"}
}

resource "aws_route_table_association" "private" {
  count = 2
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

#Just a comment for pull test