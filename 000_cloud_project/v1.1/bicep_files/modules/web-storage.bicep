/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-pubip.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// ToDo: How to dynamically create a name without hard coding
param storageAccountWebAppPrefix string = 'stgwebapp'
param storageAccountWebAppName string = '${storageAccountWebAppPrefix}${uniqueString(resourceGroup().id)}'

// /* -------------------------------------------------------------------------- */
// /*                     WEB APP - STORAGE                                      */
// /* -------------------------------------------------------------------------- */

// The Bicep template includes a section for creating a storage account and a storage container.
// The storage account is used to store and manage data for the web server.

resource storageAccountWebApp 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountWebAppName
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
// /*                     WEB APP - CONTAINER                                    */
// /* -------------------------------------------------------------------------- */
// The storage container is configured to restrict public access.

// ToDo: How to dynamically create a name without hard coding
// ToDo: For now the container is publicly not accessible, check the requirements for this
param containerWebAppNamePrefix string = 'contwebapp'
param containerWebAppName string = '${containerWebAppNamePrefix}${uniqueString(resourceGroup().id)}'

resource containerWebApp 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: '${storageAccountWebAppName}/default/${containerWebAppName}'
  properties: {
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccountWebApp
  ]
}

// /* -------------------------------------------------------------------------- */
// /*                     OUTPUT - STORAGE & CONTAINER                           */
// /* -------------------------------------------------------------------------- */

output storageAccountWebAppName string = storageAccountWebApp.name
output storageAccountWebAppID string = storageAccountWebApp.id
output storageAccountWebAppConnectionStringBlobEndpoint string = storageAccountWebApp.properties.primaryEndpoints.blob

output containerWebAppName string = containerWebApp.name
output containerWebAppID string = containerWebApp.id
output containerWebAppUrl string = containerWebApp.properties.publicAccess
