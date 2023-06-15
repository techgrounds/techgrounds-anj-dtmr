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

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetMngmntName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
    subnets: [
      {
        name: 'management-subnet'
        properties: {
          addressPrefix: '10.10.10.0/24'
        }
      }
    ]
  }
}

// ToDo:
//  - Adjust this according to requirements
