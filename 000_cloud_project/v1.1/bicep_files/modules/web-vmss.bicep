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

var apacheDeployment = loadFileAsBase64('../../bash/install_apache.sh')

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

param virtualNetworkName_webapp string
resource vnetWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: virtualNetworkName_webapp
}

param appGatewayName string
param appGateway_subnetName string

param nicName_webapp string
resource WebAppNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' existing = [for i in range(0, 2): {
  name: '${nicName_webapp}${i + 1}'
}]

param publicIpName_webapp string
resource WebAppPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' existing = [for i in range(0, 3): {
  name: '${publicIpName_webapp}${i + 1}'
}]

param vmssName_webapp string
param vmssSize_webapp string = 'Standard_B1ms'
// var virtualMachineSize_webapp = 'Standard_B2s'

// // adminUsername: The administrator username for the management virtual machine/server.
@description('Username for the Virtual Machine.')
// @secure()
param adminUsername string = 'adminAnj'

// @description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
// @allowed([
//   'sshPublicKey'
//   'password'
// ])
// param authenticationType string = 'password'

// // adminPassword: The administrator password for the management virtual machine/server.
@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string = 'Password@321'

// var linuxConfiguration = {
//   disablePasswordAuthentication: true
//   ssh: {
//     publicKeys: [
//       {
//         path: '/home/${adminUsername}/.ssh/authorized_keys'
//         keyData: adminPasswordOrKey
//       }
//     ]
//   }
// }

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

// resource VMWebApp 'Microsoft.Compute/virtualMachines@2022-11-01' = {
//   name: virtualMachineName_webapp
//   location: location
//   // dependsOn: [
//   //   WebAppNetworkInterface
//   // ]
//   properties: {
//     diagnosticsProfile: {
//       bootDiagnostics: {
//         enabled: true
//         // storageUri: storageAccountWebAppConnectionStringBlobEndpoint
//       }
//     }
//     networkProfile: {
//       networkInterfaces: [
//         {
//           id: WebAppNetworkInterface.id
//         }
//       ]
//     }
//     hardwareProfile: {
//       vmSize: virtualMachineSize_webapp
//     }
//     storageProfile: {
//       imageReference: {
//         publisher: 'Canonical'
//         offer: 'UbuntuServer'
//         sku: '18.04-LTS'
//         version: 'latest'
//       }
//       osDisk: {
//         createOption: 'FromImage'
//         managedDisk: {
//           storageAccountType: 'Standard_LRS'
//         }
//       }
//     }
//     osProfile: {
//       computerName: virtualMachineName_webapp
//       adminUsername: adminUsername
//       adminPassword: adminPasswordOrKey
//       linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
//     }
//     // securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)

//   }
// }

// resource virtualMachineWebApp 'Microsoft.Compute/virtualMachines@2023-03-01' = [for i in range(0, 2): {
//   name: '${virtualMachineName_webapp}${i + 1}'
//   location: location
//   properties: {
//     userData: apacheDeployment
//     hardwareProfile: {
//       vmSize: virtualMachineSize_webapp
//     }
//     storageProfile: {
//       imageReference: {
//         publisher: 'Canonical'
//         offer: 'UbuntuServer'
//         sku: '18.04-LTS'
//         version: 'latest'
//       }
//       osDisk: {
//         osType: 'Linux'
//         createOption: 'FromImage'
//         caching: 'ReadWrite'
//         managedDisk: {
//           storageAccountType: 'StandardSSD_LRS'
//         }
//         diskSizeGB: 30
//       }
//     }
//     osProfile: {
//       computerName: '${virtualMachineName_webapp}${i + 1}'
//       adminUsername: adminUsername
//       adminPassword: adminPasswordOrKey
//       allowExtensionOperations: true
//     }
//     networkProfile: {
//       networkInterfaces: [
//         {
//           id: resourceId('Microsoft.Network/networkInterfaces', '${nicName_webapp}${i + 1}')
//         }
//       ]
//     }
//   }
//   dependsOn: [
//     WebAppNetworkInterface
//   ]
// }]

resource appGateway 'Microsoft.Network/applicationGateways@2022-11-01' = {
  name: appGatewayName
  location: location
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_webapp, appGateway_subnetName)
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Internal'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_webapp, appGateway_subnetName)
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
      {
        name: 'port_443'
        properties: {
          port: 443
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'myBackendPool'
        properties: {}
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'myHTTPSetting'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 20
        }
      }
      {
        name: 'myHTTPSSetting'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 20
          probeEnabled: true
          // pickHostNameFromBackendHttpSettings: {
          //   name: 'myHTTPSetting'
          // }
          hostName: 'myHTTPSetting'
          authenticationCertificates: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/authenticationCertificates', appGatewayName, 'myCertificate')
            }
          ]
          trustedRootCertificates: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/trustedRootCertificates', appGatewayName, 'myCertificate')
            }
          ]
        }
      }
    ]
    httpListeners: [
      {
        name: 'myListenerHTTP'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGatewayName, 'appGatewayFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGatewayName, 'port_80')
          }
          protocol: 'Http'
          requireServerNameIndication: false
        }
      }
      {
        name: 'myListenerHTTPS'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGatewayName, 'appGatewayFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGatewayName, 'port_443')
          }
          protocol: 'Https'
          requireServerNameIndication: false
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/authenticationCertificates', appGatewayName, 'myCertificate')
          }
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'myRoutingRuleHTTP'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'myListenerHTTP')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGatewayName, 'myBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', appGatewayName, 'myHTTPSetting')
          }
        }
      }
      {
        name: 'myRoutingRuleHTTPS'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'myListenerHTTPS')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGatewayName, 'myBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', appGatewayName, 'myHTTPSSetting')
          }
        }
      }
    ]
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 3
    }
    // gatewayManagedIdentity: {
    //   id: managedIdentityId
    // }
  }
  dependsOn: [
    vnetWebApp
    WebAppPublicIP
  ]
  // sku: {
  //   capacity: 3
  // }
}

resource vmssWebApp 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: vmssName_webapp
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    overprovision: false
    upgradePolicy: {
      mode: 'Manual'
    }
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: vmssName_webapp
        adminUsername: adminUsername
        adminPassword: adminPasswordOrKey
        linuxConfiguration: {
          disablePasswordAuthentication: false
        }
      }
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
        }
        imageReference: {
          publisher: 'Canonical'
          offer: 'UbuntuServer'
          sku: '18.04-LTS'
          version: 'latest'
        }
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: '${vmssName_webapp}-nic'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'ipconfig1'
                  properties: {
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_webapp, appGateway_subnetName)
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                        id: appGateway.properties.backendAddressPools[0].id
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
}

// resource healthProbeWebApp 'Microsoft.Network/applicationGateways/httpHealthProbeSettings' = {
//   name: 'healthProbeWebApp'
//   parent: appGateway
//   properties: {
//     protocol: 'Http'
//     path: '/'
//     interval: 15
//     timeout: 10
//     unhealthyThreshold: 3
//     pickHostNameFromBackendHttpSettings: {
//       name: 'myHTTPSetting'
//     }
//   }
// }

resource backendPoolHttpSettingsWebApp 'Microsoft.Network/applicationGateways/backendHttpSettingsCollection@2022-11-01' = {
  name: 'backendPoolHttpSettingsWebApp'
  parent: appGateway
  properties: {
    port: 80
    protocol: 'Http'
    cookieBasedAffinity: 'Disabled'
    pickHostNameFromBackendAddress: false
    requestTimeout: 20
  }
}

resource backendPoolWebApp 'Microsoft.Network/applicationGateways/backendAddressPools@2022-11-01' = {
  name: 'backendPoolWebApp'
  parent: appGateway
  properties: {}
}

resource ruleWebApp 'Microsoft.Network/applicationGateways/requestRoutingRules@2022-11-01' = {
  name: 'ruleWebApp'
  parent: appGateway
  properties: {
    ruleType: 'Basic'
    httpListener: {
      id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'myListenerHTTP')
    }
    backendAddressPool: {
      id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGatewayName, 'backendPoolWebApp')
    }
    backendHttpSettings: {
      id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', appGatewayName, 'backendPoolHttpSettingsWebApp')
    }
  }
}

// resource sslCertificateWebApp 'Microsoft.Network/applicationGateways/authenticationCertificates@2022-11-01' = {
//   name: 'sslCertificateWebApp'
//   parent: appGateway
//   properties: {
//     data: '<base64-encoded-certificate-data>'
//     password: '<certificate-password>'
//   }
// }

/* -------------------------------------------------------------------------- */
/*                     WEB APP - OUTPUT                                       */
/* -------------------------------------------------------------------------- */

output appGatewayName string = appGateway.name
output appGatewayFrontendIPConfig string = appGateway.properties.frontendIPConfigurations[0].name
output appGatewayBackendAddressPool string = appGateway.properties.backendAddressPools[0].name
output appGatewayBackendHttpSettings string = appGateway.properties.backendHttpSettingsCollection[0].name
output appGatewayHTTPListener string = appGateway.properties.httpListeners[0].name
output appGatewayHTTPSListener string = appGateway.properties.httpListeners[1].name
output vmssNameWebApp string = vmssWebApp.name

// output WebAppVMadminUsername string = adminUsername

// output hostname string = publicIpName_webapp
// output sshCommand string = 'ssh ${adminUsername}@${WebAppPublicIP.properties.dnsSettings.fqdn}'
