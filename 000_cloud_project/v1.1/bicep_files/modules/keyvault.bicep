// Reference: https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/accesspolicies?pivots=deployment-language-bicep

/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file keyvault.bicep

// After the deployment completes, retrieve the Key Vault URI and use the Azure CLI command to create and store the secrets:
// az keyvault secret set --vault-name <key_vault_name> --name WebServerPassword --value <web_server_password>
// az keyvault secret set --vault-name <key_vault_name> --name AdminServerPassword --value <admin_server_password>

/* -------------------------------------------------------------------------- */
/*                     LOCATION                                               */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

// /* -------------------------------------------------------------------------- */
// /*                              Key Vault                                     */
// /* -------------------------------------------------------------------------- */

// var keyVaultName = 'keyvault-${uniqueString(resourceGroup().id, 'keyVault')}1'

// resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
//   name: keyVaultName
//   // Find out if this key vault should be a child of other resources
//   // parent:
//   location: location
//   properties: {
//     // stock-keeping unit refers to the pricing tier or level of service for the Key Vault instance.
//     sku: {
//       family: 'A'
//       // 'standard' SKU is typically more cost-effective compared to higher-tier SKUs. If budget is a consideration and the desired features of the 'standard' SKU meet the project's requirements, it can be a suitable choice.
//       name: 'standard'
//     }
//     tenantId: subscription().tenantId
//     // The accessPolicies section in the Key Vault resource, determines which users, applications, or services have permissions to interact with the Key Vault and perform specific operations
//     accessPolicies: [
//       {
//         // Angeline: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
//         // ToDo: How to dynamically declare objectId
//         objectId: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
//         tenantId: subscription().tenantId
//         // Services that needs keyvault: Storage - Post-deployment and Data Encryption
//         permissions: {
//           // ToDo: Adjust the keys
//           // Key Management - Azure Key Vault can be used as a Key Management solution. Azure Key Vault makes it easy to create and control the encryption keys used to encrypt your data.
//           keys: [ 'all' ]
//           // ToDo: Adjust the secrets
//           // Secrets Management - Azure Key Vault can be used to Securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets
//           secrets: [ 'all' ]
//           // ToDo: Adjust the certificate
//           // Certificate Management - Azure Key Vault lets you easily provision, manage, and deploy public and private Transport Layer Security/Secure Sockets Layer (TLS/SSL) certificates for use with Azure and your internal connected resources.
//           // certificates: [ 'all' ]
//           // Storage Management -
//           // storage: [ 'all' ]
//         }
//       }
//       // {
//       //   // Casper
//       //   objectId:
//       //   tenantId: subscription().tenantId
//       //   permissions: {
//       //     secrets: [ 'all' ]
//       //   }
//       //   // zoek welke applicaties hebben de de key vault nodig
//       //   // .env objectID ----- environment
//       // }
//       // {
//       //   // Shikha
//       //   objectId:
//       //   tenantId: subscription().tenantId
//       //   permissions: {
//       //     secrets: [ 'all' ]
//       //   }
//       // }
//     ]
//     // enabledForDeployment: true
//     // enableSoftDelete: true
//     // softDeleteRetentionInDays: 7
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                              Key Vault Secret                              */
// /* -------------------------------------------------------------------------- */

// // var keyVaultSecretName = 'keyVaultSecretName'

// // // Create a secret in Key Vault
// // resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
// //   parent: keyVault
// //   name: keyVaultSecretName
// //   properties: {
// //     value: 'your_secret_value'
// //   }
// // }

// // @description('Public SSH key for the virtual machine')
// // param sshPublicKey string = 'sshSecretName'

// // @description('Name of the Key Vault secret containing SSH private key')
// // param sshSecretName string

// // resource sshKeySecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
// //   parent: keyVault
// //   name: sshSecretName
// //   properties: {
// //     value: sshPublicKey
// //   }
// // }

// output keyVaultName string = keyVaultName
// output keyVaultID string = keyVault.id
// output keyVaultURI string = keyVault.properties.vaultUri

/* -------------------------------------------------------------------------- */
/*                              Key Vault                                     */
/* -------------------------------------------------------------------------- */

param keyVaultName string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  // Find out if this key vault should be a child of other resources
  // parent:
  location: location
  properties: {
    // stock-keeping unit refers to the pricing tier or level of service for the Key Vault instance.
    sku: {
      family: 'A'
      // 'standard' SKU is typically more cost-effective compared to higher-tier SKUs. If budget is a consideration and the desired features of the 'standard' SKU meet the project's requirements, it can be a suitable choice.
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enabledForDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    // enablePurgeProtection: false
    enabledForTemplateDeployment: true
    createMode: 'default'
    // enableRbacAuthorization: true
    // publicNetworkAccess: 'disabled'
    accessPolicies: [
      {
        objectId: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
        tenantId: subscription().tenantId
        permissions: {
          keys: [
            'all'
          ]
          certificates: [
            'all'
          ]
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                              Key Vault Policy                              */
/* -------------------------------------------------------------------------- */

// The accessPolicies section in the Key Vault resource, determines which users, applications, or services have permissions to interact with the Key Vault and perform specific operations

// resource KeyVaultPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2023-02-01' = {
//   name: 'keyvaultpolicy'
//   properties: {
//     accessPolicies: [
//       {
//         // Angeline: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
//         // ToDo: How to dynamically declare objectId
//         objectId: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
//         tenantId: subscription().tenantId
//         // Services that needs keyvault: Storage - Post-deployment and Data Encryption
//         permissions: {
//           // ToDo: Adjust the keys
//           // Key Management - Azure Key Vault can be used as a Key Management solution. Azure Key Vault makes it easy to create and control the encryption keys used to encrypt your data.
//           keys: [ 'all' ]
//           // ToDo: Adjust the secrets
//           // Secrets Management - Azure Key Vault can be used to Securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets
//           // secrets: [ 'all' ]
//           // ToDo: Adjust the certificate
//           // Certificate Management - Azure Key Vault lets you easily provision, manage, and deploy public and private Transport Layer Security/Secure Sockets Layer (TLS/SSL) certificates for use with Azure and your internal connected resources.
//           // certificates: [ 'all' ]
//           // Storage Management -
//           // storage: [ 'all' ]
//         }
//       }
//       // {
//       //   // Casper
//       //   objectId:
//       //   tenantId: subscription().tenantId
//       //   permissions: {
//       //     secrets: [ 'all' ]
//       //   }
//       //   // zoek welke applicaties hebben de de key vault nodig
//       //   // .env objectID ----- environment
//       // }
//       // {
//       //   // Shikha
//       //   objectId:
//       //   tenantId: subscription().tenantId
//       //   permissions: {
//       //     secrets: [ 'all' ]
//       //   }
//       // }
//     ]
//   }
// }

/* -------------------------------------------------------------------------- */
/*                              OUTPUT KEY VAULT                              */
/* -------------------------------------------------------------------------- */

output keyVaultName string = keyVaultName
output keyVaultID string = keyVault.id
output keyVaultURI string = keyVault.properties.vaultUri

// output keyVaultID string = keyVault.name

/* -------------------------------------------------------------------------- */
/*                              Key Vault Key                                 */
/* -------------------------------------------------------------------------- */

// Reference: https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/keys?pivots=deployment-language-bicep#keyattributes

resource keyKeyVault 'Microsoft.KeyVault/vaults/keys@2022-07-01' = {
  name: 'keyVaultKey'
  // tags: {
  //   tagName1: 'tagValue1'
  //   tagName2: 'tagValue2'
  // }
  parent: keyVault
  properties: {
    attributes: {
      enabled: true
      //   exp: int
      //   exportable: bool
      //   nbf: int
    }
    // curveName: 'string'
    // keyOps: [
    //   'string'
    // ]
    keySize: 2048 // For example: 2048, 3072, or 4096 for RSA.
    kty: 'RSA'
    // release_policy: {
    //   contentType: 'string'
    //   data: 'string'
    // }
    // rotationPolicy: {
    //   attributes: {
    //     expiryTime: 'string'
    //   }
    //   lifetimeActions: [
    //     {
    //       action: {
    //         type: 'string'
    //       }
    //       trigger: {
    //         timeAfterCreate: 'string'
    //         timeBeforeExpiry: 'string'
    //       }
    //     }
    //   ]
    // }
  }
}

// var keyVaultSecretName = 'keyVaultSecretName'

// // Create a secret in Key Vault
// resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
//   parent: keyVault
//   name: keyVaultSecretName
//   properties: {
//     value: 'your_secret_value'
//   }
// }

// @description('Public SSH key for the virtual machine')
// param sshPublicKey string = 'sshSecretName'

// @description('Name of the Key Vault secret containing SSH private key')
// param sshSecretName string

// resource sshKeySecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
//   parent: keyVault
//   name: sshSecretName
//   properties: {
//     value: sshPublicKey
//   }
// }

/* -------------------------------------------------------------------------- */
/*                              OUTPUT KEY                                    */
/* -------------------------------------------------------------------------- */

output keyKeyVaultID string = keyKeyVault.id
output keyKeyVaultName string = keyKeyVault.name

// /* -------------------------------------------------------------------------- */
// /*                     DISK ENCRYPTION                                        */
// /* -------------------------------------------------------------------------- */

// resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2022-07-02' = {
//   name: 'diskEncryptionSet'
//   location: location
//   // tags: {
//   //   tagName1: 'tagValue1'
//   //   tagName2: 'tagValue2'
//   // }
//   identity: {
//     type: 'SystemAssigned'
//     // 'None'
//     // 'SystemAssigned'
//     // 'SystemAssigned, UserAssigned'
//     // 'UserAssigned'
//     // userAssignedIdentities: {}
//   }
//   properties: {
//     rotationToLatestKeyVersionEnabled: true
//     activeKey: {
//       keyUrl: keyKeyVault.properties.keyUriWithVersion
//       // keyVault.properties.vaultUri
//       // 'https://<vaultEndpoint>/keys/<keyName>/<keyVersion>.'
//       sourceVault: {
//         id: keyVault.id
//       }
//     }
//     encryptionType: 'EncryptionAtRestWithCustomerKey'
//     // federatedClientId: 'string'
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                              OUTPUT DISK ENCRYPTION                        */
// /* -------------------------------------------------------------------------- */

// output diskEncryptionSetName string = diskEncryptionSet.name
// output diskEncryptionSetID string = diskEncryptionSet.id

// SUBMITTED V1.0

// /* -------------------------------------------------------------------------- */
// /*                              Key Vault                                     */
// /* -------------------------------------------------------------------------- */
// // Creates a key vault to store encryption keys for VM disks.
// // The keyVault resource creates a Key Vault, which is a secure storage container for 
// // cryptographic keys, secrets, and certificates. 

// var keyVaultName = 'mykeyvault${uniqueString(resourceGroup().id)}'

// resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
//   name: keyVaultName
//   // Find out if this key vault should be a child of other resources
//   // parent:
//   location: location
//   properties: {
//     // stock-keeping unit refers to the pricing tier or level of service for the Key Vault instance.
//     sku: {
//       family: 'A'
//       // 'standard' SKU is typically more cost-effective compared to higher-tier SKUs. If budget is a consideration and the desired features of the 'standard' SKU meet the project's requirements, it can be a suitable choice.
//       name: 'standard'
//     }
//     tenantId: subscription().tenantId
//     enabledForDeployment: true
//     enableSoftDelete: true
//     softDeleteRetentionInDays: 7
//     // enablePurgeProtection: false
//     enabledForTemplateDeployment: true
//     createMode: 'default'
//     // enableRbacAuthorization: true
//     // publicNetworkAccess: 'disabled'
//     accessPolicies: [
//       {
//         objectId: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
//         tenantId: subscription().tenantId
//         permissions: {
//           keys: [
//             'all'
//           ]
//         }
//       }
//     ]
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                              OUTPUT KEY VAULT                              */
// /* -------------------------------------------------------------------------- */

// output keyVaultName string = keyVaultName
// output keyVaultID string = keyVault.id
// output keyVaultURI string = keyVault.properties.vaultUri

// /* -------------------------------------------------------------------------- */
// /*                              Key Vault Key                                 */
// /* -------------------------------------------------------------------------- */
// // The keyKeyVault resource creates a Key Vault Key within the Key Vault. This represents a 
// // cryptographic key stored and managed within Azure Key Vault. It specifies the attributes 
// // and properties of the key, such as enabling it, setting the key size to 2048 bits, and 
// // specifying the key type as RSA.

// // Reference: https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/keys?pivots=deployment-language-bicep#keyattributes

// resource keyKeyVault 'Microsoft.KeyVault/vaults/keys@2022-07-01' = {
//   name: 'keyVaultKey'
//   parent: keyVault
//   properties: {
//     attributes: {
//       enabled: true
//     }
//     keySize: 2048 // For example: 2048, 3072, or 4096 for RSA.
//     kty: 'RSA'
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                              OUTPUT KEY                                    */
// /* -------------------------------------------------------------------------- */

// output keyKeyVaultID string = keyKeyVault.id
// output keyKeyVaultName string = keyKeyVault.names
