/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-peering.bicep

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// vnetManagementName: Name of the virtual network.
@description('Name of the virtual network.')
param vnetManagementName string

@description('Name of the virtual network.')
param virtualNetworkName_webapp string

/* -------------------------------------------------------------------------- */
/*                     PEERING                                                */
/* -------------------------------------------------------------------------- */
// peering: To connect the VNet for management server and the VNet for application, we can establish VNet peering.
// VNet peering enables virtual machines and other resources in one VNet to communicate with resources in the peered VNet, 
// as if they were part of the same network.

// ToDo: VnetPeering to connect this management vnet to the app vnet

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: vnetManagementName
}

resource vnetWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: virtualNetworkName_webapp
}
resource vnetwebappvnetmngnt 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-11-01' = {
  parent: vnetWebApp
  name: '${virtualNetworkName_webapp}-${vnetManagementName}'
  properties: {
    remoteVirtualNetwork: {
      id: vnetManagement.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

output vnetWebAppVnetMngnPEERINGId string = vnetwebappvnetmngnt.id

@description('Name of the VNet peering between the management VNet and the app VNet.')
output vnetwebappvnetmngntPeeringName string = vnetwebappvnetmngnt.name
