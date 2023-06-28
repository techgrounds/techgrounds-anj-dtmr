# Getting Started

This file:

- Describe the prerequisites for using the Bicep project (e.g., required tools, permissions, dependencies).
- Provide instructions for setting up the development environment (installing Bicep CLI, configuring Azure credentials, etc.).
- Explain how to clone or download the project repository.

- [ ] [A working CDK / Bicep app from the MVP + Documentatie voor het gebruik van de applicatie + Configuratie voor een MVP deployment](https://github.com/techgrounds/techgrounds-anj-dtmr/tree/main/000_cloud_project/bicep_files)

This Bicep file deploys a secure network infrastructure with a management server and web server.

Parameters:

- adminUsername: The username for the admin account.
- adminPassword: The password for the admin account.
- vmNamePrefix: The prefix to use for VM names.
- location: The location for all resources.
- vmSize: The size of the virtual machines.

Variables:

- availabilitySetName: The name of the availability set.
- storageAccountType: The type of the storage account.
- storageAccountName: The name of the storage account.
- virtualNetworkName: The name of the virtual network.
- subnetName: The name of the backend subnet.
- loadBalancerName: The name of the internal load balancer.
- networkInterfaceName: The name of the network interface.
- subnetRef: The reference to the subnet.
- numberOfInstances: The number of VM instances.

Resources:

- storageAccount: Deploys a storage account for VM disks and backups.
- availabilitySet: Deploys an availability set for high availability and fault tolerance.
- virtualNetwork: Deploys a virtual network for network isolation.
- subnetManagement: Deploys a subnet for the management server.
- subnetApplication: Deploys a subnet for the application server.
- nsgManagementSubnet: Deploys a network security group for the management subnet.
- nsgApplicationSubnet: Deploys a network security group for the application subnet.
- networkInterface: Deploys network interfaces for the VM instances.
- loadBalancer: Deploys an internal load balancer for traffic distribution.
- vm: Deploys the virtual machines.

Additional resources:

- publicIPAddress: Deploys a public IP address for the management server.
- managementNetworkInterface: Deploys a network interface for the management server.
- managementNsgRuleSSH: Configures an NSG rule to allow SSH access to the management server.
- managementNsgRuleRDP: Configures an NSG rule to allow RDP access to the management server.
- bootstrapStorageAccount: Deploys a storage account to store bootstrap and post-deployment scripts.
- backupSolution: Deploys the backup solution for the VMs.
