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
/*                     RECOVERY VAULT                                         */
/* -------------------------------------------------------------------------- */
@description('The environment name. "dev" and "prod" are valid inputs.')
@allowed([
  'dev'
  'prod'
])
param envName string

@description('The name of the Management Server.')
param mgmtServerName string

@description('The name of the Recovery Services Vault')
param recoveryVaultName string = '${take(envName, 3)}-${take(location, 6)}-recoveryvault${take(uniqueString(resourceGroup().id), 6)}'

var backupFabric = 'Azure'
var protectionContainer = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${mgmtServerName}'
var protectedItem = 'vm;iaasvmcontainerv2;${resourceGroup().name};${mgmtServerName}'

// VMmanagementName: Name of the management virtual machine.
@description('Name of the management virtual machine.')
param virtualMachineName_mngt string

resource VMmanagement 'Microsoft.Compute/virtualMachines@2023-03-01' existing = {
  name: virtualMachineName_mngt
}

resource recoveryVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: recoveryVaultName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  tags: {
    Location: location
    Environment: envName
  }
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    monitoringSettings: {
      azureMonitorAlertSettings: {
        alertsForAllJobFailures: 'Enabled'
      }
      classicAlertSettings: {
        alertsForCriticalOperations: 'Enabled'
      }
    }
    publicNetworkAccess: 'Disabled'
  }
  dependsOn: [
    VMmanagement
  ]
}

// Enables backup of the management server with a default policy.
resource mgmtBackup 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-02-01' = {
  name: '${recoveryVaultName}/${backupFabric}/${protectionContainer}/${protectedItem}'
  location: location
  properties: {
    protectedItemType: 'Microsoft.Compute/virtualMachines'
    policyId: '${recoveryVault.id}/backupPolicies/DefaultPolicy'
    sourceResourceId: VMmanagement.id
  }
  dependsOn: [
    VMmanagement
  ]
}

/* -------------------------------------------------------------------------- */
/*                     OUTPUT                                                 */
/* -------------------------------------------------------------------------- */
