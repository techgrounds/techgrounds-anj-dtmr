/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file man-nsg.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location: Location for all resources.
@description('Location for all resources.')
param location string

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// vnetManagementName: Name of the virtual network.
@description('Name of the virtual network.')
param vnetManagementName string

// // vnetManagementID: ID of the created virtual network.
// @description('ID of the created virtual network.')
// param vnetManagementID string

// vnetManagementSubnetName: Name of the subnet within the virtual network.
@description('Name of the subnet within the virtual network.')
param vnetManagementSubnetName string

// // vnetManagementSubnetID: ID of the subnet within the created virtual network.
// @description('ID of the subnet within the created virtual network.')
// param vnetManagementSubnetID string

// managementPublicIPID: ID of the created management public IP resource.
@description('ID of the created management public IP resource.')
param managementPublicIPID string

// // nsgManagementName: Name of the network security group.
// @description('Name of the network security group.')
// param nsgManagementName string

// // vnet_addressPrefixes: Address prefix for the virtual network.
// @description('Address prefix for the virtual network.')
// param vnet_addressPrefixes string

// nicName: Name of the management network interface.
@description('Name of the management network interface.')
param nicName string

// IPConfigName: Name of the IP configuration.
@description('Name of the IP configuration.')
param IPConfigName string = 'management-ipconfig'

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */
// managementNetworkInterface: The management network interface is defined next. It depends on the 
// managementNSG because it needs the NSG's configuration to associate the security rules with the 
// network interface. By placing the network interface definition here, we ensure that the NSG is created
//  and its properties are accessible.

// The network interface is responsible for connecting the resource to the VNet and a specific subnet within the VNet.

// Dependencies: Public IP

resource managementNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: nicName
  location: location
  // dependsOn: [
  //   nsgManagement
  // ]
  properties: {
    ipConfigurations: [
      {
        name: 'management-ipconfig'
        properties: {
          subnet: {
            // The ID is written like this because I wrote down the subnet inside the vnet
            // '${vnetManagement.id}/subnets/${subnetName}'
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetManagementName, vnetManagementSubnetName)
          }
          privateIPAddress: '10.20.20.10'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: managementPublicIPID
          }
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

// managementNetworkInterfaceName: Name of the created management network interface.
@description('Name of the created management network interface.')
output managementNetworkInterfaceName string = managementNetworkInterface.name

// managementNetworkInterfaceID: ID of the created management network interface.
@description('ID of the created management network interface.')
output managementNetworkInterfaceID string = managementNetworkInterface.id
