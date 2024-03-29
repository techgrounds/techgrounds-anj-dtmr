/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file man-vnet.bicep

// Management Server: 10.20.20.0/24
// Web/App Server: 10.10.10.0/24

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// vnet
@description('Name of the virtual network.')
param vnetManagementName string

// subnet
@description('Name of the subnet within the virtual network.')
param subnetManagementName string

// nsg
@description('Name of the network security group.')
param nsgManagementName string

resource nsgManagement 'Microsoft.Network/networkSecurityGroups@2022-11-01' existing = {
  name: nsgManagementName
}
// addressPrefixes
// @description('Address prefix for the virtual network.')
// param vnet_addressPrefixes string

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */
// In Azure, a Virtual Network (VNet) is a fundamental networking construct that enables 
// you to securely connect and isolate Azure resources, such as virtual machines (VMs), virtual 
// machine scale sets, and other services. A VNet acts as a virtual representation of a 
// traditional network, allowing you to define IP address ranges, subnets, and network security policies.

// Dependencies: Azure Subscription, Azure Resource Group, Azure Region, Address Space (IP Range?), Subnets, Network Security Groups (NSGs)
// Additional: VnetPeering to connect this management vnet to the app vnet for later

// This creates a virtual network for the management side
// I've created a separate vnet for the management side to isolate it from the other cloud infrastracture
// This segregation helps improve security and network performance by controlling traffic flow between resources.
// Within VNet, I created a subnet to further segment the resources inside the vnet like virtual machine for the server

// The Bicep template creates a virtual network with a subnet for the management server. 
// The subnet is associated with a network security group to enforce network-level security policies.

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnetManagementName
  location: location
  properties: {
    addressSpace: {
      // addressPrefixes: [
      //   vnet_addressPrefixes
      // ]
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    // I wrote the subnet inside vnet because of best practice

    // managementSubnet: The management subnet is defined first as it serves as the foundational 
    // component for the other resources. It specifies the address prefix for the subnet where the 
    // management server will be deployed.
    subnets: [
      {
        name: subnetManagementName
        properties: {
          // addressPrefix: vnet_addressPrefixes
          addressPrefix: '10.20.20.0/24'
          // By associating an NSG with a subnet, we can enforce network-level security policies for the resources within that subnet.
          networkSecurityGroup: {
            id: resourceId('Microsoft.Network/networkSecurityGroups', nsgManagement.name)
          }
          // serviceEndpoints: [
          //   // Add service endpoints if required
          // ]
          // // ToDo: Check the requirements if delegation is needed
          // delegation: {
          //   name: 'delegation'
          //   properties: {
          //     serviceName: 'Microsoft.Authorization/roleAssignments'
          //   }
          // privateEndpointNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

@description('Name of the created virtual network.')
output vnetManagementName string = vnetManagement.name

@description('ID of the created virtual network.')
output vnetManagementID string = vnetManagement.id

@description('Name of the created subnet inside virtual network.')
output vnetManagementSubnetName string = vnetManagement.properties.subnets[0].name

@description('ID of the subnet within the created virtual network.')
output vnetManagementSubnetID string = vnetManagement.properties.subnets[0].id
