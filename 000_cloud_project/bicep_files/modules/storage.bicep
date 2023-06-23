// /* -------------------------------------------------------------------------- */
// /*                     Use this command to deploy                             */
// /* -------------------------------------------------------------------------- */

// // az group create --name TestRGcloud_project --location westeurope
// // az deployment group create --resource-group TestRGcloud_project --template-file storage.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION                                               */
/* -------------------------------------------------------------------------- */

@description('Location for all resources.')
param location string = resourceGroup().location

// /* -------------------------------------------------------------------------- */
// /*                     STORAGE                                                */
// /* -------------------------------------------------------------------------- */

// ToDo: How to dynamically create a name without hard coding
param storageAccountPrefix string = 'storage'
param storageAccountName string = '${storageAccountPrefix}${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          enabled: true
        }
        blob: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     CONTAINER                                              */
// /* -------------------------------------------------------------------------- */

// ToDo: How to dynamically create a name without hard coding
param containerNamePrefix string = 'container'
param containerName string = '${containerNamePrefix}${uniqueString(resourceGroup().id)}'

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: '${storageAccountName}/default/${containerName}'
  properties: {
    // Deze script moeten niet publiekelijk toegankelijk zijn.
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccount
  ]
}

output storageAccountConnectionString string = storageAccount.properties.primaryEndpoints.blob
output storageContainerUrl string = storageContainer.properties.publicAccess
