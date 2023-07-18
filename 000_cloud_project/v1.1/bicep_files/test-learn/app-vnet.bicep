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
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// vnet
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string

// nsg
@description('Name of the web application network security group.')
param nsgName_webapp string

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' existing = {
  name: nsgName_webapp
}

// addressPrefixes
var vnet_addressPrefixes_webapp = '10.10.10.0/24'

// appGatewaySubnetAddressPrefix: The Application Gateway subnet is used to host the 
// Azure Application Gateway service. It needs its own subnet within the VNet. 
// You can allocate a subnet by using a portion of the VNet's IP address range.
// It is recommended to use a /27 subnet (32 addresses) for the Application Gateway subnet.
// var appGatewaySubnetAddressPrefix = '10.10.10.0/25'
var appGatewaySubnetAddressPrefix = '10.10.10.0/26'

// backendSubnetAddressPrefix: The backend subnet is used to host the resources that 
// the Application Gateway directs traffic to, such as virtual machines or web servers. 
// The size of the backend subnet depends on the number of resources you plan to deploy 
// in that subnet. It is recommended to allocate a larger subnet to accommodate future growth.
// var backendSubnetAddressPrefix = '10.10.10.128/25'
var backendSubnetAddressPrefix = '10.10.10.128/26'
// var backendSubnetAddressPrefix = '10.10.10.128/27'

// App Gateway
@description('Name of the web application subnet.')
param appGateway_subnetName string

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

resource vnetagvmssWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworkName_webapp
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet_addressPrefixes_webapp
      ]
    }
    subnets: [
      // {
      //   name: 'subnetName_webapp'
      //   properties: {
      //     addressPrefix: vnet_addressPrefixes_webapp
      //     privateEndpointNetworkPolicies: 'Enabled'
      //     privateLinkServiceNetworkPolicies: 'Enabled'
      //     // By associating an NSG with a subnet, we can enforce network-level security policies for the resources within that subnet.
      //     networkSecurityGroup: {
      //       id: resourceId('Microsoft.Network/networkSecurityGroups', nsgWebApp.id)
      //     }
      //   }
      // }
      {
        name: appGateway_subnetName
        properties: {
          addressPrefix: appGatewaySubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'backend-subnet'
        properties: {
          addressPrefix: backendSubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    enableDdosProtection: false
    enableVmProtection: false
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

// Name of the web application virtual network.
@description('Name of the web application virtual network.')
output vnetWebAppName string = vnetagvmssWebApp.name

// ID of the web application virtual network.
@description('ID of the web application virtual network.')
output vnetWebAppID string = vnetagvmssWebApp.id

// Name of the web application subnet.
@description('Name of the web application gateway virtual network.')
output WebAppGatewaySubnetName string = vnetagvmssWebApp.properties.subnets[0].name

// ID of the web application subnet.
@description('ID of the web application gateway subnet.')
output WebAppGatewaySubnetID string = vnetagvmssWebApp.properties.subnets[0].id

output WebAppBackEndSubnetName string = vnetagvmssWebApp.properties.subnets[1].name

output WebAppBackEndSubnetID string = vnetagvmssWebApp.properties.subnets[1].id
