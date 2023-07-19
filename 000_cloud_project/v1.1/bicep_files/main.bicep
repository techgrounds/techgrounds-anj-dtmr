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

@description('Name of the resource group.')
param resourceGroupName string = resourceGroup().name

@description('Location for the resources.')
param location string = resourceGroup().location

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

@description('Prefix for the key vault name.')
param vaultNamePrefix string = 'keyvault'

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
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

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

@description('Name of the virtual network.')
param vnetManagementName string = 'management-vnet'

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

/* -------------------------------------------------------------------------- */
/*                     MANAGEMENT SERVER - STORAGE                            */
/* -------------------------------------------------------------------------- */

@description('Prefix for the storage account name.')
param storageAccountManagementPrefix string = 'stgmngmt'

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

@description('Name of the management virtual machine.')
param VMmanagementName string = 'vmmanagement'

@description('The administrator username.')
param adminUsernameMngmnt string = 'adminAnj'

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

/* -------------------------------------------------------------------------- */
/*                     WEB APP WITH APP GATEWAY AND THE NETWORKS NEEDED       */
/* -------------------------------------------------------------------------- */

@description('Name of the application gateway.')
param applicationGateWayName string = 'applicationGateWay'

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

@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string = 'webapp-vnet'

@description('Name of the peering between web app and management virtual networks.')
param vnetwebappvnetmngntPeeringName string = 'vnetwebappvnetmngntPeeringName'

module vnetwebappvnetmngntPeeringModule 'modules/web-peering.bicep' = {
  name: vnetwebappvnetmngntPeeringName
  params: {
    virtualNetworkName_webapp: virtualNetworkName_webapp
    vnetManagementName: vnetManagementModule.name
  }
}

/* -------------------------------------------------------------------------- */
/*                     DATABASE                                               */
/* -------------------------------------------------------------------------- */

@description('The administrator username of the SQL logical server.')
param sqladminLogin string = 'adminAnj'

@secure()
@description('The administrator password of the SQL logical server.')
param sqladminLoginPassword string = 'Password@321'

@description('The name of the MySQL database.')
param mysqlDBName string = 'mysqlDB'

@description('Name of the management server SQL firewall rules.')
param managementServerSqlFirewallRulesName string = 'mansqlFirewallRules'

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
/*                     STORAGE - POST SCRIPT WITH PRIVATE CONTAINER           */
/* -------------------------------------------------------------------------- */

@description('Prefix for the storage account name.')
param storageAccountPrefix string = 'storage'

@description('Name of the storage account.')
param storageAccountName string = '${storageAccountPrefix}${uniqueString('storage', resourceGroup().id)}'

module storagePostscriptModule 'modules/storage-postscript.bicep' = {
  name: storageAccountName
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}
