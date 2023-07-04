/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file main.bicep

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
@description('Name of the virtual network.')
param vnetManagementName string = 'management-vnet'

// subnet
@description('Name of the subnet within the virtual network.')
param vnetManagementSubnetName string = 'management-subnet'

// // subnet ID
// @description('ID of the subnet within the created virtual network.')
// param vnetManagementSubnetID string

// nsg
@description('Name of the network security group.')
param nsgManagementName string = 'management-nsg'

// addressPrefixes
@description('Address prefix for the virtual network.')
param vnet_addressPrefixes string = '10.20.20.0/24'

// publicIpName: Name of the management public IP resource.
@description('Name of the management public IP resource.')
param managementPublicIPName string = 'management-public-ip'

// // managementPublicIPID: ID of the created management public IP resource.
// @description('ID of the created management public IP resource.')
// param managementPublicIPID string

// // managementPublicIPAddress: IP address of the created management public IP resource.
// @description('IP address of the created management public IP resource.')
// param managementPublicIPAddress string

// // managementDnsDomainNameLabel: Domain name label of the created management public IP resource.
// @description('Domain name label of the created management public IP resource.')
// param managementDnsDomainNameLabel string

// managementNetworkInterfaceName: Name of the created management network interface.
@description('Name of the created management network interface.')
param managementNetworkInterfaceName string = 'management-nic'

// // vnetmngntvnetwebappPEERINGId: ID of the VNet peering between the management VNet and the app VNet.
// @description('ID of the VNet peering between the management VNet and the app VNet.')
// param vnetmngntvnetwebappPEERINGId string

// // vnetmngntvnetwebappPEERINGName: Name of the VNet peering between the management VNet and the app VNet.
// @description('Name of the VNet peering between the management VNet and the app VNet.')
// param vnetmngntvnetwebappPEERINGName string

@description('Prefix for the storage account name.')
param storageAccountManagementPrefix string = 'stgmngmt'

// storageAccountManagementName: Name of the storage account.
@description('Name of the storage account.')
param storageAccountManagementName string = '${storageAccountManagementPrefix}${uniqueString(resourceGroup().id)}'

// storageAccountManagementID: ID of the storage account.
// @description('ID of the storage account.')
// param storageAccountManagementID string

// // storageAccountManagementConnectionStringBlobEndpoint: Blob endpoint of the storage account's primary endpoint.
// @description('Blob endpoint of the storage account\'s primary endpoint.')
// param storageAccountManagementConnectionStringBlobEndpoint string

// containerManagementNamePrefix: Prefix for the storage container name.
@description('Prefix for the storage container name.')
param containerManagementNamePrefix string = 'contmngmt'

@description('Prefix for the container name.')
param containerManagementPrefix string = '${containerManagementNamePrefix}${uniqueString(resourceGroup().id)}'

// containerManagementName: Name of the storage container.
@description('Name of the storage container.')
param containerManagementName string = '${storageAccountManagementName}/default/${containerManagementPrefix}'

// // containerManagementID: ID of the storage container.
// @description('ID of the storage container.')
// param containerManagementID string

// // containerManagementUrl: Public access URL of the storage container.
// @description('Public access URL of the storage container.')
// param containerManagementUrl string

// VMmanagementName: Name of the management virtual machine.
@description('Name of the management virtual machine.')
param VMmanagementName string = 'vmmanagement'

// // VMmanagementID: ID of the management virtual machine.
// @description('ID of the management virtual machine.')
// param VMmanagementID string

// adminUsername: The administrator username.
// @secure()
@description('The administrator username.')
param adminUsernameMngmnt string

// adminPassword: The administrator password.
@secure()
@description('The administrator password.')
param adminPasswordMngmnt string = 'Password@321'

/* -------------------------------------------------------------------------- */
/*                              Management                                    */
/* -------------------------------------------------------------------------- */
// The management server will be used to manage and control various resources within the Azure environment. 
// It will have a private IP address within the management subnet and a public IP address to allow external access.

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */

module vnetManagementModule 'modules/man-vnet.bicep' = {
  name: vnetManagementName
  params: {
    nsgName: nsgManagementModule.name
    location: location
    subnetName: vnetManagementSubnetName
    virtualNetworkName: vnetManagementName
    vnet_addressPrefixes: vnet_addressPrefixes
  }
}

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

module nsgManagementModule 'modules/man-nsg.bicep' = {
  name: nsgManagementName
  params: {
    location: location
    nsgName: nsgManagementName
  }
}

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */

module managementPublicIPModule 'modules/man-pubip.bicep' = {
  name: managementPublicIPName
  params: {
    location: location
    publicIpName: managementPublicIPName
  }
}

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */

module managementNetworkInterfaceModule 'modules/man-nic.bicep' = {
  name: managementNetworkInterfaceName
  params: {
    location: location
    managementPublicIPID: managementPublicIPModule.outputs.managementPublicIPID
    nsgManagementName: nsgManagementModule.name
    vnet_addressPrefixes: vnet_addressPrefixes
    vnetManagementID: vnetManagementModule.outputs.vnetManagementID
    vnetManagementName: vnetManagementName
    vnetManagementSubnetID: vnetManagementModule.outputs.vnetManagementSubnetID
    vnetManagementSubnetName: vnetManagementSubnetName
    nicName: managementNetworkInterfaceName
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     PEERING                                                */
// /* -------------------------------------------------------------------------- */

// module vnetmngntvnetwebappPeeringModule 'modules/man-peering.bicep' = {
//   name: vnetmngntvnetwebappPEERINGName
//   params: {
//     vnetManagementName: vnetManagementName
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     MANAGEMENT SERVER - STORAGE                            */
// /* -------------------------------------------------------------------------- */

module storageAccountManagementModule 'modules/man-storage.bicep' = {
  name: storageAccountManagementName
  params: {
    location: location
    storageAccountManagementName: storageAccountManagementName
    containerManagementName: containerManagementName
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     MANAGEMENT SERVER - CONTAINER                          */
// /* -------------------------------------------------------------------------- */

// module containerManagementModule 'modules/man-storage.bicep' = {
//   name: containerManagementName
//   params: {
//     location: location
//     storageAccountManagementName: storageAccountManagementName
//     containerManagementName: containerManagementName
//   }
// }

/* -------------------------------------------------------------------------- */
/*                     Virtual Machine / Server                               */
/* -------------------------------------------------------------------------- */

module VMmanagement 'modules/man-vm.bicep' = {
  name: VMmanagementName
  params: {
    virtualMachineName_mngt: VMmanagementName
    adminPasswordMngmnt: adminPasswordMngmnt
    location: location
    managementNetworkInterfaceID: managementNetworkInterfaceModule.outputs.managementNetworkInterfaceID
    storageAccountManagementConnectionStringBlobEndpoint: storageAccountManagementModule.outputs.storageAccountManagementConnectionStringBlobEndpoint
  }
}
