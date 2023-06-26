/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     Virtual Machine / Server                               */
/* -------------------------------------------------------------------------- */
// managementVirtualMachine: Finally, the management virtual machine resource is defined. It depends on 
// the managementNetworkInterface because it requires a network interface to be associated with the virtual 
// machine. By placing the virtual machine definition last, we ensure that all the necessary dependencies, 
// such as the network interface, NSG, and subnet, are created and available.

// ToDo: Management server is a WINDOWS SERVER
// ToDo: Web server is a a LINUX SERVER
// ToDo: Make a key vault first for the 'All VM disks must be encrypted.'
// ToDo: Connect Availability Set resource

@secure()
@description('The administrator username.')
param adminUsername string

@secure()
@description('The administrator password.')
param adminPassword string

var virtualMachineName_mngt = 'vmmanagement'
var virtualMachineSize_mngt = 'Standard_B1ms'
// var virtualMachineSize_mngt = 'Standard_B2s'
var virtualMachineOSVersion_mngt = '2022-Datacenter'

// nic
var nicName = 'management-nic'
resource managementNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: nicName
}

resource VMmanagement 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachineName_mngt
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize_mngt
    }
    osProfile: {
      computerName: virtualMachineName_mngt
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: virtualMachineOSVersion_mngt
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      dataDisks: [
        {
          diskSizeGB: 256
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: managementNetworkInterface.id
        }
      ]
    }
    // Uncomment when in main.bicep
    // diagnosticsProfile: {
    //   bootDiagnostics: {
    //     enabled: true
    //     storageUri: storageAccount.id
    //   }
    // }
  }
}
