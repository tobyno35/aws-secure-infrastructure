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
* Configured **Bastion Security Group** to permit SSH connections.

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
