/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-nic.bicep

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
var virtualNetworkName_webapp = 'webapp-vnet'
// subnet
var subnetName_webapp = 'webapp-subnet'
// nsg
var nsgName_webapp = 'webapp-nsg'
// public ip
var publicIpName_webapp = 'webapp-public-ip'
// nic
var nicName_webapp = 'webapp-nic'
// IP config
var IPConfigName_webapp = 'webapp-ipconfig'
// addressPrefixes
var vnet_addressPrefixes_webapp = '10.10.10.0/24'
/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */
// In Azure, a Virtual Network (VNet) is a fundamental networking construct that enables 
// you to securely connect and isolate Azure resources, such as virtual machines (VMs), virtual 
// machine scale sets, and other services. A VNet acts as a virtual representation of a 
// traditional network, allowing you to define IP address ranges, subnets, and network security policies.

// Dependencies: Azure Subscription, Azure Resource Group, Azure Region, Address Space, Subnets, Network Security Groups (NSGs)
// Additional: VnetPeering to connect this management vnet to the app vnet for later

// This creates a virtual network for the webapp side
// I've created a separate vnet for the webapp side to isolate it from the other cloud infrastracture
// This segregation helps improve security and network performance by controlling traffic flow between resources.
// Within VNet, I created a subnet to further segment the resources inside the vnet like virtual machine for the server

// // vnet
// var virtualNetworkName_webapp = 'webapp-vnet'
// // subnet
// var subnetName_webapp = 'webapp-subnet'
// // nsg
// var nsgName_webapp = 'webapp-nsg'

// // addressPrefixes
// var vnet_addressPrefixes_webapp = '10.10.10.0/24'

resource vnetWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: virtualNetworkName_webapp
}

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' existing = {
  name: nsgName_webapp
}

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */
// PublicIP: The  public IP resource is created next. It provides a 
// public IP address for the web server, allowing it to be accessible from the internet. 
// Public IP resource does not have any dependencies on other resources.

// // public ip
// var publicIpName_webapp = 'webapp-public-ip'

resource WebAppPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' existing = {
  name: publicIpName_webapp
}

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */
// The WebAppNetworkInterface resource creates a network interface for the web application. 
// It connects the web application resource to the VNet and assigns it a private 
// IP address from the subnet. It depends on the previously created NSG for network security configurations.

resource WebAppNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: nicName_webapp
  location: location
  // dependsOn: [
  //   nsgManagement
  // ]
  properties: {
    ipConfigurations: [
      {
        name: IPConfigName_webapp
        properties: {
          subnet: {
            // The ID is written like this because I wrote down the subnet inside the vnet
            // '${vnetManagement.id}/subnets/${subnetName}'
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_webapp, subnetName_webapp)
          }
          // privateIPAddress: '10.20.20.10'
          privateIPAddressVersion: 'IPv4'
          // privateIPAllocationMethod: 'Static'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: WebAppPublicIP.id
          }
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

output WebAppNetworkInterfaceName string = WebAppNetworkInterface.name
output WebAppNetworkInterfaceID string = WebAppNetworkInterface.id
