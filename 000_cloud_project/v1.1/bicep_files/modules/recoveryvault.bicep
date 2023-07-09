/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file recoveryvault.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// @description('The name of the Web Server.')
// param webServerName string

@description('The name of the Recovery Services Vault')
param recoveryVaultName string = 'recoveryVaultName'

// var VaultPolicyName = '${recoveryVaultName}-policy'
// var VaultVmssContainerName = '${recoveryVaultName}-websv-container'

/* -------------------------------------------------------------------------- */
/*                     RECOVERY VAULT                                         */
/* -------------------------------------------------------------------------- */

resource recoveryServiceVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: recoveryVaultName
  location: location
  // tags: {
  //   tagName1: 'tagValue1'
  //   tagName2: 'tagValue2'
  // }
  // sku: {
  //   capacity: 'string'
  //   family: 'string'
  //   name: 'string'
  //   size: 'string'
  //   tier: 'string'
  // }
  // etag: 'string'
  // identity: {
  //   type: 'string'
  //   userAssignedIdentities: {}
  // }
  properties: {
    // encryption: {
    //   infrastructureEncryption: 'string'
    //   kekIdentity: {
    //     userAssignedIdentity: 'string'
    //     useSystemAssignedIdentity: bool
    //   }
    //   keyVaultProperties: {
    //     keyUri: 'string'
    //   }
    // }
    monitoringSettings: {
      azureMonitorAlertSettings: {
        alertsForAllJobFailures: 'string'
      }
      classicAlertSettings: {
        alertsForCriticalOperations: 'string'
      }
    }
    moveDetails: {}
    publicNetworkAccess: 'Disabled'
    redundancySettings: {}
    securitySettings: {
      immutabilitySettings: {
        state: 'string'
      }
    }
    upgradeDetails: {}
  }
}

/* -------------------------------------------------------------------------- */
/*                     OUTPUT                                                 */
/* -------------------------------------------------------------------------- */
