# Project Structure

This file:

- Provide an overview of the project structure and organization.
- Explain the purpose of each file or directory.
- Describe any naming conventions or guidelines used in the project.

## Project structure and organization

1. Root Directory: The root directory of the project serves as the main entry point.
   Root Directory ->> [000_cloud_project/v1.1](https://github.com/techgrounds/techgrounds-anj-dtmr/tree/main/000_cloud_project/v1.1)

   Please note that I divided the directories of my v1.0 and v1.1 for my own learning and documentation.

2. Bicep Files: Bicep files have the .bicep extension and define the infrastructure resources and their configurations in a declarative manner.
   Bicep Files ->> [000_cloud_project/v1.1/bicep_files](https://github.com/techgrounds/techgrounds-anj-dtmr/tree/main/000_cloud_project/v1.1/bicep_files)

3. Modules Directory: The modules directory contains reusable Bicep modules.
   Modules Directory ->> [000_cloud_project/v1.1/bicep_files/modules](https://github.com/techgrounds/techgrounds-anj-dtmr/tree/main/000_cloud_project/v1.1/bicep_files/modules)

4. Scripts: The scripts directory contain scripts or utilities used in this project, such as deployment scripts, helper scripts, or configuration scripts.
   Scripts Directory ->> [000_cloud_project/v1.1/bash](https://github.com/techgrounds/techgrounds-anj-dtmr/tree/main/000_cloud_project/v1.1/bash)

5. [Documentation Directory](https://github.com/techgrounds/techgrounds-anj-dtmr/tree/main/000_cloud_project/v1.1/Documentation): All the markdown files I wrote consist of the deployment process documentation and all the deliverables.

## File and Directory Purpose

- README.md: The readme file of the Root Directory [000_cloud_project/v1.1](https://github.com/techgrounds/techgrounds-anj-dtmr/tree/main/000_cloud_project/v1.1) provides an overview of the project, its purpose, and instructions on how to use or contribute to the project. It includes information on prerequisites, setup instructions, and deployment steps.

- [main.bicep](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/bicep_files/main.bicep): The main.bicep file is the entry point of the Bicep project. In v1.0, it will contain all the resources that I successfully can deploy. In v1.1 I will develop it into a file where defines the main infrastructure resources and their relationships. It includes imports to other Bicep files or modules.

- deploy.sh: Deployment scripts or files provide automation for deploying the infrastructure. They may use the Azure CLI or other deployment tools to execute the deployment process. Check the [Deployment Process](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/Documentation/04_deployment_process.md) for instructions.

## Naming Conventions and Guidelines

- File and Directory Naming: I followed descriptive and meaningful names for files and directories to enhance readability and understandability. Used lowercase letters, hyphens, or underscores to separate words in names for better consistency.

- Module Naming: When I created modules, I used descriptive names that reflect their purpose or functionality. For example, a module for creating an Azure Virtual Network for web server could be named web-vnet.bicep.

- Resource Naming: I adhere to consistent naming conventions for resources, such as prefixes or suffixes that identify the resource type or purpose. This helps maintain clarity and ease of understanding across the project.

- Parameter Naming: Parameters have meaningful names that reflect their purpose or usage. I used lowercase letters and underscores to separate words in parameter names.

- Variable Naming: Similar to parameters, variables have meaningful names that reflect their purpose or the value they hold. I used lowercase letters and underscores to separate words in variable names.
