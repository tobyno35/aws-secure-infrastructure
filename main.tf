terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0" # Using a slightly newer version based on other results
        }
      }
    }
    
    provider "aws" {
      region = "us-east-1"
    }
    
    resource "aws_vpc" "main" {
      cidr_block       = "10.0.0.0/16"
      instance_tenancy = "default"
    
      tags = {
        Name = "main-vpc"
      }
    }
    
