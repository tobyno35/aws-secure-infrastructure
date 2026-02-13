# AWS Secure Infrastructure: Bastion & Automated Provisioning

## 📌 Project Overview
This project demonstrates the deployment of a secure AWS infrastructure using a **Bastion Host** architecture. The goal was to provision a protected Web Server instance within a VPC, utilizing IAM roles for secure, credential-free resource management.

The lab focuses on EC2 administration, IAM role association (`iam:PassRole`), and security group configuration to minimize attack surfaces.

## 🏗️ Architecture
* **VPC**: Custom Lab VPC
* **Public Subnet**: Hosts the Bastion Host for secure SSH access.
* **Instances**:
    * **Bastion Host**: `t3.micro` (Amazon Linux 2023) acting as the secure jump box.
    * **Web Server**: `t3.micro` (Amazon Linux 2023) provisioned for application hosting.
* **Security**:
    * **Bastion-Role**: IAM instance profile attached to EC2 instances to manage AWS permissions.
    * **Security Groups**: Restricted traffic rules (SSH limited to Bastion, HTTP for Web Server).

## 🚀 Deployment Steps

### 1. Bastion Host Initialization
* Launched an EC2 instance (`t3.micro`) in the Public Subnet.
* Attached the **Bastion-Role** IAM profile.
* Configured **Bastion Security Group** to permit SSH con# AWS Secure Infrastructure - Basic VPC
    
    This project provides a basic Terraform configuration to deploy an AWS Virtual Private Cloud (VPC).
    
    ## Purpose
    
    The `main.tf` file contains the Terraform code to create a simple VPC in AWS with a specified CIDR block. This serves as a foundational element for deploying other resources within a secure and isolated network environment.
    
    ## How to Use
    
    1.  **Prerequisites:**
        * Ensure you have [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed.
        * Configure your AWS credentials for Terraform to use. You can do this by setting up the AWS CLI and running `aws configure`, or by setting environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION`).
    
    2.  **Initialize Terraform:**
        Navigate to the directory containing the `main.tf` file and run:
        ```bash
        terraform init
        ```
    
    3.  **Plan the Deployment:**
        See what resources Terraform will create:
        ```bash# AWS Secure Infrastructure - Basic VPC
    
    This project provides a basic Terraform configuration to deploy an AWS Virtual Private Cloud (VPC).
    
    ## Purpose
    
    The `main.tf` file contains the Terraform code to create a simple VPC in AWS with a specified CIDR block. This serves as a foundational element for deploying other resources within a secure and isolated network environment.
    
    ## How to Use
    
    1.  **Prerequisites:**
        * Ensure you have [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed.
        * Configure your AWS credentials for Terraform to use. You can do this by setting up the AWS CLI and running `aws configure`, or by setting environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION`).
    
    2.  **Initialize Terraform:**
        Navigate to the directory containing the `main.tf` file and run:
        ```bash
        terraform init
        ```
    
    3.  **Plan the Deployment:**
        See what resources Terraform will create:
        ```bash
        terraform plan
        ```
    
    4.  **Apply the Configuration:**
        Deploy the VPC:
        ```bash
        terraform apply
        ```
        You will be prompted to confirm the action.
    
    5.  **Destroy Resources (Optional):**
        To tear down the VPC and associated resources managed by this configuration:
        ```bash
        terraform destroy
        ```
    
    ## Configuration
    
    * **`main.tf`**: Contains the definition for the AWS provider and the `aws_vpc` resource.
        * The region is set to `us-east-1` by default. You can modify this in the `provider` block.
        * The VPC CIDR block is set to `10.0.0.0/16`. You can change this in the `aws_vpc` resource block.
    
        terraform plan
        ```
    
    4.  **Apply the Configuration:**
        Deploy the VPC:
        ```bash
        terraform apply
        ```
        You will be prompted to confirm the action.
    
    5.  **Destroy Resources (Optional):**
        To tear down the VPC and associated resources managed by this configuration:
        ```bash
        terraform destroy
        ```
    
    ## Configuration
    
    * **`main.tf`**: Contains the definition for the AWS provider and the `aws_vpc` resource.
        * The region is set to `us-east-1` by default. You can modify this in the `provider` block.
        * The VPC CIDR block is set to `10.0.0.0/16`. You can change this in the `aws_vpc` resource block.
    nections.

### 2. Secure Web Server Provisioning
* Connected to the Bastion Host via **EC2 Instance Connect**.
* Attempted to use the AWS CLI to programmatically launch the Web Server instance from within the Bastion session.

## 🔧 Troubleshooting & Security Analysis ("The Skill Issue")

During the deployment phase, an attempt to launch the Web Server via the AWS CLI on the Bastion Host resulted in an authorization failure.

**Error Encountered:**
```
An error occurred (UnauthorizedOperation) when calling the RunInstances operation:
User: arn:aws:sts::[REDACTED]:assumed-role/Bastion-Role/... is not authorized to perform:
iam:PassRole on resource: .../Bastion-Role
```

**Root Cause Analysis:**
The **Bastion-Role** assigned to the Bastion Host had sufficient permissions to interact with EC2, but it lacked the specific `iam:PassRole` permission. This permission is a security requirement that strictly controls which IAM roles an entity (like an EC2 instance) is allowed to "pass" or assign to a *new* resource it creates.

**Resolution:**
To maintain deployment velocity while adhering to least-privilege principles, the Web Server was provisioned via the Console with the correct IAM Role mapped. In a production CI/CD environment, the `Bastion-Role` policy would be updated to explicitly allow `iam:PassRole` on the specific target ARN.

## ✅ Final Status
* **Bastion Host**: Running
* **Web Server**: Running
* **Connectivity**: Verified

## 🛠️ Technologies Used
* Amazon EC2
* AWS IAM (Roles & Policies)
* AWS CLI
* VPC & Networking
