// az login
// az account set --subscription 'Cloud Student 1'
// cd 000_cloud_project/v1.1/bicep_files
// cd 000_cloud_project/v1.1/bicep_files/modules
// az group create --name Testv11RGcloud_project --location westeurope
// az deployment group create --resource-group Testv11RGcloud_project --template-file app-main.bicep

// /* -------------------------------------------------------------------------- */
// /*                     LOCATION FOR EVERY RESOURCE                            */
// /* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                    WEB APP PARAMS & VARS                                   */
/* -------------------------------------------------------------------------- */

// vnet
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string = 'webapp-vnet'

// App Gateway Subnet
@description('Name of the web application subnet.')
param appGateway_subnetName string = 'appGateway_subnetName'

// nsg
@description('Name of the web application network security group.')
param nsgName_webapp string = 'webapp-nsg'

// // public ip
param publicIpName_webapp string = 'webapp-public-ip'

// // nic
param nicName_webapp string = 'webapp-nic'

param vnetwebappvnetmngntPeeringName string = 'vnetwebappvnetmngntPeeringName'

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

module nsgWebAppModule 'web-nsg.bicep' = {
  name: nsgName_webapp
  params: {
    nsgName_webapp: nsgName_webapp
    location: location
  }
}

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet and backend                */
/* -------------------------------------------------------------------------- */

module vnetWebAppModule 'app-vnet.bicep' = {
  name: virtualNetworkName_webapp
  params: {
    appGateway_subnetName: appGateway_subnetName
    location: location
    nsgName_webapp: nsgName_webapp
    virtualNetworkName_webapp: virtualNetworkName_webapp
  }
}

/* -------------------------------------------------------------------------- */
/*                     APP GATEWAY                                             */
/* -------------------------------------------------------------------------- */

var applicationGateWayName = 'myAppGateway'

module applicationGateWayModule 'web-ag.bicep' = {
  name: applicationGateWayName
  params: {
    applicationGateWayName: applicationGateWayName
    location: location
  }
}

/* -------------------------------------------------------------------------- */
/*                     VMSS                                                   */
/* -------------------------------------------------------------------------- */

param name_vmss string = 'vmss_webserver'

module vmssModule 'appvm-test.bicep' = {
  name: name_vmss
  params: {
    location: location
  }
}
