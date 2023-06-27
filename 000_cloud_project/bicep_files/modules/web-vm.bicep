/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-vm.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                     Virtual Machine / Server                               */
/* -------------------------------------------------------------------------- */

param webAppadmin_username string = 'webAppadmin'
@secure()
param webAppadmin_password string // = 'Password!@321'

var vmNamePrefix = 'webserver-vm'
var vmWebAppName = 'linux-ubuntu'
param vm_size string = 'Standard_B1s'
param vm_sku string = '20_04-lts'

// var apache_script = loadFileAsBase64('000_cloud_project/bash/script.sh')

// resource keyKeyVault 'Microsoft.KeyVault/vaults/keys@2022-07-01' existing = {
//   name: keyVaultKeyName
// }

resource vmWebApp 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: '${vmNamePrefix}-${vmWebAppName}'
  location: location
  properties: {
    // userData: apache_script
    hardwareProfile: {
      vmSize: vm_size
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: vm_sku
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          // diskEncryptionSet: keyVault.properties.
        }
        // encryptionSettings: keyKeyVault
      }
    }
    osProfile: {
      computerName: vmWebAppName
      adminUsername: webAppadmin_username
      adminPassword: webAppadmin_password
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: WebAppNetworkInterface.id
          properties: {
            deleteOption: 'Detach'
            primary: true
          }
        }
      ]
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                    OUTPUT                                                  */
/* -------------------------------------------------------------------------- */

output vmWebAppName string = vmWebApp.name
output vmWebAppID string = vmWebApp.id
