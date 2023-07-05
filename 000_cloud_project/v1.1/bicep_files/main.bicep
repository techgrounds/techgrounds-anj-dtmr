/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// cd 000_cloud_project/v1.1/bicep_files
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file main.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

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
    nsgName: nsgManagementModule.name
    location: location
    subnetName: vnetManagementSubnetName
    virtualNetworkName: vnetManagementName
    // vnet_addressPrefixes: vnet_addressPrefixes
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

param vnetmngntvnetwebappPEERINGName string = 'vnetmngntvnetwebappPEERINGName'

module vnetmngntvnetwebappPeeringModule 'modules/man-peering.bicep' = {
  name: vnetmngntvnetwebappPEERINGName
  params: {
    vnetManagementName: vnetManagementModule.name
    virtualNetworkName_webapp: vnetWebAppModule.name
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

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/*                              WEB APP                                       */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// vnet
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string = 'webapp-vnet'

// subnet
@description('Name of the web application subnet.')
param subnetName_webapp string = 'webapp-subnet'

// nsg
@description('Name of the web application network security group.')
param nsgName_webapp string = 'webapp-nsg'

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

module nsgWebApp 'modules/web-nsg.bicep' = {
  name: nsgName_webapp
  params: {
    nsgName_webapp: nsgName_webapp
    location: location
  }
}

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */

module vnetWebAppModule 'modules/web-vnet.bicep' = {
  name: virtualNetworkName_webapp
  params: {
    virtualNetworkName_webapp: virtualNetworkName_webapp
    location: location
    nsgName_webapp: nsgWebApp.name
    subnetName_webapp: subnetName_webapp
  }
}

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */

// public ip
param publicIpName_webapp string = 'webapp-public-ip'

module WebAppPublicIP 'modules/web-pubip.bicep' = {
  name: publicIpName_webapp
  params: {
    location: location
    publicIpName_webapp: publicIpName_webapp
  }
}

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */

// nic
param nicName_webapp string = 'webapp-nic'

module WebAppNetworkInterface 'modules/web-nic.bicep' = {
  name: nicName_webapp
  params: {
    location: location
    nicName_webapp: nicName_webapp
    nsgName_webapp: nsgWebApp.name
    publicIpName_webapp: WebAppPublicIP.name
    subnetName_webapp: subnetName_webapp
    virtualNetworkName_webapp: vnetWebAppModule.name
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     PEERING                                                */
// /* -------------------------------------------------------------------------- */

param vnetwebappvnetmngntPeeringName string = 'vnetwebappvnetmngntPeeringName'

module vnetwebappvnetmngntPeeringModule 'modules/web-peering.bicep' = {
  name: vnetwebappvnetmngntPeeringName
  params: {
    virtualNetworkName_webapp: vnetWebAppModule.name
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
param sqladminLogin string

@description('The administrator password of the SQL logical server.')
@secure()
param sqladminLoginPassword string

// // The name of the SQL server.
// @description('The name of the SQL server.')
// param sqlServerName string

// // The ID of the SQL server.
// @description('The ID of the SQL server.')
// param sqlServerID string

// The name of the MySQL database.
@description('The name of the MySQL database.')
param mysqlDBName string = 'mysqlDB'

// // The ID of the MySQL database.
// @description('The ID of the MySQL database.')
// param mysqlDBID string

// // Private Endpoint for the SQL database in each VNet
// @description('Name of the Private Endpoint for the SQL database in each VNet.')
// param privateEndpointManagementName string

// // ID of the Private Endpoint for the SQL database in each VNet
// @description('ID of the Private Endpoint for the SQL database in each VNet.')
// param privateEndpointManagementID string

// // Name of the Private Link Service Connection for the management Private Endpoint
// @description('Name of the Private Link Service Connection for the management Private Endpoint.')
// param manPrivateLinkServiceConnectionsName string
// // ID of the Private Link Service Connection for the management Private Endpoint
// @description('ID of the Private Link Service Connection for the management Private Endpoint.')
// param manPrivateLinkServiceConnectionsID string

// Name of the management server SQL firewall rules
@description('Name of the management server SQL firewall rules.')
param managementServerSqlFirewallRulesName string = 'MansqlFirewallRules'

// // ID of the management server SQL firewall rules
// @description('ID of the management server SQL firewall rules.')
// param managementServerSqlFirewallRulesID string

// // Private Endpoint for the SQL database in each VNet
// @description('Name of the Private Endpoint for the SQL database in each VNet.')
// param privateEndpointWebAppName string

// // ID of the Private Endpoint for the SQL database in each VNet
// @description('ID of the Private Endpoint for the SQL database in each VNet.')
// param privateEndpointWebAppID string

// // Name of the Private Link Service Connection for the web/app Private Endpoint
// @description('Name of the Private Link Service Connection for the web/app Private Endpoint.')
// param webPrivateLinkServiceConnectionsName string

// // ID of the Private Link Service Connection for the web/app Private Endpoint
// @description('ID of the Private Link Service Connection for the web/app Private Endpoint.')
// param webPrivateLinkServiceConnectionsID string

// Name of the web server SQL firewall rules
@description('Name of the web server SQL firewall rules.')
param webServerFirewallRulesName string = 'WebsqlFirewallRules'

// // ID of the web server SQL firewall rules
// @description('ID of the web server SQL firewall rules.')
// param webServerFirewallRulesID string

module dbModule 'modules/db.bicep' = {
  name: mysqlDBName
  params: {
    mysqlDBName: mysqlDBName
    location: location
    sqladminLogin: sqladminLogin
    sqladminLoginPassword: sqladminLoginPassword
    // ToDo: Check how to connect this on web server and management server
    virtualNetworkName: vnetManagementModule.name
    virtualNetworkName_webapp: vnetWebAppModule.name
    MansqlFirewallRulesName: managementServerSqlFirewallRulesName
    WebsqlFirewallRulesName: webServerFirewallRulesName
  }
}
