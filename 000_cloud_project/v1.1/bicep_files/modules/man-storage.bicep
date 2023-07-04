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

// location: Location for all resources.
@description('Location for all resources.')
param location string

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// ToDo: How to dynamically create a name without hard coding
// storageAccountManagementPrefix: Prefix for the storage account name.

// storageAccountManagementName: Name of the storage account.
@description('Name of the storage account.')
param storageAccountManagementName string

// containerManagementName: Name of the storage container.
@description('Name of the storage container.')
param containerManagementName string

// /* -------------------------------------------------------------------------- */
// /*                     MANAGEMENT SERVER - STORAGE                            */
// /* -------------------------------------------------------------------------- */
// The Bicep template includes a section for creating a storage account and a storage container.
// The storage account is used to store and manage data for the management server.

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

// ToDo: For now the container is publicly not accessible, check the requirements for this

resource containerManagement 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: containerManagementName
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

// storageAccountManagementName: Name of the storage account.
@description('Name of the storage account.')
output storageAccountManagementName string = storageAccountManagement.name

// storageAccountManagementID: ID of the storage account.
@description('ID of the storage account.')
output storageAccountManagementID string = storageAccountManagement.id

// storageAccountManagementConnectionStringBlobEndpoint: Blob endpoint of the storage account's primary endpoint.
@description('Blob endpoint of the storage account\'s primary endpoint.')
output storageAccountManagementConnectionStringBlobEndpoint string = storageAccountManagement.properties.primaryEndpoints.blob

// containerManagementName: Name of the storage container.
@description('Name of the storage container.')
output containerManagementName string = containerManagement.name

// containerManagementID: ID of the storage container.
@description('ID of the storage container.')
output containerManagementID string = containerManagement.id

// containerManagementUrl: Public access URL of the storage container.
@description('Public access URL of the storage container.')
output containerManagementUrl string = containerManagement.properties.publicAccess
