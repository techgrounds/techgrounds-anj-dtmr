# Infrastructure Architecture:

This file:

- Describe the architecture of the infrastructure provisioned by the Bicep project.
- Provide diagrams or visual representations to help readers understand the overall structure.
- Explain the purpose and functionality of each resource or module used.

## The Given Project Architecture

![image info](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.0/Documentation/06_diagram/topology.png)

According to the design of the architecture:

- I should create my network and its bicep scripts inside my subscription.
- I should utilize Key Vault for secure storage of keys and secrets.
- I should use a Recovery Service Vault for backup and disaster recovery.
- "Application subnet with NSG with webserver deployed in availability zone (2)" means that I have to create a subnet within an Azure VNet dedicated to hosting the resources of the application, and I have to configure the NSG to that subnet to define the network traffic rules for the resources within it according to other requirements. And deploy the web server in a specific availability zone (2) within an Azure region.
- "Management subnet with NSG with management server deployed in availability zone (1)" refers to a subnet within an Azure (management vnet) virtual network (VNet) that is dedicated to hosting management servers.
- "Post-deployment scripts in an Azure storage account" means use an Azure storage account for post-deployment scripts, providing necessary storage capabilities to host the script files.

## My v1.0 Project Architecture


![image info](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.0/Documentation/06_diagram/cloud_architecture.drawio.png)
