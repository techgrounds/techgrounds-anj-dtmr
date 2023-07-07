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

// param webAppadmin_username string = 'webAppadmin'
// @secure()
// param webAppadmin_password string // = 'Password!@321'

// var vmNamePrefix = 'webserver-vm'
// var vmWebAppName = 'linux-ubuntu'
// param vm_size string = 'Standard_B1s'
// param vm_sku string = '20_04-lts'

// var apache_script = loadFileAsBase64('000_cloud_project/bash/script.sh')

// resource keyKeyVault 'Microsoft.KeyVault/vaults/keys@2022-07-01' existing = {
//   name: keyVaultKeyName
// }

param nicName_webapp string

resource WebAppNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' existing = {
  name: nicName_webapp
}

/* -------------------------------------------------------------------------- */
/*                     WEB APP - Virtual Machine / Server                     */
/* -------------------------------------------------------------------------- */
// Defines the virtual machine/server for the web application.

// WebAppVirtualMachine: Finally, the WebApp virtual machine resource is defined. It depends on 
// the WebAppNetworkInterface because it requires a network interface to be associated with the virtual 
// machine. By placing the virtual machine definition last, we ensure that all the necessary dependencies, 
// such as the network interface, NSG, and subnet, are created and available.

// Resource: 
// - https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-bicep?tabs=CLI
// - https://medium.com/codex/how-to-create-a-linux-virtual-machine-with-azure-bicep-template-e22f50f2baea

// // adminUsername: The administrator username for the management virtual machine/server.
// // adminPassword: The administrator password for the management virtual machine/server.

var virtualMachineName_webapp = 'vmwebapp'
var virtualMachineSize_webapp = 'Standard_B1ms'
// var virtualMachineSize_webapp = 'Standard_B2s'

@description('Username for the Virtual Machine.')
// @secure()
param adminUsername string

@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'
@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string

var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}

// @description('Security Type of the Virtual Machine.')
// @allowed([
//   'Standard'
//   'TrustedLaunch'
// ])
// param securityType string = 'TrustedLaunch'
// param securityType string = 'Standard'
// var securityProfileJson = {
//   uefiSettings: {
//     secureBootEnabled: true
//     vTpmEnabled: true
//   }
//   securityType: securityType
// }

// var storageAccountWebAppConnectionStringBlobEndpoint = storageAccountWebApp.properties.primaryEndpoints.blob

resource VMWebApp 'Microsoft.Compute/virtualMachines@2022-11-01' = {
  name: virtualMachineName_webapp
  location: location
  // dependsOn: [
  //   WebAppNetworkInterface
  // ]
  properties: {
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        // storageUri: storageAccountWebAppConnectionStringBlobEndpoint
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: WebAppNetworkInterface.id
        }
      ]
    }
    hardwareProfile: {
      vmSize: virtualMachineSize_webapp
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    osProfile: {
      computerName: virtualMachineName_webapp
      adminUsername: adminUsername
      adminPassword: adminPasswordOrKey
      linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
    }
    // securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)

  }
}

/* -------------------------------------------------------------------------- */
/*                     WEB APP - OUTPUT                                       */
/* -------------------------------------------------------------------------- */

output VMWebAppadminUsername string = adminUsername
// output hostname string = publicIpName_webapp
// output sshCommand string = 'ssh ${adminUsername}@${WebAppPublicIP.properties.dnsSettings.fqdn}'
