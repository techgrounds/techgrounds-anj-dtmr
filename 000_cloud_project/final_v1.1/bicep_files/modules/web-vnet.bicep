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
var virtualNetworkName_webapp = 'webapp-vnet'
// subnet
var subnetName_webapp = 'webapp-subnet'
// nsg
var nsgName_webapp = 'webapp-nsg'

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

resource vnetWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworkName_webapp
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet_addressPrefixes_webapp
      ]
    }
    // I wrote the subnet inside vnet because of best practice

    // Subnet: The subnet is defined first as it serves as the foundational 
    // component for the other resources. It specifies the address prefix for the subnet where the 
    // web server will be deployed.
    subnets: [
      {
        name: subnetName_webapp
        properties: {
          addressPrefix: vnet_addressPrefixes_webapp
          // By associating an NSG with a subnet, we can enforce network-level security policies for the resources within that subnet.
          networkSecurityGroup: {
            id: resourceId('Microsoft.Network/networkSecurityGroups', nsgName_webapp)
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
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */
// ToDo:
// - add output from other resources

output vnetWebAppName string = vnetWebApp.name
output vnetWebAppID string = vnetWebApp.id
output WebAppSubnetID string = vnetWebApp.properties.subnets[0].id
