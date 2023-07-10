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
- [x] have a working application with which to deploy a working management server (RDP).
- [x] have a working application with which to deploy a working web server (SSH).
- [x] have a storage solution in which bootstrap/post-deployment script can be stored. Deployed a storage account with a private container.
- [x] provide documentation or user guides to explain how to use the application.
- [x] submit a well-documentated project how to deploy an MVP for testing and deploy the infrastructure.

For the v1.0 **user stories** I was NOT able to:

- [ ] have a working application that allows to deploy a secure network. (management server has my own IP Address, web server still need to implement)
- [ ] encrypt all data in the infrastructure.
- [ ] have a backup every day that is maintained for 7 days.

For the v1.0 **requirements** I was able to:

- [x] Build this IaC project using bicep templates.
- [x] The Web server must be installed in an automated manner (I used a deploy.sh bash command).
- [x] The web & management server must be reachable by a public IP.
- [x] The admin/management server should be accessible only from trusted locations (office/admin's home).
- [x] Deploy web server, management server and post deployment script with separate azure storage accounts for data isolation.
- [x] The following IP ranges are used: 10.10.10.0/24 & 10.20.20.0/24.
- [x] All subnets must be protected by a firewall at the subnet level.
- [x] Peer the two vnets.
- [x] Connect all the resources, using NIC, to the vnet of both servers. (NIC for azure network/resources. Public Ip for the outside network)
- [x] Understand the need of a public IP for the web server (app users) and management server (admins).
- [x] Deploy a Key Vault.
- [x] Use Github Release to tag the v1.0.
- [x] Deploy a resource group using azure cli.
- [x] I should submit a GitHub repository with .bicep files on the main branch.
- [x] Portal cost under 10 euros.
- [x] Use GitHub branches for version control.
- [x] Customize apache script for the web server.

For the v1.0 **requirements** I was NOT able to:

- [ ] SSH connections to the Web server should only be established from the admin server.
- [ ] Deploy a SQL Database that is connected to both the web server and admin/management server.
- [ ] Deploy a Recovery Service Vault. The Web server should be backed up daily. Backups must be retained for 7 days. Create a Recovery Services Vault and configure it to back up the VMSSs in the webserver subnet.
- [ ] Deploy the VM's to an Availability Set
- [ ] All VM disks must be encrypted.
- [ ] (Not a must but best practice) Use module writing the bicep template.
- [ ] Utilize Key Vault to securely store any secrets or credentials required for accessing and executing the bootstrap/post-deployment scripts.
- [ ] Use Key Vault to manage and store the cryptographic keys required for encrypting and decrypting the data within the infrastructure.
- [ ] Connect the web and admin server to the Key Vault to retrieve necessary secrets.
- [ ] (If time allow) Excel file of estimations for all the resources prices.

## My v1.1 Project Architecture

![image info](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/Documentation/06_diagram/cloud_architecture.drawio.png)

Update:

- [x] Deploy management network & server using bicep module (with vnet peering)
- [x] With module the RDP for management server is still working
- [x] Learned how to dynamically assign name for key vault, db server, storage
- [x] Chain module. loc->rg->key vault->network->vm/vmss etc
- [x] Deploy web network using bicep module (with vnet peering)
- [x] Deploy a SQL Database that is connected to both the web server and admin/management server using private endpoint->nic->vnets.
- [x] Used for loops for nic, nsg, public ip to follow the capacity of VMSS
- [x] Web server vnet with two subnets for application gateway (frontend IP) and for the backend pool where I can connect the VMSS

What I know:

- [x] SSH is an internal connection between web server and admin/management server
- [x] Self-signed certificates are usually used for testing environment
- [x] Application Gateway fulfull most of the v1.1 requirements for Proxy, HTTPS, TLS, Load Balancing, Health Checks, Web Application Firewall (WAF) and combining it with VMSS for Auto Scaling
- [x] HTTPS Listener is a protocol
- [x] ping is another protocol

Favorite Error messages so far:

- [x] "message": "At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details."
- [x] Database: "code":"MissingRegistrationForLocation","message":"The subscription is not registered for the resource type 'privateDnsZones' in the location 'westeurope'. Please re-register for this provider in order to have access to this location.". See deploy.sh for solution that is not working YET.
- [x] ping DB: Packets: Sent = 4, Received = 0, Lost = 4 (100% loss)
- [x] web-main.bicep: Inner Errors:"code": "InvalidJsonResourceType", "message": "Value for resource type Microsoft.WindowsAzure.Networking.Nrp.Frontend.Contract.Csm.Public.ApplicationGateway is invalid, exception: Requested value 'Internal' was not found."

Next Steps:

- [ ] Created an isolated web-main.bicep to deploy the VMSS with Application Gateway
- [ ] Read: https://www.microsoftpressstore.com/articles/article.aspx?p=3145764&seqNum=3

Backlogs for both versions:

- [ ] SSH connections to the Web server should only be established from the admin server.
- [ ] Configure apache-install.sh on web server
- [ ] Deploy the VMSS to an Availability Set
- [ ] have a working application that allows to deploy a secure network. (management server has my own IP Address, web server still need to implement)
- [ ] Deploy a Recovery Service Vault. The Web server should be backed up daily. Backups must be retained for 7 days. Create a Recovery Services Vault and configure it to back up the VMSSs in the webserver subnet.
- [ ] All VM disks must be encrypted.
- [ ] Utilize Key Vault to securely store any secrets or credentials required for accessing and executing the bootstrap/post-deployment scripts.
- [ ] Use Key Vault to manage and store the cryptographic keys required for encrypting and decrypting the data within the infrastructure.
- [ ] Connect the web and admin server to the Key Vault to retrieve necessary secrets.
- [ ] Update Topology
- [ ] Git Release v1.1

Questions:

- [ ] Do I still need a separate nsg or I can just configure the inbound and outbound traffic under app gateway.
- [ ] What is your favorite error message so far? ;)
