// /* -------------------------------------------------------------------------- */
// /*                     Use this command to deploy                             */
// /* -------------------------------------------------------------------------- */

// // az group create --name TestRGcloud_project --location uksouth
// // az deployment group create --resource-group TestRGcloud_project --template-file storage.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION                                               */
/* -------------------------------------------------------------------------- */

@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */
// ToDo: How to dynamically create a name without hard coding

param storageAccountName string

// /* -------------------------------------------------------------------------- */
// /*                     STORAGE - POST SCRIPT                                  */
// /* -------------------------------------------------------------------------- */
// The Bicep template includes a section for creating a storage account and a storage container.
// The storage account is used to store and manage data for the management server.

// Todo: PostScript --- // Deze script moeten niet publiekelijk toegankelijk zijn.

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
//  The storage container is configured to restrict public access.

// ToDo: How to dynamically create a name without hard coding
// ToDo: For now the container is publicly not accessible, check the requirements for this
param containerNamePrefix string = 'container'
param containerName string = '${containerNamePrefix}${uniqueString(resourceGroup().id)}'

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: '${storageAccountName}/default/${containerName}'
  properties: {
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccount
  ]
}

// /* -------------------------------------------------------------------------- */
// /*                     OUTPUT - STORAGE & CONTAINER                           */
// /* -------------------------------------------------------------------------- */

output storageAccountName string = storageAccount.name
output storageAccountID string = storageAccount.id
output storageAccountConnectionStringBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob

output storageContainerName string = storageContainer.name
output storageContainerID string = storageContainer.id
output storageContainerUrl string = storageContainer.properties.publicAccess
