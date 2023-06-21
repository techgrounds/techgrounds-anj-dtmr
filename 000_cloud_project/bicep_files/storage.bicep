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

// var storageAccountName = 'mystorageaccount'
// var storageAccountType = 'Standard_LRS'
// var storageAccountKind = 'StorageV2'

// // ToDo:
// //  - Adjust this according to requirements
// //  - Adjust the keytype - 

// // Define the storage account
// resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
//   name: 'storage${storageAccountName}'
//   location: location
//   sku: {
//     name: storageAccountType
//   }
//   kind: storageAccountKind
//   properties: {
//     accessTier: 'Hot'
//     // Encryption is the process of converting data into a format that can only be accessed or 
//     // deciphered with the appropriate decryption key. It helps protect the confidentiality and 
//     // integrity of the data stored in the storage account.
//     encryption: {
//       // In the context of hosting post-deployment scripts in an Azure storage account, 
//       // enabling encryption ensures that the script files are encrypted and protected from 
//       // unauthorized access. By specifying file and blob services under encryption, both file 
//       // shares and blobs stored within the storage account will be encrypted.

//       // by configuring encryption and enabling it for the file and blob services, you ensure that the 
//       // post-deployment scripts stored in the Azure storage account are encrypted, providing an additional 
//       // layer of security for the script files.
//       services: {
//         file: {
//           // The keyType specifies the type of encryption key used for encrypting the data at rest.
//           keyType: 'Account'
//           enabled: true
//         }
//         blob: {
//           keyType: 'Account'
//           enabled: true
//         }

// Account: This value indicates that the encryption is performed using an account-level encryption key.
// The account-level encryption key is managed by Azure Storage and provides encryption at rest for the
// data stored in the storage account. When using the Account key type, the same encryption key is used
// for all files and blobs within the storage account.

// Service: This value indicates that the encryption is performed using a service-level encryption key.
// The service-level encryption key is specific to each storage service (e.g., blob storage or file 
// storage) within the storage account. This means that different encryption keys are used for files 
// and blobs.

//       }
//       keySource: 'Microsoft.Storage'
//     }

//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     CONTAINER                                              */
// /* -------------------------------------------------------------------------- */

// var storageContainerName = 'containerpostdeploy'

// resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
//   name: '${storageAccountName}/default/${storageContainerName}'
//   properties: {
//     // Deze script moeten niet publiekelijk toegankelijk zijn.
//     publicAccess: 'None'
//   }
//   dependsOn: [
//     storageAccount
//   ]
// }

// output storageAccountName string = storageAccountName
// output storageContainerName string = storageContainerName

// /* -------------------------------------------------------------------------- */
// /*                     STORAGE                                                */
// /* -------------------------------------------------------------------------- */

// ToDo: How to dynamically create a name without hard coding
param storageAccountName string = 'mystorageqwertyuiop'

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
param containerName string = 'mycontainerqwertyuiop'

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
