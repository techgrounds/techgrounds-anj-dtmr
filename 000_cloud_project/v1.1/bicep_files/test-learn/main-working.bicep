/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// cd 000_cloud_project/v1.1/bicep_files
// ./deploy.sh 
// az group create --name Testv11RGcloud_project --location westeurope
// az deployment group create --resource-group Testv11RGcloud_project --template-file main.bicep

/* -------------------------------------------------------------------------- */
/*                    RESOURCE GROUP & LOCATION                               */
/* -------------------------------------------------------------------------- */

param resourceGroupName string = 'cloud_proj'
param location string = 'uksouth'

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

param vaultNamePrefix string = 'myvault'

var uniqueSuffix = uniqueString(substring(resourceGroup().id, 0, 10), deployment().name)

var keyVaultName = '${vaultNamePrefix}${uniqueSuffix}'

module keyVaultModule 'modules/keyvault.bicep' = {
  name: keyVaultName
  params: {
    adminPassword: adminPasswordMngmnt
    adminUserName: adminPasswordMngmnt
    location: location
    principalId: ''
    envName: 'dev'
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

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

// nsg
@description('Name of the network security group.')
param nsgManagementName string = 'management-nsg'

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

// vnet
@description('Name of the virtual network.')
param vnetManagementName string = 'management-vnet'

// subnet
@description('Name of the subnet within the virtual network.')
param subnetManagementName string = 'management-subnet'

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

// publicIpName: Name of the management public IP resource.
@description('Name of the management public IP resource.')
param managementPublicIPName string = 'management-public-ip'

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

// managementNetworkInterfaceName: Name of the created management network interface.
@description('Name of the created management network interface.')
param managementNetworkInterfaceName string = 'management-nic'

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

@description('Prefix for the storage account name.')
param storageAccountManagementPrefix string = 'stgmngmt'

// storageAccountManagementName: Name of the storage account.
@description('Name of the storage account.')
param storageAccountManagementName string = '${storageAccountManagementPrefix}${uniqueString(resourceGroup().id)}'

module storageAccountManagementModule 'modules/man-storage.bicep' = {
  name: storageAccountManagementName
  params: {
    location: location
    storageAccountManagementName: storageAccountManagementName
  }
}

/* -------------------------------------------------------------------------- */
/*                     Virtual Machine / Server                               */
/* -------------------------------------------------------------------------- */

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

// /* -------------------------------------------------------------------------- */
// /*                     APP GATEWAY                                             */
// /* -------------------------------------------------------------------------- */

param applicationGateWayName string = 'applicationGateWayName'

module applicationGateWayVMSSModule 'modules/web-ag-vmss.bicep' = {
  name: applicationGateWayName
  params: {
    applicationGateWayName: applicationGateWayName
    location: location
  }
}

/* -------------------------------------------------------------------------- */
/*                     PEERING                                                */
/* -------------------------------------------------------------------------- */

// vnet
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string = 'webapp-vnet'

param vnetwebappvnetmngntPeeringName string = 'vnetwebappvnetmngntPeeringName'

module vnetwebappvnetmngntPeeringModule 'modules/web-peering.bicep' = {
  name: vnetwebappvnetmngntPeeringName
  params: {
    virtualNetworkName_webapp: virtualNetworkName_webapp
    vnetManagementName: vnetManagementModule.name
  }
}

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
param managementServerSqlFirewallRulesName string = 'mansqlFirewallRules'

// Name of the web server SQL firewall rules
@description('Name of the web server SQL firewall rules.')
param webServerFirewallRulesName string = 'websqlFirewallRules'

module dbModule 'modules/db.bicep' = {
  name: mysqlDBName
  params: {
    mysqlDBName: mysqlDBName
    location: location
    sqladminLogin: sqladminLogin
    sqladminLoginPassword: sqladminLoginPassword
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
/* -------------------------------------------------------------------------- */
/*                     STORAGE - POST SCRIPT WITH PRIVATE CONTAINER           */
/* -------------------------------------------------------------------------- */

param storageAccountPrefix string = 'storage'
param storageAccountName string = '${storageAccountPrefix}${uniqueString('storage', resourceGroup().id)}'

module storagePostscriptModule 'modules/storage-postscript.bicep' = {
  name: storageAccountName
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}
