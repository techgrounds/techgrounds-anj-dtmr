// cd 000_cloud_project/v1.1/bicep_files/test-learn
// az group create --name Testv11RGcloud_project --location uksouth
// az deployment group create --resource-group Testv11RGcloud_project --template-file aaaapp-vmss.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION                                               */
/* -------------------------------------------------------------------------- */

@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */

var publicIPAddressName = 'public_ip'

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
  }
}

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */

// addressPrefixes
var vnet_addressPrefixes_webapp = '10.10.10.0/24'

// appGatewaySubnetAddressPrefix: The Application Gateway subnet is used to host the 
// Azure Application Gateway service. It needs its own subnet within the VNet. 
// You can allocate a subnet by using a portion of the VNet's IP address range.
// It is recommended to use a /27 subnet (32 addresses) for the Application Gateway subnet.
// var appGatewaySubnetAddressPrefix = '10.10.10.0/25'
var appGatewaySubnetAddressPrefix = '10.10.10.0/26'

// backendSubnetAddressPrefix: The backend subnet is used to host the resources that 
// the Application Gateway directs traffic to, such as virtual machines or web servers. 
// The size of the backend subnet depends on the number of resources you plan to deploy 
// in that subnet. It is recommended to allocate a larger subnet to accommodate future growth.
// var backendSubnetAddressPrefix = '10.10.10.128/25'
var backendSubnetAddressPrefix = '10.10.10.128/26'
// var backendSubnetAddressPrefix = '10.10.10.128/27'

// // vnet
@description('Name of the web application virtual network.')
var virtualNetworkName_webapp = 'webapp-vnet'

resource virtualNetwork_webapp 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName_webapp
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet_addressPrefixes_webapp
      ]
    }
    subnets: [
      {
        name: 'myAGSubnet'
        properties: {
          addressPrefix: appGatewaySubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'myBackendSubnet'
        properties: {
          addressPrefix: backendSubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    enableDdosProtection: false
    enableVmProtection: false
  }
}

/* -------------------------------------------------------------------------- */
/*                     APP GATEWAY                                             */
/* -------------------------------------------------------------------------- */

param applicationGateWayName string = 'applicationGateWay'

resource applicationGateWay 'Microsoft.Network/applicationGateways@2021-05-01' = {
  name: applicationGateWayName
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_webapp, 'myAGSubnet')
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: resourceId('Microsoft.Network/publicIPAddresses', '${publicIPAddressName}')
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
    ]
    httpListeners: [
      {
        name: 'myListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateWayName, 'appGwPublicFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName, 'port_80')
          }
          protocol: 'Http'
          requireServerNameIndication: false
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'myRoutingRule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'myListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateWayName, 'myHTTPSetting')
          }
        }
      }
    ]
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 10
    }
  }
  dependsOn: [
    publicIPAddress
  ]
}

// /* -------------------------------------------------------------------------- */
// /*                     NIC                                                    */
// /* -------------------------------------------------------------------------- */

// var networkInterfaceName = 'webapp-nic'
// var ipconfigName = 'ipconfig'

// resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = [for i in range(0, 2): {
//   name: '${networkInterfaceName}${i + 1}'
//   location: location
//   properties: {
//     ipConfigurations: [
//       {
//         name: '${ipconfigName}${i + 1}'
//         properties: {
//           privateIPAllocationMethod: 'Dynamic'
//           publicIPAddress: {
//             id: resourceId('Microsoft.Network/publicIPAddresses', '${publicIPAddressName}${i + 1}')
//           }
//           subnet: {
//             id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_webapp, 'myBackendSubnet')
//           }
//           primary: true
//           privateIPAddressVersion: 'IPv4'
//           applicationGatewayBackendAddressPools: [
//             {
//               id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
//             }
//           ]
//         }
//       }
//     ]
//     enableAcceleratedNetworking: false
//     enableIPForwarding: false
//     networkSecurityGroup: {
//       id: resourceId('Microsoft.Network/networkSecurityGroups', '${nsgName}${i + 1}')
//     }
//   }
//   dependsOn: [
//     publicIPAddress
//     applicationGateWay
//   ]
// }]

/* -------------------------------------------------------------------------- */
/*                     NSG                                                    */
/* -------------------------------------------------------------------------- */

// param name_nsg_frontend string = 'nsg_frontend'
param nsg_backend_name string = 'nsg_backend'

resource nsg_backend 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsg_backend_name
  location: location
  properties: {
    securityRules: [
      { name: 'https'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: 100
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '443'
          destinationAddressPrefix: '*'
        }
      }
      { name: 'http'
        properties: {
          access: 'Allow' // later op deny na ssl termination
          direction: 'Inbound'
          priority: 200
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '80'
          destinationAddressPrefix: '*'
          // destinationPortRanges: ['8080']          // 8080 port nodig ?
        }
      }
      // {
      //   name: 'RDP'
      //   properties: {
      //     protocol: 'Tcp'
      //     sourcePortRange: '*'
      //     destinationPortRange: '3389'
      //     sourceAddressPrefix: '*'
      //     destinationAddressPrefix: '*'
      //     access: 'Allow'
      //     priority: 300
      //     direction: 'Inbound'
      //   }
      // }
      { name: 'ssh'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: 400
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*' // admin server of ip als je ssh forwarding doet
          destinationPortRange: '22'
          destinationAddressPrefix: '*' // waarschijnlijk nog specifieker maken
        }
      }
      {
        name: 'GatewayManager'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: 'GatewayManager'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '65200-65535'
          access: 'Allow'
          priority: 1100
          direction: 'Inbound'
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     VMSS                                                   */
/* -------------------------------------------------------------------------- */

param name_vmss string = 'webserverVmss'
param vm_size string = 'Standard_B1s'
param vm_sku string = '22_04-lts-gen2'
// // '20_04-lts'
param name_vm string = 'webserverVM'

//login webserver
param webadmin_username string = 'anjvmss'
@secure()
@minLength(6)
param webadmin_password string = 'Password@321'

// installs apache on each scaling instance
var apache_script = loadFileAsBase64('../../bash/install_apache.sh')

@description('VMSS settings to follow')
resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2021-11-01' = {
  name: name_vmss
  location: location
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
          // '0001-com-ubuntu-server-focal'
          offer: '0001-com-ubuntu-server-jammy'
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
          provisionVMAgent: true // or true
        }
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: 'VMSS-interface'
            properties: {
              networkSecurityGroup: {
                id: nsg_backend.id
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
                      id: virtualNetwork_webapp.properties.subnets[1].id // backend subnet
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                        id: applicationGateWay.properties.backendAddressPools[0].id // resourceId('Microsoft.Network/applicationGateways/backendAddressPools', app_gateway_name, 'backend_pool')
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
            name: 'healthcheck'
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
  }
}

/* -------------------------------------------------------------------------- */
/*                     autoscaling                                            */
/* -------------------------------------------------------------------------- */

param name_autoscaling string = 'autoscale_resource'

resource autoscaling 'Microsoft.Insights/autoscalesettings@2022-10-01' = {
  name: name_autoscaling
  location: location
  properties: {
    enabled: true
    targetResourceUri: vmss.id
    profiles: [
      {
        name: 'autoscale_config'
        capacity: {
          default: '1'
          maximum: '3'
          minimum: '1'
        }
        rules: [
          {
            // scale out rules
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricNamespace: ''
              metricResourceUri: vmss.id
              operator: 'GreaterThan'
              statistic: 'Average'
              threshold: 75
              timeAggregation: 'Average'
              timeGrain: 'PT1M'
              timeWindow: 'PT10M'
              dividePerInstance: false
            }
            scaleAction: {
              cooldown: 'PT1M'
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
            }
          }
          {
            // scale in rules
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricNamespace: ''
              metricResourceUri: vmss.id
              operator: 'LessThan'
              statistic: 'Average'
              threshold: 25
              timeAggregation: 'Average'
              timeGrain: 'PT1M'
              timeWindow: 'PT10M'
              dividePerInstance: false
            }
            scaleAction: {
              cooldown: 'PT1M'
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
            }
          }
        ]
      }
    ]
  }
}
