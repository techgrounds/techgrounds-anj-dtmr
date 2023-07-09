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

// nic
param nicName_webapp string
// IP config
var IPConfigName_webapp = 'webapp-ipconfig'

// vnet
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string

resource vnetWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: virtualNetworkName_webapp
}

// // subnet
// @description('Name of the web application subnet.')
// param subnetName_webapp string

// nsg
param nsgName_webapp string

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' existing = {
  name: nsgName_webapp
}

// public ip
param publicIpName_webapp string

resource WebAppPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' existing = {
  name: publicIpName_webapp
}

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */
// The WebAppNetworkInterface resource creates a network interface for the web application. 
// It connects the web application resource to the VNet and assigns it a private 
// IP address from the subnet. It depends on the previously created NSG for network security configurations.

resource WebAppNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = [for i in range(0, 2): {
  name: '${nicName_webapp}${i + 1}'
  location: location
  // dependsOn: [
  //   nsgWebApp
  // ]
  // properties: {
  //   ipConfigurations: [
  //     {
  //       name: IPConfigName_webapp
  //       properties: {
  //         subnet: {
  //           // The ID is written like this because I wrote down the subnet inside the vnet
  //           id: '${vnetWebApp.id}/subnets/${subnetName_webapp}'
  //         }
  //         privateIPAllocationMethod: 'Dynamic'
  //         publicIPAddress: {
  //           id: WebAppPublicIP.id
  //         }
  //       }
  //     }
  //   ]
  //   networkSecurityGroup: {
  //     id: nsgWebApp.id
  //   }
  // }
  properties: {
    ipConfigurations: [
      {
        name: '${IPConfigName_webapp}${i + 1}'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: resourceId('Microsoft.Network/publicIPAddresses', '${WebAppPublicIP.name}${i + 1}')
          }
          // backend subnet
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_webapp, vnetWebApp.properties.subnets[1].name)
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          // applicationGatewayBackendAddressPools: [
          //   {
          //     id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
          //   }
          // ]
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', '${nsgWebApp.name}${i + 1}')
    }
  }
  dependsOn: [
    WebAppPublicIP
    // applicationGateWay
    nsgWebApp
    vnetWebApp
  ]
}]

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

output WebAppNetworkInterfaceName string = WebAppNetworkInterface[0].name
output WebAppNetworkInterfaceID string = WebAppNetworkInterface[0].id
