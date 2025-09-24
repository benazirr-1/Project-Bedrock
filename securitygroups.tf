resource "aws_security_group" "eks_node_sg" {
  name        = "innovatemart-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = aws_vpc.main.id

  # Allow all outbound traffic from the nodes to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "innovatemart-node-sg"
  }
}