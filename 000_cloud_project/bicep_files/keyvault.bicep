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

/* -------------------------------------------------------------------------- */
/*                              Key Vault                                     */
/* -------------------------------------------------------------------------- */

// ToDo: Adjust the keys
// ToDo: Adjust the secrets
// ToDo: Adjust the certificate

var keyVaultName = 'keyvault2-${uniqueString(resourceGroup().id, 'keyVault')}'

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
    // The accessPolicies section in the Key Vault resource, determines which users, applications, or services have permissions to interact with the Key Vault and perform specific operations
    accessPolicies: [
      {
        // Angeline: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
        // ToDo: How to dynamically declare objectId
        objectId: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
        tenantId: subscription().tenantId
        // Services that needs keyvault: Storage - Post-deployment and Data Encryption
        permissions: {
          // Key Management - Azure Key Vault can be used as a Key Management solution. Azure Key Vault makes it easy to create and control the encryption keys used to encrypt your data.
          keys: [ 'all' ]
          // Secrets Management - Azure Key Vault can be used to Securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets
          secrets: [ 'all' ]
          // Certificate Management - Azure Key Vault lets you easily provision, manage, and deploy public and private Transport Layer Security/Secure Sockets Layer (TLS/SSL) certificates for use with Azure and your internal connected resources.
          // certificates: [ 'all' ]
          // Storage Management -
          // storage: [ 'all' ]
        }
      }
      // {
      //   // Casper
      //   objectId:
      //   tenantId: subscription().tenantId
      //   permissions: {
      //     secrets: [ 'all' ]
      //   }
      //   // zoek welke applicaties hebben de de key vault nodig
      //   // .env objectID ----- environment
      // }
      // {
      //   // Shikha
      //   objectId:
      //   tenantId: subscription().tenantId
      //   permissions: {
      //     secrets: [ 'all' ]
      //   }
      // }
    ]
    // enabledForDeployment: true
    // enableSoftDelete: true
    // softDeleteRetentionInDays: 7
  }
}
<<<<<<< Updated upstream:000_cloud_project/bicep_files/keyvault.bicep
=======

/* -------------------------------------------------------------------------- */
/*                              Key Vault Secret                              */
/* -------------------------------------------------------------------------- */

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
>>>>>>> Stashed changes:000_cloud_project/bicep_files/modules/keyvault.bicep
