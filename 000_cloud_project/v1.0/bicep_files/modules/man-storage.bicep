/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file man-storage.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

// /* -------------------------------------------------------------------------- */
// /*                     MANAGEMENT SERVER - STORAGE                            */
// /* -------------------------------------------------------------------------- */
// The Bicep template includes a section for creating a storage account and a storage container.
// The storage account is used to store and manage data for the management server.

// ToDo: How to dynamically create a name without hard coding
param storageAccountManagementPrefix string = 'stgmngmt'
param storageAccountManagementName string = '${storageAccountManagementPrefix}${uniqueString(resourceGroup().id)}'

resource storageAccountManagement 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountManagementName
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
// /*                     MANAGEMENT SERVER - CONTAINER                          */
// /* -------------------------------------------------------------------------- */
//  The storage container is configured to restrict public access.

// ToDo: How to dynamically create a name without hard coding
// ToDo: For now the container is publicly not accessible, check the requirements for this
param containerManagementNamePrefix string = 'contmngmt'
param containerManagementName string = '${containerManagementNamePrefix}${uniqueString(resourceGroup().id)}'

resource containerManagement 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: '${storageAccountManagementName}/default/${containerManagementName}'
  properties: {
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccountManagement
  ]
}

// /* -------------------------------------------------------------------------- */
// /*                     OUTPUT - STORAGE & CONTAINER                           */
// /* -------------------------------------------------------------------------- */

output storageAccountManagementName string = storageAccountManagement.name
output storageAccountManagementID string = storageAccountManagement.id
output storageAccountManagementConnectionStringBlobEndpoint string = storageAccountManagement.properties.primaryEndpoints.blob

output containerManagementName string = containerManagement.name
output containerManagementID string = containerManagement.id
output containerManagementUrl string = containerManagement.properties.publicAccess
