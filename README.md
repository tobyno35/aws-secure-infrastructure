# AWS Secure Infrastructure - Basic VPC
    
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
    
