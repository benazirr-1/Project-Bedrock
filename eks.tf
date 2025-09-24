# EKS Cluster Resource 
resource "aws_eks_cluster" "main" {
  name     = "innovatemart-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn 

 
vpc_config {
    subnet_ids = concat(aws_subnet.public.*.id, aws_subnet.private.*.id)
  }

# To ensure that Terraform doesn't try to create the cluster until its IAM role and policies are fully ready.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment
  ]

  tags = {
    Name = "innovatemart-eks-cluster"
  }
}

# EKS Managed Node Group 
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name 
  node_group_name = "innovatemart-workers"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn 
  
  subnet_ids      = aws_subnet.private.*.id

  instance_types = ["t3.medium"]

scaling_config {
    desired_size = 2 
    max_size     = 3 
    min_size     = 1 
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy_attachment,
    aws_iam_role_policy_attachment.ecr_readonly_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
  ]

  tags = {
    Name = "innovatemart-worker-nodes"
  }
}