//  Use this command to deploy
// az group create --name RGTestVnetManagement --location westeurope
// az deployment group create --resource-group RGTestVnetManagement --template-file vnetmanagement.bicep

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

@description('Location for all resources.')
param location string = resourceGroup().location

var virtualNetMngmntName = 'vNetManagement'
var subnetName = 'SubnetManagement'

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetMngmntName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
  }
}

resource managementSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  name: '${virtualNetMngmntName}-management-subnet'
  parent: vnetManagement
  properties: {
    addressPrefix: '10.10.10.0/24'
    serviceEndpoints: []
    delegations: null
  }
}

// ToDo:
//  - Adjust this according to requirements
