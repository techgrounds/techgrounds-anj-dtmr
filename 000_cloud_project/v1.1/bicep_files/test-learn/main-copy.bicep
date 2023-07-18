/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// cd 000_cloud_project/v1.1/bicep_files
// ./deploy.sh 
// az group create --name Testv11RGcloud_project --location westeurope
// az deployment group create --resource-group Testv11RGcloud_project --template-file main.bicep

// /* -------------------------------------------------------------------------- */
// /*                     LOCATION FOR EVERY RESOURCE                            */
// /* -------------------------------------------------------------------------- */

// // location
// @description('Location for all resources.')
// param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                    RESOURCE GROUP                                          */
/* -------------------------------------------------------------------------- */

param resourceGroupName string = 'my-resource-group'
param location string = 'westeurope'

module resourceGroupModule 'modules/resourcegrp.bicep' = {
  scope: subscription()
  name: resourceGroupName
  params: {
    location: location
    resourceGroupName: resourceGroupName
  }
}

/* -------------------------------------------------------------------------- */
/*                              Key Vault                                     */
/* -------------------------------------------------------------------------- */

// param keyVaultName string = uniqueString('mykeyvault', resourceGroup().id)

param vaultNamePrefix string = 'myvault'

var uniqueSuffix = uniqueString(substring(resourceGroup().id, 0, 10), deployment().name)

var keyVaultName = '${vaultNamePrefix}${uniqueSuffix}'

module keyVaultModule 'modules/keyvault.bicep' = {
  name: keyVaultName
  params: {
    keyVaultName: keyVaultName
    location: location
  }
}

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/*                              Management                                    */
/* -------------------------------------------------------------------------- */
// The management server will be used to manage and control various resources within the Azure environment. 
// It will have a private IP address within the management subnet and a public IP address to allow external access.

/* -------------------------------------------------------------------------- */
/*                   Management  PARAMS & VARS                                */
/* -------------------------------------------------------------------------- */

// vnet
@description('Name of the virtual network.')
param vnetManagementName string = 'management-vnet'

// subnet
@description('Name of the subnet within the virtual network.')
param subnetManagementName string = 'management-subnet'

// nsg
@description('Name of the network security group.')
param nsgManagementName string = 'management-nsg'

// publicIpName: Name of the management public IP resource.
@description('Name of the management public IP resource.')
param managementPublicIPName string = 'management-public-ip'

// managementNetworkInterfaceName: Name of the created management network interface.
@description('Name of the created management network interface.')
param managementNetworkInterfaceName string = 'management-nic'

@description('Prefix for the storage account name.')
param storageAccountManagementPrefix string = 'stgmngmt'

// storageAccountManagementName: Name of the storage account.
@description('Name of the storage account.')
param storageAccountManagementName string = '${storageAccountManagementPrefix}${uniqueString(resourceGroup().id)}'

// VMmanagementName: Name of the management virtual machine.
@description('Name of the management virtual machine.')
param VMmanagementName string = 'vmmanagement'

// adminUsername: The administrator username.
// @secure()
@description('The administrator username.')
param adminUsernameMngmnt string = 'adminAnj'

// adminPassword: The administrator password.
@secure()
@description('The administrator password.')
param adminPasswordMngmnt string = 'Password@321'

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
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */

module vnetManagementModule 'modules/man-vnet.bicep' = {
  name: vnetManagementName
  params: {
    location: location
    nsgManagementName: nsgManagementModule.name
    subnetManagementName: subnetManagementName
    vnetManagementName: vnetManagementName
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
    vnetManagementName: vnetManagementName
    vnetManagementSubnetName: subnetManagementName
    nicName: managementNetworkInterfaceName
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     PEERING                                                */
// /* -------------------------------------------------------------------------- */

param vnetmngntvnetwebappPEERINGName string = 'vnetmngntvnetwebappPEERINGName'

module vnetmngntvnetwebappPeeringModule 'modules/man-peering.bicep' = {
  name: vnetmngntvnetwebappPEERINGName
  params: {
    vnetManagementName: vnetManagementModule.name
    virtualNetworkName_webapp: virtualNetworkName_webapp
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     MANAGEMENT SERVER - STORAGE                            */
// /* -------------------------------------------------------------------------- */

module storageAccountManagementModule 'modules/man-storage.bicep' = {
  name: storageAccountManagementName
  params: {
    location: location
    storageAccountManagementName: storageAccountManagementName
    // containerManagementName: containerManagementName
  }
}

// // /* -------------------------------------------------------------------------- */
// // /*                     MANAGEMENT SERVER - CONTAINER                          */
// // /* -------------------------------------------------------------------------- */

// // // containerManagementNamePrefix: Prefix for the storage container name.
// // @description('Prefix for the storage container name.')
// // param containerManagementInitial string = 'contmngmt'

// // @description('Prefix for the container name.')
// // param containerManagementPrefix string = '${containerManagementInitial}${uniqueString(resourceGroup().id)}'

// // containerManagementName: Name of the storage container.
// @description('Name of the storage container.')
// param containerManagementName string = '${storageAccountManagementName}contmanage'

// // // containerManagementID: ID of the storage container.
// // @description('ID of the storage container.')
// // param containerManagementID string

// // // containerManagementUrl: Public access URL of the storage container.
// // @description('Public access URL of the storage container.')
// // param containerManagementUrl string

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

module VirtualMachineManagementModule 'modules/man-vm.bicep' = {
  name: VMmanagementName
  params: {
    virtualMachineName_mngt: VMmanagementName
    adminPasswordMngmnt: adminPasswordMngmnt
    location: location
    managementNetworkInterfaceID: managementNetworkInterfaceModule.outputs.managementNetworkInterfaceID
    storageAccountManagementConnectionStringBlobEndpoint: storageAccountManagementModule.outputs.storageAccountManagementConnectionStringBlobEndpoint
  }
}

// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /*                              WEB APP                                       */
// /* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                    WEB APP PARAMS & VARS                                   */
/* -------------------------------------------------------------------------- */

// // App Gateway Subnet
// @description('Name of the web application subnet.')
// param appGateway_subnetName string = 'appGateway_subnetName'

param applicationGateWayName string = 'applicationGateWayName'

// vnet
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string = 'webapp-vnet'

param vnetwebappvnetmngntPeeringName string = 'vnetwebappvnetmngntPeeringName'

// /* -------------------------------------------------------------------------- */
// /*                     APP GATEWAY                                             */
// /* -------------------------------------------------------------------------- */

module applicationGateWayVMSSModule 'modules/web-ag-vmss.bicep' = {
  name: applicationGateWayName
  params: {
    applicationGateWayName: applicationGateWayName
    location: location
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     Network Security Group                                 */
// /* -------------------------------------------------------------------------- */

// module nsgWebAppModule 'modules/web-nsg.bicep' = {
//   name: nsgName_webapp
//   params: {
//     nsgName_webapp: nsgName_webapp
//     location: location
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     Public IP                                              */
// /* -------------------------------------------------------------------------- */

// module WebAppPublicIPModule 'modules/web-pubip.bicep' = {
//   name: publicIpName_webapp
//   params: {
//     location: location
//     publicIpName_webapp: publicIpName_webapp
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     Virtual Network with subnet and backend                */
// /* -------------------------------------------------------------------------- */

// module vnetWebAppModule 'modules/web-db-vnet.bicep' = {
//   name: virtualNetworkName_webapp
//   params: {
//     location: location

//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     Network Interface Card                                 */
// /* -------------------------------------------------------------------------- */

// module WebAppNetworkInterfaceModule 'modules/web-nic.bicep' = {
//   name: nicName_webapp
//   params: {
//     location: location
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     PEERING                                                */
// /* -------------------------------------------------------------------------- */

// resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
//   name: virtualNetworkName
// }

module vnetwebappvnetmngntPeeringModule 'modules/web-peering.bicep' = {
  name: vnetwebappvnetmngntPeeringName
  params: {
    virtualNetworkName_webapp: virtualNetworkName_webapp
    vnetManagementName: vnetManagementModule.name
  }
}

// // /* -------------------------------------------------------------------------- */
// // /*                     WEB APP - STORAGE                                      */
// // /* -------------------------------------------------------------------------- */

// param storageAccountWebAppPrefix string = 'stgwebapp'
// param storageAccountWebAppName string = '${storageAccountWebAppPrefix}${uniqueString(resourceGroup().id)}'

// module storageAccountWebAppModule 'modules/web-storage.bicep' = {
//   name: storageAccountWebAppName
//   params: {
//     storageAccountWebAppName: storageAccountWebAppName
//     location: location
//     containerWebAppName: containerWebAppName
//   }
// }

// // /* -------------------------------------------------------------------------- */
// // /*                     WEB APP - CONTAINER                                    */
// // /* -------------------------------------------------------------------------- */

// // containerManagementNamePrefix: Prefix for the storage container name.
// // @description('Prefix for the storage container name.')
// // param containerWebAppInitial string = 'contwebapp'

// // // containerManagementName: Name of the storage container.
// // @description('Name of the storage container.')
// param containerWebAppName string = '${storageAccountManagementName}contweb'

// // @description('Prefix for the container name.')
// // param containerWebAppPrefix string = '${containerWebAppInitial}${uniqueString(resourceGroup().id)}'
// // param containerWebAppName string = '${containerWebAppPrefix}${uniqueString(resourceGroup().id)}'

// module containerWebAppModule 'modules/web-storage.bicep' = {
//   name: containerWebAppName
//   params: {
//     containerWebAppName: containerWebAppName
//     storageAccountWebAppName: storageAccountWebAppModule.name
//     location: location
//   }
// }

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/*                     DATABASE                                               */
/* -------------------------------------------------------------------------- */

@description('The administrator username of the SQL logical server.')
param sqladminLogin string = 'adminAnj'

@description('The administrator password of the SQL logical server.')
@secure()
param sqladminLoginPassword string = 'Password@321'

// The name of the MySQL database.
@description('The name of the MySQL database.')
param mysqlDBName string = 'mysqlDB'

// Name of the management server SQL firewall rules
@description('Name of the management server SQL firewall rules.')
param managementServerSqlFirewallRulesName string = 'MansqlFirewallRules'

// Name of the web server SQL firewall rules
@description('Name of the web server SQL firewall rules.')
param webServerFirewallRulesName string = 'WebsqlFirewallRules'

module dbModule 'modules/db.bicep' = {
  name: mysqlDBName
  params: {
    mysqlDBName: mysqlDBName
    location: location
    sqladminLogin: sqladminLogin
    sqladminLoginPassword: sqladminLoginPassword
    // ToDo: Check how to connect this on web server and management server
    virtualNetworkName: vnetManagementModule.name
    virtualNetworkName_webapp: virtualNetworkName_webapp
    MansqlFirewallRulesName: managementServerSqlFirewallRulesName
    WebsqlFirewallRulesName: webServerFirewallRulesName
  }
}

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /*                     STORAGE - POST SCRIPT WITH PRIVATE CONTAINER           */
// /* -------------------------------------------------------------------------- */

param storageAccountPrefix string = 'storage'
param storageAccountName string = '${storageAccountPrefix}${uniqueString('storage', resourceGroup().id)}'

module storagePostscriptModule 'modules/storage-postscript.bicep' = {
  name: storageAccountName
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}
