//  Use this command to deploy
// az group create --name TestStorageAcct --location westeurope
// az deployment group create --resource-group RGTestStorageAcct --template-file vnetmanagement.bicep

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

@description('Location for all resources.')
param location string = resourceGroup().location

var storageAccountType = 'Standard_LRS'
var storageAccountName = uniqueString(resourceGroup().id)

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
}
