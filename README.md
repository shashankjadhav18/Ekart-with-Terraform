## DevOps Infrastructure Automation with Terraform

This repository contains Terraform configurations to automate the deployment of a comprehensive DevOps infrastructure. The setup includes Jenkins, Docker, SonarQube, Nexus Repository, and a Kubernetes cluster on AWS. By defining infrastructure as code (IaC), this project ensures consistent, repeatable, and scalable infrastructure management.

![image](https://github.com/user-attachments/assets/9838ca07-8e0b-4dbc-9aa0-94ce77ae3905)


### Key Features:
- **Jenkins**: Automates CI/CD pipelines.
- **Docker**: Containerizes applications for consistency across environments.
- **SonarQube**: Continuous code quality inspection.
- **Nexus Repository**: Manages artifacts and dependencies.
- **Kubernetes**: Orchestrates containerized applications.

### Structure:
- **Modules**: Reusable Terraform modules for each component.
- **Main Configuration**: Centralized Terraform configuration to orchestrate the entire infrastructure.

### Getting Started:
1. Clone the repository.
2. Configure necessary variables in the `variables.tf` file.
3. Initialize and apply the Terraform configuration.

This project provides a scalable and automated way to manage your DevOps infrastructure, leveraging Terraform's powerful IaC capabilities on AWS.
