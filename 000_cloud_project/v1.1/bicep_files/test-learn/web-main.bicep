/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// cd 000_cloud_project/v1.1/bicep_files/test-learn
// az group create --name testlearn --location westeurope
// az deployment group create --resource-group testlearn --template-file web-main.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

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

// vnet
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string = 'webapp-vnet'

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

module nsgWebAppModule '../modules/web-nsg.bicep' = {
  name: nsgName_webapp
  params: {
    nsgName_webapp: nsgName_webapp
    location: location
  }
}

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */

module WebAppPublicIPModule '../modules/web-pubip.bicep' = {
  name: publicIpName_webapp
  params: {
    location: location
    publicIpName_webapp: publicIpName_webapp
  }
}

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet and backend                */
/* -------------------------------------------------------------------------- */

module vnetWebAppModule '../modules/web-vnet.bicep' = {
  name: virtualNetworkName_webapp
  params: {
    location: location
    nsgName_webapp: nsgName_webapp
    virtualNetworkName_webapp: virtualNetworkName_webapp
    appGateway_subnetName: appGateway_subnetName
    // Why is the backend subnet name not a required param here
  }
}

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */

module WebAppNetworkInterfaceModule '../modules/web-nic.bicep' = {
  name: nicName_webapp
  params: {
    nicName_webapp: nicName_webapp
    nsgName_webapp: nsgWebAppModule.name
    publicIpName_webapp: WebAppPublicIPModule.name
    virtualNetworkName_webapp: vnetWebAppModule.name
    location: location
  }
}

// // /* -------------------------------------------------------------------------- */
// // /*                     PEERING                                                */
// // /* -------------------------------------------------------------------------- */

// module vnetwebappvnetmngntPeeringModule 'modules/web-peering.bicep' = {
//   name: vnetwebappvnetmngntPeeringName
//   params: {
//     virtualNetworkName_webapp: vnetWebAppModule.name
//     vnetManagementName: vnetManagementModule.name
//   }
// }

/* -------------------------------------------------------------------------- */
/*                     APPLICATION GATEWAY                                    */
/* -------------------------------------------------------------------------- */

param appGatewayName string = 'app-gateway'
param appGateway_subnetName string = 'subnet-app-gateway'

module appGatewayModule '../modules/web-vmss.bicep' = {
  name: appGatewayName
  params: {
    appGatewayName: appGatewayName
    appGateway_subnetName: appGateway_subnetName
    nicName_webapp: WebAppNetworkInterfaceModule.name
    publicIpName_webapp: WebAppPublicIPModule.name
    virtualNetworkName_webapp: vnetWebAppModule.name
    location: location
    vmssName_webapp: vmssName_webapp
  }
}

/* -------------------------------------------------------------------------- */
/*                     WEB APP - VMSS                                         */
/* -------------------------------------------------------------------------- */
param vmssName_webapp string = 'vmss_webapp'

module vmssWebAppModule '../modules/web-vmss.bicep' = {
  name: vmssName_webapp
  params: {
    appGateway_subnetName: appGateway_subnetName
    appGatewayName: appGatewayName
    nicName_webapp: WebAppNetworkInterfaceModule.name
    publicIpName_webapp: WebAppPublicIPModule.name
    virtualNetworkName_webapp: vnetWebAppModule.name
    vmssName_webapp: vmssName_webapp
    location: location
  }
}
