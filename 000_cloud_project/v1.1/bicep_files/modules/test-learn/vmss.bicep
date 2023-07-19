// import the regular params from main
param location string = resourceGroup().location
// param environment string

// // import needed outputs from other modules
// param name_vnet_webserver string
// param agw_pub_ip string

param nsgName_webapp string = 'nsg_app'

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgName_webapp
}

/////////////////////////////// 
// VMSS

// VMSS specifics
// param diskencryption string
param name_vmss string = 'vmss_webserver'
param vm_size string = 'Standard_B1s'
param vm_sku string = '20_04-lts'
param name_vm string = 'web-vm'

// installs apache on each scaling instance
var apache_script = loadFileAsBase64('../../bash/install_apache.sh')

//login webserver
param webadmin_username string = 'adminAaan'
@secure()
@minLength(6)
param webadmin_password string = 'Password@321' // later in keyvault zetten

// vnet
@description('Name of the web application virtual network.')
param virtualNetworkName_webapp string = 'virtualNetworkName_webapp'

resource vnetagvmssWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworkName_webapp
}

var applicationGateWayName = 'applicationGateWay'
resource applicationGateWay 'Microsoft.Network/applicationGateways@2021-05-01' = {
  name: applicationGateWayName
}

@description('VMSS settings to follow')
resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2021-11-01' = {
  name: name_vmss
  location: location
  tags: {
    vnet: virtualNetworkName_webapp
    location: location
    id: 'vm scale set'
    project: 'IaC'
  }
  sku: {
    tier: 'Standard'
    name: vm_size
    capacity: 1
  }
  properties: {
    singlePlacementGroup: true
    platformFaultDomainCount: 1
    overprovision: true
    automaticRepairsPolicy: {
      enabled: true
    }
    upgradePolicy: {
      mode: 'Rolling'
      rollingUpgradePolicy: {
        prioritizeUnhealthyInstances: true
      }
    }
    additionalCapabilities: {
      hibernationEnabled: false
      ultraSSDEnabled: false
    }
    virtualMachineProfile: {
      userData: apache_script
      storageProfile: {
        imageReference: {
          offer: '0001-com-ubuntu-server-focal'
          version: 'latest'
          publisher: 'canonical'
          sku: vm_sku
        }
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
          osType: 'Linux'
          managedDisk: {
            storageAccountType: 'StandardSSD_LRS'
            // diskEncryptionSet: {
            //   id: diskencryption
            // }
          }
        }
      }
      osProfile: {
        computerNamePrefix: name_vmss
        adminUsername: webadmin_username
        adminPassword: webadmin_password
        linuxConfiguration: {
          disablePasswordAuthentication: false
          provisionVMAgent: false // or true
        }
      }
      networkProfile: {
        // networkApiVersion: '2020-11-01'
        networkInterfaceConfigurations: [
          {
            name: 'VMSS-interface'
            properties: {
              networkSecurityGroup: {
                id: nsgWebApp.id
              }
              enableAcceleratedNetworking: false
              enableIPForwarding: false
              primary: true
              ipConfigurations: [
                {
                  name: 'VMSS-IPconfig'
                  properties: {
                    privateIPAddressVersion: 'IPv4'
                    subnet: {
                      id: vnetagvmssWebApp.properties.subnets[1].id // backend subnet
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                        id: applicationGateWay.properties.backendAddressPools[0].id
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
      extensionProfile: {
        extensions: [
          {
            name: 'health'
            properties: {
              enableAutomaticUpgrade: false
              autoUpgradeMinorVersion: false
              publisher: 'Microsoft.ManagedServices'
              type: 'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
              settings: {
                port: 80
                protocol: 'http'
                requestPath: ''
              }
            }
          }
        ]
      }
    }
    // orchestrationMode: 'Flexible'                         // 'Flexible' or 'Uniform'
  }
}
