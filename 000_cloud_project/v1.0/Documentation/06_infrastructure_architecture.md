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

For the v1.0 **user stories** I was able to:
- [x] have a clear understanding what the requirements of the application are.
- [x] have a clear record of the assumptions.
- [x] have a clear overview of the Cloud Infrastructure the application needs.
- [x] have a working application with which to deploy a working management server.
- [x] have a working application with which to deploy a working web server.
- [x] have a working application that allows to deploy a secure network.
- [x] have a storage solution in which bootstrap/post-deployment script can be stored.
- [x] write documentation how to use the application.
- [x] write documentation how to deploy an MVP for testing.

For the v1.0 **user stories** I was NOT able to:
- [ ] encrypt all data in the infrastructure.
- [ ] have a backup every day that is maintained for 7 days.

For the v1.0 **requirements** I was able to:
- [x] Build this IaC project using bicep template.
- [x] The Web server must be installed in an automated manner (I used a deploy.sh bash command).
- [x] The admin/management server must be reachable by a public IP.
- [x] The admin/management server should be accessible only from trusted locations (office/admin's home).
- [x] The following IP ranges are used: 10.10.10.0/24 & 10.20.20.0/24.
- [x] All subnets must be protected by a firewall at the subnet level.
- [x] SSH connections to the Web server should only be established from the admin server.
- [x] Peer the two vnets.
- [x] Connect all the resources, using NIC, to the vnet of both servers.
- [x] Understand the need of a public IP for the web server must.
- [x] Deploy a Key Vault.
- [x] Use Github Release to tag the v1.0.


For the v1.0 **requirements** I was NOT able to:
- [ ] Deploy a SQL Database that is connected to the both servers only.
- [ ] Deploy a Recovery Service Vault
- [ ] Deploy the VM's to an Availability Set
- [ ] All VM disks must be encrypted.
- [ ] The Web server should be backed up daily. Backups must be retained for 7 days.








