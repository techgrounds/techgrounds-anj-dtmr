/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file working-web.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /* -------------------------------------------------------------------------- */
// /*                              Management                                    */
// /* -------------------------------------------------------------------------- */
// // The management server will be used to manage and control various resources within the Azure environment. 
// // It will have a private IP address within the management subnet and a public IP address to allow external access.

// /* -------------------------------------------------------------------------- */
// /*                     PARAMS & VARS                                          */
// /* -------------------------------------------------------------------------- */

// // Management Server: 10.20.20.0/24
// // Web/App Server: 10.10.10.0/24

// // virtualNetworkName: The name of the virtual network for the management server.
// // subnetName: The name of the subnet within the virtual network.
// // nsgName: The name of the network security group associated with the subnet.
// // publicIpName: The name of the public IP address resource.
// // nicName: The name of the network interface card.
// // vnet_addressPrefixes: The address prefixes for the virtual network.
// // IPConfigName: The name of the IP configuration for the network interface card.

// // vnet
// var virtualNetworkName = 'management-vnet'
// // subnet
// var subnetName = 'management-subnet'
// // nsg
// var nsgName = 'management-nsg'
// // public ip
// var publicIpName = 'management-public-ip'
// // nic
// var nicName = 'management-nic'
// // addressPrefixes
// var vnet_addressPrefixes = '10.20.20.0/24'
// // // DNS
// // var DNSdomainNameLabel = 'management-server'
// // IP config
// var IPConfigName = 'management-ipconfig'

// /* -------------------------------------------------------------------------- */
// /*                     Virtual Network with subnet                            */
// /* -------------------------------------------------------------------------- */
// // The Bicep template creates a virtual network with a subnet for the management server. 
// // The subnet is associated with a network security group to enforce network-level security policies.

// resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' = {
//   name: virtualNetworkName
//   location: location
//   properties: {
//     addressSpace: {
//       addressPrefixes: [
//         vnet_addressPrefixes
//       ]
//     }
//     subnets: [
//       {
//         name: subnetName
//         properties: {
//           addressPrefix: vnet_addressPrefixes
//           // By associating an NSG with a subnet, we can enforce network-level security policies for the resources within that subnet.
//           networkSecurityGroup: {
//             id: resourceId('Microsoft.Network/networkSecurityGroups', nsgName)
//           }
//         }
//       }
//     ]
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     Network Security Group                                 */
// /* -------------------------------------------------------------------------- */
// // managementNSG: The management NSG is created next. It depends on the managementSubnet 
// // because the security rules in the NSG refer to the address prefixes of the management subnet. 
// // By placing the NSG definition next, we ensure that the subnet is available and its properties
// // are accessible when defining the security rules.

// // The network security group (NSG) controls inbound and outbound traffic to the management server. 
// // The NSG includes security rules that define the network traffic rules. By default, inbound traffic is 
// // blocked, except for specific IP addresses defined in the rules.

// param allowedIPAddresses array = [ '85.149.106.77' ]

// resource nsgManagement 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
//   name: nsgName
//   location: location
//   // Contains the set of properties for the NSG, including the security rules.
//   properties: {
//     // security rules are an array of security rules that define the network traffic rules for the NSG.
//     securityRules: [
//       {
//         name: 'SSH-rule'
//         properties: {
//           protocol: 'TCP'
//           sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
//           destinationAddressPrefix: '*'
//           sourcePortRange: '*'
//           destinationPortRange: '22'
//           access: 'Allow'
//           priority: 1000
//           direction: 'Inbound'
//         }
//       }
//       {
//         name: 'RDP-rule'
//         properties: {
//           protocol: 'TCP'
//           sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
//           destinationAddressPrefix: '*'
//           sourcePortRange: '*'
//           destinationPortRange: '3389'
//           access: 'Allow'
//           priority: 1100
//           direction: 'Inbound'
//         }
//       }
//     ]
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     Public IP                                              */
// /* -------------------------------------------------------------------------- */
// // managementPublicIP: The management public IP resource is created next. It provides a 
// // public IP address for the management server, allowing it to be accessible from the internet. 
// // Public IP resource does not have any dependencies on other resources.

// // The management server requires a public IP address to allow external access. 
// // The Bicep template creates a public IP address resource with a static allocation method.

// // Static Allocation:
// // With static allocation, we can specify a specific public IP address to be associated with the resource.
// // The IP address remains the same even if the resource is deallocated, stopped, or restarted.
// // Static allocation is suitable when the resource requires a fixed IP address that remains consistent throughout its lifecycle.

// resource managementPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
//   name: publicIpName
//   location: location
//   properties: {
//     publicIPAllocationMethod: 'Static'
//     // dnsSettings: {
//     //   domainNameLabel: DNSdomainNameLabel
//     // }
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     Network Interface Card                                 */
// /* -------------------------------------------------------------------------- */
// // managementNetworkInterface: The management network interface is defined next. It depends on the 
// // managementNSG because it needs the NSG's configuration to associate the security rules with the 
// // network interface. By placing the network interface definition here, we ensure that the NSG is created
// //  and its properties are accessible. The network interface is responsible for connecting the resource 
// // to the VNet and a specific subnet within the VNet.

// // Dependencies: Public IP

// // The network interface card (NIC) connects the management server to the virtual network and subnet. 
// // It includes an IP configuration that specifies the subnet and associates the public IP address resource.

// resource managementNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
//   name: nicName
//   location: location
//   // dependsOn: [
//   //   nsgManagement
//   // ]
//   properties: {
//     ipConfigurations: [
//       {
//         name: IPConfigName
//         properties: {
//           subnet: {
//             // The ID is written like this because I wrote down the subnet inside the vnet
//             id: '${vnetManagement.id}/subnets/${subnetName}'
//           }
//           privateIPAddress: '10.20.20.10'
//           privateIPAddressVersion: 'IPv4'
//           privateIPAllocationMethod: 'Static'
//           publicIPAddress: {
//             id: managementPublicIP.id
//           }
//         }
//       }
//     ]
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     PEERING                                                */
// /* -------------------------------------------------------------------------- */
// // peering: To connect the VNet for management server and the VNet for application, we can establish VNet peering.
// // VNet peering enables virtual machines and other resources in one VNet to communicate with resources in the peered VNet, 
// // as if they were part of the same network.

// // ToDo: VnetPeering to connect this management vnet to the app vnet

// resource vnetmngntvnetwebapp 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-11-01' = {
//   parent: vnetManagement
//   name: '${virtualNetworkName}-to-${virtualNetworkName_webapp}'
//   properties: {
//     remoteVirtualNetwork: {
//       id: vnetWebApp.id
//     }
//     allowVirtualNetworkAccess: true
//     allowForwardedTraffic: false
//     allowGatewayTransit: false
//     useRemoteGateways: false
//   }
// }

// // /* -------------------------------------------------------------------------- */
// // /*                     MANAGEMENT SERVER - STORAGE                            */
// // /* -------------------------------------------------------------------------- */
// // The Bicep template includes a section for creating a storage account and a storage container.
// // The storage account is used to store and manage data for the management server.

// // ToDo: How to dynamically create a name without hard coding
// param storageAccountManagementPrefix string = 'stgmngmt'
// param storageAccountManagementName string = '${storageAccountManagementPrefix}${uniqueString(resourceGroup().id)}'

// resource storageAccountManagement 'Microsoft.Storage/storageAccounts@2022-09-01' = {
//   name: storageAccountManagementName
//   location: location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     supportsHttpsTrafficOnly: true
//     encryption: {
//       services: {
//         file: {
//           enabled: true
//         }
//         blob: {
//           enabled: true
//         }
//       }
//       keySource: 'Microsoft.Storage'
//     }
//     networkAcls: {
//       defaultAction: 'Deny'
//       bypass: 'AzureServices'
//     }
//   }
// }

// // /* -------------------------------------------------------------------------- */
// // /*                     MANAGEMENT SERVER - CONTAINER                          */
// // /* -------------------------------------------------------------------------- */
// //  The storage container is configured to restrict public access.

// // ToDo: How to dynamically create a name without hard coding
// // ToDo: For now the container is publicly not accessible, check the requirements for this
// param containerManagementNamePrefix string = 'contmngmt'
// param containerManagementName string = '${containerManagementNamePrefix}${uniqueString(resourceGroup().id)}'

// resource containerManagement 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
//   name: '${storageAccountManagementName}/default/${containerManagementName}'
//   properties: {
//     publicAccess: 'None'
//   }
//   dependsOn: [
//     storageAccountManagement
//   ]
// }

// // /* -------------------------------------------------------------------------- */
// // /*                     OUTPUT - STORAGE & CONTAINER                           */
// // /* -------------------------------------------------------------------------- */

// output storageAccountManagementName string = storageAccountManagement.name
// output storageAccountManagementID string = storageAccountManagement.id
// output storageAccountManagementConnectionStringBlobEndpoint string = storageAccountManagement.properties.primaryEndpoints.blob

// output containerManagementName string = containerManagement.name
// output containerManagementID string = containerManagement.id
// output containerManagementUrl string = containerManagement.properties.publicAccess

// /* -------------------------------------------------------------------------- */
// /*                     MANAGEMENT SERVER - Virtual Machine / Server           */
// /* -------------------------------------------------------------------------- */
// // managementVirtualMachine: Finally, the management virtual machine resource is defined. It depends on 
// // the managementNetworkInterface because it requires a network interface to be associated with the virtual 
// // machine. By placing the virtual machine definition last, we ensure that all the necessary dependencies, 
// // such as the network interface, NSG, and subnet, are created and available.

// // ToDo: Management server is a WINDOWS SERVER
// // ToDo: Web server is a a LINUX SERVER
// // ToDo: Make a key vault first for the 'All VM disks must be encrypted.'
// // ToDo: Connect Availability Set resource

// // The Bicep template creates the management virtual machine/server. 
// // It depends on the previously created resources, such as the network interface card and storage 
// // account. The virtual machine/server is associated with the management subnet and has a public 
// // IP address for external access.

// var storageAccountManagementConnectionStringBlobEndpoint = storageAccountManagement.properties.primaryEndpoints.blob

// // adminUsername: The administrator username for the management virtual machine/server.
// // adminPassword: The administrator password for the management virtual machine/server.

// @secure()
// @description('The administrator username.')
// param adminUsername string

// @secure()
// @description('The administrator password.')
// param adminPassword string

// var virtualMachineName_mngt = 'vmmanagement'
// var virtualMachineSize_mngt = 'Standard_B1ms'
// // var virtualMachineSize_mngt = 'Standard_B2s'
// var virtualMachineOSVersion_mngt = '2022-Datacenter'

// resource VMmanagement 'Microsoft.Compute/virtualMachines@2023-03-01' = {
//   name: virtualMachineName_mngt
//   location: location
//   identity: {
//     type: 'SystemAssigned'
//   }
//   properties: {
//     hardwareProfile: {
//       vmSize: virtualMachineSize_mngt
//     }
//     osProfile: {
//       computerName: virtualMachineName_mngt
//       adminUsername: adminUsername
//       adminPassword: adminPassword
//     }
//     storageProfile: {
//       imageReference: {
//         publisher: 'MicrosoftWindowsServer'
//         offer: 'WindowsServer'
//         sku: virtualMachineOSVersion_mngt
//         version: 'latest'
//       }
//       osDisk: {
//         createOption: 'FromImage'
//         managedDisk: {
//           storageAccountType: 'StandardSSD_LRS'
//           // ToDo: Encrypt the disk
//           // diskEncryptionSet: {
//           //   id: diskEncryptionSet.id
//           // }
//         }
//       }
//       dataDisks: [
//         {
//           diskSizeGB: 256
//           lun: 0
//           createOption: 'Empty'
//         }
//       ]
//     }
//     networkProfile: {
//       networkInterfaces: [
//         {
//           id: managementNetworkInterface.id
//         }
//       ]
//     }
//     diagnosticsProfile: {
//       bootDiagnostics: {
//         enabled: true
//         storageUri: storageAccountManagementConnectionStringBlobEndpoint
//       }
//     }
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     Output                                                 */
// /* -------------------------------------------------------------------------- */

// output VMmanagementName string = VMmanagement.name
// output VMmanagementID string = VMmanagement.id

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/*                              WEB APP                                       */
/* -------------------------------------------------------------------------- */
// This deploy the infrastructure required for a web application in Azure.

// ToDo:
//  - Adjust this according to requirements

// Management Server: 10.20.20.0/24
// Web/App Server: 10.10.10.0/24

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// vnet
var virtualNetworkName_webapp = 'webapp-vnet'
// subnet
var subnetName_webapp = 'webapp-subnet'
// nsg
var nsgName_webapp = 'webapp-nsg'
// public ip
var publicIpName_webapp = 'webapp-public-ip'
// nic
var nicName_webapp = 'webapp-nic'
// addressPrefixes
var vnet_addressPrefixes_webapp = '10.10.10.0/24'
// // DNS
var DNSdomainNameLabel_webapp = 'webapp-server'
// IP config
var IPConfigName_webapp = 'webapp-ipconfig'

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */
// In Azure, a Virtual Network (VNet) is a fundamental networking construct that enables 
// you to securely connect and isolate Azure resources, such as virtual machines (VMs), virtual 
// machine scale sets, and other services. A VNet acts as a virtual representation of a 
// traditional network, allowing you to define IP address ranges, subnets, and network security policies.

// Dependencies: Azure Subscription, Azure Resource Group, Azure Region, Address Space, Subnets, Network Security Groups (NSGs)
// Additional: VnetPeering to connect this management vnet to the app vnet for later

// The vnetWebApp resource creates a Virtual Network (VNet) for the web application.
// I've created a separate vnet for the web app side to isolate it from the other cloud infrastracture
// This segregation helps improve security and network performance by controlling traffic flow between resources.
// Within VNet, I created a subnet to further segment the resources inside the vnet like virtual machine for the server

resource vnetWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' = {
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
        name: subnetName_webapp
        properties: {
          addressPrefix: vnet_addressPrefixes_webapp
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          // By associating an NSG with a subnet, we can enforce network-level security policies for the resources within that subnet.
          networkSecurityGroup: {
            id: resourceId('Microsoft.Network/networkSecurityGroups', nsgName_webapp)
          }
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */
// ToDo:
// - add output from other resources

output vnetWebAppName string = vnetWebApp.name
output vnetWebAppID string = vnetWebApp.id
output WebAppSubnetID string = vnetWebApp.properties.subnets[0].id

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */
// Creates a network security group for the web application.
// The nsgWebApp resource creates a Network Security Group (NSG) for the web application. 
// An NSG is used to enforce network-level security policies for the resources within a subnet. 
// It contains security rules that define network traffic rules, 
// such as allowing inbound traffic on ports 443 (HTTPS), 80 (HTTP), and 22 (SSH).

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgName_webapp
  location: location
  // Contains the set of properties for the NSG, including the security rules.
  properties: {
    // security Rule are An array of security rules that define the network traffic rules for the NSG.
    securityRules: [
      // {
      //   name: 'HTTPS-rule'
      //   properties: {
      //     protocol: 'TCP'
      //     sourceAddressPrefix: '*'
      //     destinationAddressPrefix: '*'
      //     sourcePortRange: '*'
      //     destinationPortRange: '443'
      //     access: 'Allow'
      //     priority: 1200
      //     direction: 'Inbound'
      // }
      // }
      // {
      //   name: 'HTTP-rule'
      //   properties: {
      //     protocol: 'TCP'
      //     sourceAddressPrefix: '*'
      //     destinationAddressPrefix: '*'
      //     sourcePortRange: '*'
      //     destinationPortRange: '80'
      //     access: 'Allow'
      //     priority: 1100
      //     direction: 'Inbound'
      //   }
      // }
      {
        name: 'openPorts80In'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'tcp'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '80'
        }
      }
      // // // Management Server: 10.20.20.0/24
      // // // Web/App Server: 10.10.10.0/24
      // {
      //   name: 'SSH-rule'
      //   properties: {
      //     protocol: 'TCP'
      //     // Enable the NSG rules to allow SSH connections only from the admin/management server.
      //     sourceAddressPrefix: '10.20.20.10/32'
      //     sourcePortRange: '*'
      //     destinationAddressPrefix: '*'
      //     destinationPortRange: '22'
      //     access: 'Allow'
      //     priority: 1000
      //     direction: 'Inbound'
      //   }
      // }
    ]
  }
}

output nsgWebAppID string = nsgWebApp.id
output nsgWebAppName string = nsgWebApp.name

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */
// The WebAppPublicIP resource provides a public IP address for the web server, allowing it 
// to be accessible from the internet. It allocates a static IP address and can optionally 
// configure DNS settings.
// Public IP resource does not have any dependencies on other resources.

resource WebAppPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpName_webapp
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: DNSdomainNameLabel_webapp
    }
  }
}

output WebAppPublicIPName string = WebAppPublicIP.name
output WebAppPublicIPID string = WebAppPublicIP.id

output webAppPublicIpAddress string = WebAppPublicIP.properties.ipAddress
// output webAppDnsDomainNameLabel string = WebAppPublicIP.properties.dnsSettings.domainNameLabel

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */
// The WebAppNetworkInterface resource creates a network interface for the web application. 
// It connects the web application resource to the VNet and assigns it a private 
// IP address from the subnet. It depends on the previously created NSG for network security configurations.

var nsgWebAppID = nsgWebApp.id

resource WebAppNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: nicName_webapp
  location: location
  // dependsOn: [
  //   nsgWebApp
  // ]
  properties: {
    ipConfigurations: [
      {
        name: IPConfigName_webapp
        properties: {
          subnet: {
            // The ID is written like this because I wrote down the subnet inside the vnet
            id: '${vnetWebApp.id}/subnets/${subnetName_webapp}'
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: WebAppPublicIP.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgWebAppID
    }
  }
}

output nic_webappID string = WebAppNetworkInterface.id

// /* -------------------------------------------------------------------------- */
// /*                     PEERING                                                */
// /* -------------------------------------------------------------------------- */
// // The vnetwebappvnetmngnt resource establishes VNet peering between the web application 
// // VNet and the management VNet. VNet peering enables communication between resources in 
// // different VNets, allowing them to access each other's resources.
// // ToDo: VnetPeering to connect this webapp vnet to the management vnet

// resource vnetwebappvnetmngnt 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-11-01' = {
//   parent: vnetWebApp
//   name: '${virtualNetworkName_webapp}-${virtualNetworkName}'
//   properties: {
//     remoteVirtualNetwork: {
//       id: vnetManagement.id
//     }
//     allowVirtualNetworkAccess: true
//     allowForwardedTraffic: false
//     allowGatewayTransit: false
//     useRemoteGateways: false
//   }
// }

// output vnetWebAppVnetMngnPEERINGId string = vnetwebappvnetmngnt.id

// /* -------------------------------------------------------------------------- */
// /*                     WEB APP - STORAGE                                      */
// /* -------------------------------------------------------------------------- */
// The Bicep template includes a section for creating a storage account and a storage container.
// The storage account is used to store and manage data for the web server.

// ToDo: How to dynamically create a name without hard coding
param storageAccountWebAppPrefix string = 'stgwebapp'
param storageAccountWebAppName string = '${storageAccountWebAppPrefix}${uniqueString(resourceGroup().id)}'

resource storageAccountWebApp 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountWebAppName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          enabled: true
        }
        blob: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     WEB APP - CONTAINER                                    */
// /* -------------------------------------------------------------------------- */
//  The storage container is configured to restrict public access.

// ToDo: How to dynamically create a name without hard coding
// ToDo: For now the container is publicly not accessible, check the requirements for this
param containerWebAppNamePrefix string = 'contwebapp'
param containerWebAppName string = '${containerWebAppNamePrefix}${uniqueString(resourceGroup().id)}'

resource containerWebApp 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: '${storageAccountWebAppName}/default/${containerWebAppName}'
  properties: {
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccountWebApp
  ]
}

// /* -------------------------------------------------------------------------- */
// /*                     OUTPUT - STORAGE & CONTAINER                           */
// /* -------------------------------------------------------------------------- */

output storageAccountWebAppName string = storageAccountWebApp.name
output storageAccountWebAppID string = storageAccountWebApp.id
output storageAccountWebAppConnectionStringBlobEndpoint string = storageAccountWebApp.properties.primaryEndpoints.blob

output containerWebAppName string = containerWebApp.name
output containerWebAppID string = containerWebApp.id
output containerWebAppUrl string = containerWebApp.properties.publicAccess

// /* -------------------------------------------------------------------------- */
// /*                              Key Vault                                     */
// /* -------------------------------------------------------------------------- */
// // Creates a key vault to store encryption keys for VM disks.
// // The keyVault resource creates a Key Vault, which is a secure storage container for 
// // cryptographic keys, secrets, and certificates. 

// var keyVaultName = 'mykeyvault${uniqueString(resourceGroup().id)}'

// resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
//   name: keyVaultName
//   // Find out if this key vault should be a child of other resources
//   // parent:
//   location: location
//   properties: {
//     // stock-keeping unit refers to the pricing tier or level of service for the Key Vault instance.
//     sku: {
//       family: 'A'
//       // 'standard' SKU is typically more cost-effective compared to higher-tier SKUs. If budget is a consideration and the desired features of the 'standard' SKU meet the project's requirements, it can be a suitable choice.
//       name: 'standard'
//     }
//     tenantId: subscription().tenantId
//     enabledForDeployment: true
//     enableSoftDelete: true
//     softDeleteRetentionInDays: 7
//     // enablePurgeProtection: false
//     enabledForTemplateDeployment: true
//     createMode: 'default'
//     // enableRbacAuthorization: true
//     // publicNetworkAccess: 'disabled'
//     accessPolicies: [
//       {
//         objectId: 'ade71768-d55d-4d4f-a5b1-5d058c571459'
//         tenantId: subscription().tenantId
//         permissions: {
//           keys: [
//             'all'
//           ]
//         }
//       }
//     ]
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                              OUTPUT KEY VAULT                              */
// /* -------------------------------------------------------------------------- */

// output keyVaultName string = keyVaultName
// output keyVaultID string = keyVault.id
// output keyVaultURI string = keyVault.properties.vaultUri

// /* -------------------------------------------------------------------------- */
// /*                              Key Vault Key                                 */
// /* -------------------------------------------------------------------------- */
// // The keyKeyVault resource creates a Key Vault Key within the Key Vault. This represents a 
// // cryptographic key stored and managed within Azure Key Vault. It specifies the attributes 
// // and properties of the key, such as enabling it, setting the key size to 2048 bits, and 
// // specifying the key type as RSA.

// // Reference: https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/keys?pivots=deployment-language-bicep#keyattributes

// resource keyKeyVault 'Microsoft.KeyVault/vaults/keys@2022-07-01' = {
//   name: 'keyVaultKey'
//   parent: keyVault
//   properties: {
//     attributes: {
//       enabled: true
//     }
//     keySize: 2048 // For example: 2048, 3072, or 4096 for RSA.
//     kty: 'RSA'
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                              OUTPUT KEY                                    */
// /* -------------------------------------------------------------------------- */

// output keyKeyVaultID string = keyKeyVault.id
// output keyKeyVaultName string = keyKeyVault.name

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

var storageAccountWebAppConnectionStringBlobEndpoint = storageAccountWebApp.properties.primaryEndpoints.blob
var apache_script = loadFileAsBase64('../../bash/install_apache.sh')

resource VMWebApp 'Microsoft.Compute/virtualMachines@2022-11-01' = {
  name: virtualMachineName_webapp
  location: location
  // dependsOn: [
  //   WebAppNetworkInterface
  // ]
  properties: {
    userData: apache_script
    hardwareProfile: {
      vmSize: virtualMachineSize_webapp
    }
    osProfile: {
      computerName: virtualMachineName_webapp
      adminUsername: adminUsername
      adminPassword: adminPasswordOrKey
      linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        name: '${virtualMachineName_webapp}_OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: storageAccountWebAppConnectionStringBlobEndpoint
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: WebAppNetworkInterface.id
        }
      ]
    }
    // securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)

  }
}

/* -------------------------------------------------------------------------- */
/*                     WEB APP - OUTPUT                                       */
/* -------------------------------------------------------------------------- */

output VMWebAppadminUsername string = adminUsername
output hostname string = publicIpName_webapp
output sshCommand string = 'ssh ${adminUsername}@${WebAppPublicIP.properties.dnsSettings.fqdn}'

/* -------------------------------------------------------------------------- */
/*                     WEB APP - APACHE                                       */
/* -------------------------------------------------------------------------- */

// resource vmName_install_apache 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = {
//   parent: VMWebApp
//   name: 'install_apache'
//   location: location
//   properties: {
//     publisher: 'Microsoft.Azure.Extensions'
//     type: 'CustomScript'
//     typeHandlerVersion: '2.1'
//     autoUpgradeMinorVersion: true
//     settings: {
//       skipDos2Unix: false
//       fileUris: [
//         '000_cloud_project/v1.0/bash/install_apache.sh'
//       ]
//     }
//     protectedSettings: {
//       commandToExecute: 'bash install_apache.sh'
//     }
//   }
// }

/* -------------------------------------------------------------------------- */
/*                              TODO                                          */
/* -------------------------------------------------------------------------- */

// # Deployment Outputs and Artifacts

// Explain the outputs of the infrastructure deployment, such as resource group details, resource URIs, or connection strings.
// Document any artifacts generated during the deployment process (e.g., ARM templates).
// Describe how to access or use the deployed resources.
