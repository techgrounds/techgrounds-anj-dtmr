//  Use this command to deploy
// az group create --name RGTestStorageAcct --location westeurope
// az deployment group create --resource-group RGTestStorageAcct --template-file storage.bicep

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

// ToDo:
//  - Adjust this according to requirements
