# Project Bedrock 

This repository contains the Terraform code to deploy the  Retail Store Sample App (https://github.com/aws-containers/retail-store-sample-app) to a production-grade Kubernetes environment on AWS, as part of the "Project Bedrock" assignment.

## Architecture Overview

The infrastructure consists of the following key components provisioned by Terraform:
- **VPC:** A custom Virtual Private Cloud with public and private subnets for network isolation.
- **EKS:** An Amazon Elastic Kubernetes Service (EKS) cluster to orchestrate the application's microservices.
- **RDS:** Managed AWS RDS instances for PostgreSQL and MySQL to provide a scalable persistence layer 
- **IAM:** Dedicated IAM roles for the EKS cluster and worker nodes to ensure secure, least-privilege access.
- **CI/CD:** A GitHub Actions workflow automates the deployment of this infrastructure.

## How to Deploy

I followed the instructions on https://github.com/aws-containers/retail-store-sample-app ReadME Document

