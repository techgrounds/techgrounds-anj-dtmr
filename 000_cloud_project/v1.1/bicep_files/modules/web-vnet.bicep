/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-vnet.bicep

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
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string

// subnet
@description('Name of the web application subnet.')
param subnetName_webapp string

// nsg
@description('Name of the web application network security group.')
param nsgName_webapp string

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' existing = {
  name: nsgName_webapp
}

// addressPrefixes
// param vnet_addressPrefixes_webapp string = '10.10.10.0/24'

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */
// In Azure, a Virtual Network (VNet) is a fundamental networking construct that enables 
// you to securely connect and isolate Azure resources, such as virtual machines (VMs), virtual 
// machine scale sets, and other services. A VNet acts as a virtual representation of a 
// traditional network, allowing you to define IP address ranges, subnets, and network security policies.

// Dependencies: Azure Subscription, Azure Resource Group, Azure Region, Address Space, Subnets, Network Security Groups (NSGs)
// Additional: VnetPeering to connect this management vnet to the app vnet for later

// The vnetWebApp resource creates a Virtual Network (VNet) for the web application.
// I've created a separate vnet for the web app side to isolate it from the other cloud infrastracture
// This segregation helps improve security and network performance by controlling traffic flow between resources.
// Within VNet, I created a subnet to further segment the resources inside the vnet like virtual machine for the server

resource vnetWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworkName_webapp
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
    subnets: [
      {
        name: subnetName_webapp
        properties: {
          addressPrefix: '10.10.10.0/24'
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          // By associating an NSG with a subnet, we can enforce network-level security policies for the resources within that subnet.
          networkSecurityGroup: {
            id: resourceId('Microsoft.Network/networkSecurityGroups', nsgWebApp.name)
          }
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

// Name of the web application virtual network.
@description('Name of the web application virtual network.')
output vnetWebAppName string = vnetWebApp.name

// ID of the web application virtual network.
@description('ID of the web application virtual network.')
output vnetWebAppID string = vnetWebApp.id

// Name of the web application subnet.
@description('Name of the web application virtual network.')
output WebAppSubnetName string = vnetWebApp.properties.subnets[0].name

// ID of the web application subnet.
@description('ID of the web application subnet.')
output WebAppSubnetID string = vnetWebApp.properties.subnets[0].id
