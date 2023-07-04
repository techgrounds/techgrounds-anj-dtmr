/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// adminUsername: The administrator username.
// @secure()
@description('The administrator username.')
param adminUsernameMngmnt string = 'adminAnj'

// adminPassword: The administrator password.
@secure()
@description('The administrator password.')
param adminPasswordMngmnt string

// virtualMachineName_mngt: Name of the management virtual machine.
param virtualMachineName_mngt string

// virtualMachineSize_mngt: Size of the management virtual machine.
param virtualMachineSize_mngt string = 'Standard_B1ms'

// virtualMachineOSVersion_mngt: OS version of the management virtual machine.
param virtualMachineOSVersion_mngt string = '2022-Datacenter'

// managementNetworkInterfaceID: ID of the created management network interface.
@description('ID of the created management network interface.')
param managementNetworkInterfaceID string

// storageAccountManagementConnectionStringBlobEndpoint: Blob endpoint of the storage account's primary endpoint.
@description('Blob endpoint of the storage account\'s primary endpoint.')
param storageAccountManagementConnectionStringBlobEndpoint string

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

// The Bicep template creates the management virtual machine/server. 
// It depends on the previously created resources, such as the network interface card and storage 
// account. The virtual machine/server is associated with the management subnet and has a public 
// IP address for external access.

resource VMmanagement 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachineName_mngt
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize_mngt
    }
    osProfile: {
      computerName: virtualMachineName_mngt
      adminUsername: adminUsernameMngmnt
      adminPassword: adminPasswordMngmnt
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
          // ToDo: Encrypt the disk
          // diskEncryptionSet: {
          //   id: diskEncryptionSet.id
          // }
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
          id: managementNetworkInterfaceID
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: storageAccountManagementConnectionStringBlobEndpoint
      }
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

// VMmanagementName: Name of the management virtual machine.
@description('Name of the management virtual machine.')
output VMmanagementName string = VMmanagement.name

// VMmanagementID: ID of the management virtual machine.
@description('ID of the management virtual machine.')
output VMmanagementID string = VMmanagement.id
