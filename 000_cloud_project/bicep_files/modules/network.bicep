/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file network.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/*                              Management                                    */
/* -------------------------------------------------------------------------- */

// ToDo:
//  - Adjust this according to requirements

// Management Server: 10.20.20.0/24
// Web/App Server: 10.10.10.0/24

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// vnet
var virtualNetworkName = 'management-vnet'
// subnet
var subnetName = 'management-subnet'
// nsg
var nsgName = 'management-nsg'
// public ip
var publicIpName = 'management-public-ip'
// nic
var nicName = 'management-nic'
// addressPrefixes
var vnet_addressPrefixes = '10.20.20.0/24'
// DNS
var DNSdomainNameLabel = 'management-server'
// IP config
var IPConfigName = 'management-ipconfig'

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */
// In Azure, a Virtual Network (VNet) is a fundamental networking construct that enables 
// you to securely connect and isolate Azure resources, such as virtual machines (VMs), virtual 
// machine scale sets, and other services. A VNet acts as a virtual representation of a 
// traditional network, allowing you to define IP address ranges, subnets, and network security policies.

// Dependencies: Azure Subscription, Azure Resource Group, Azure Region, Address Space (IP Range?), Subnets, Network Security Groups (NSGs)
// Additional: VnetPeering to connect this management vnet to the app vnet for later

// This creates a virtual network for the management side
// I've created a separate vnet for the management side to isolate it from the other cloud infrastracture
// This segregation helps improve security and network performance by controlling traffic flow between resources.
// Within VNet, I created a subnet to further segment the resources inside the vnet like virtual machine for the server

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet_addressPrefixes
      ]
    }
    // I wrote the subnet inside vnet because of best practice

    // managementSubnet: The management subnet is defined first as it serves as the foundational 
    // component for the other resources. It specifies the address prefix for the subnet where the 
    // management server will be deployed.
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: vnet_addressPrefixes
          // By associating an NSG with a subnet, we can enforce network-level security policies for the resources within that subnet.
          networkSecurityGroup: {
            id: resourceId('Microsoft.Network/networkSecurityGroups', nsgName)
          }
          // serviceEndpoints: [
          //   // Add service endpoints if required
          // ]
          // // ToDo: Check the requirements if delegation is needed
          // delegation: {
          //   name: 'delegation'
          //   properties: {
          //     serviceName: 'Microsoft.Authorization/roleAssignments'
          //   }
        }
      }
    ]
  }
}
/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */
// managementNSG: The management NSG is created next. It depends on the managementSubnet 
// because the security rules in the NSG refer to the address prefixes of the management subnet. 
// By placing the NSG definition next, we ensure that the subnet is available and its properties
// are accessible when defining the security rules.

param allowedIPAddresses array = [ '85.149.106.77' ]

resource nsgManagement 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgName
  location: location
  // Contains the set of properties for the NSG, including the security rules.
  properties: {
    // security Rule are An array of security rules that define the network traffic rules for the NSG.
    securityRules: [
      // {
      //   name: 'All-IP-Blocked'
      //   properties: {
      //     description: 'Block all IP addresses except the specific IP'
      //     // priority: Lower values indicate higher priority. In this case, the rule has a priority of 100.
      //     priority: 200
      //     access: 'Deny'
      //     // direction: Indicates the direction of the traffic. 'Inbound' means the rule applies to incoming traffic.
      //     direction: '*'
      //     protocol: '*'
      //     sourcePortRange: '*'
      //     destinationPortRange: '*'
      //     // sourceAddressPrefixes: Defines the source IP addresses or ranges allowed for the traffic. You can add trusted source IP addresses or ranges that are allowed to access the management server.
      //     sourceAddressPrefixes: [ '0.0.0.0/0' ]
      //     // destinationAddressPrefixes: Specifies the destination IP addresses or ranges for the traffic. In this case, it is set to '10.20.20.0/24', which represents the IP address range of the management subnet.
      //     destinationAddressPrefixes: []
      //   }
      // }
      // // Add additional security rules as needed
      // {
      //   name: 'Allow-Admin-Inbound'
      //   properties: {
      //     description: 'Allow inbound connections from trusted locations'
      //     // priority: Lower values indicate higher priority. In this case, the rule has a priority of 100.
      //     priority: 100
      //     access: 'Allow'
      //     // direction: Indicates the direction of the traffic. 'Inbound' means the rule applies to incoming traffic.
      //     direction: 'Inbound'
      //     // 'Tcp'?
      //     protocol: '*'
      //     sourcePortRange: '*'
      //     destinationPortRange: '*'
      //     // sourceAddressPrefixes: Defines the source IP addresses or ranges allowed for the traffic. You can add trusted source IP addresses or ranges that are allowed to access the management server.
      //     sourceAddressPrefixes: [ '${allowedIPAddresses[0]}/32' ]
      //     // destinationAddressPrefixes: Specifies the destination IP addresses or ranges for the traffic. In this case, it is set to '10.20.20.0/24', which represents the IP address range of the management subnet.
      //     destinationAddressPrefix: 'VirtualNetwork' // Assuming we want to restrict access to the virtual network

      //   }
      // }
      {
        name: 'specific-inbound-allow'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }

      // destinationAddressPrefix: 'VirtualNetwork' // Assuming you want to restrict access to the virtual network

      {
        name: 'specific-outbound-allow'
        properties: {
          priority: 200
          direction: 'Outbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */
// managementPublicIP: The management public IP resource is created next. It provides a 
// public IP address for the management server, allowing it to be accessible from the internet. 
// Public IP resource does not have any dependencies on other resources.

resource managementPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: DNSdomainNameLabel
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */
// managementNetworkInterface: The management network interface is defined next. It depends on the 
// managementNSG because it needs the NSG's configuration to associate the security rules with the 
// network interface. By placing the network interface definition here, we ensure that the NSG is created
//  and its properties are accessible.

// The network interface is responsible for connecting the resource to the VNet and a specific subnet within the VNet.

// Dependencies: Public IP

resource managementNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: nicName
  location: location
  dependsOn: [
    nsgManagement
  ]
  properties: {
    ipConfigurations: [
      {
        name: IPConfigName
        properties: {
          subnet: {
            // The ID is written like this because I wrote down the subnet inside the vnet
            id: '${vnetManagement.id}/subnets/${subnetName}'
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: managementPublicIP.id
          }
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     PEERING                                                */
/* -------------------------------------------------------------------------- */
// peering: To connect the VNet for management server and the VNet for application, we can establish VNet peering.
// VNet peering enables virtual machines and other resources in one VNet to communicate with resources in the peered VNet, 
// as if they were part of the same network.

// ToDo: VnetPeering to connect this management vnet to the app vnet

resource vnetmngntvnetwebapp 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-11-01' = {
  parent: vnetManagement
  name: '${virtualNetworkName}-to-${virtualNetworkName_webapp}'
  properties: {
    remoteVirtualNetwork: {
      id: vnetWebApp.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */
// ToDo:
// - add output from other resources

output managementVnetId string = vnetManagement.id
// output managementPublicIp string = managementPublicIP.properties.ipTags[0].ipAddress

/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/*                              WEB APP                                       */
/* -------------------------------------------------------------------------- */

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
// // public ip
// var publicIpName_webapp = 'webapp-public-ip'
// nic
var nicName_webapp = 'webapp-nic'
// addressPrefixes
var vnet_addressPrefixes_webapp = '10.10.10.0/24'
// // DNS
// var DNSdomainNameLabel_webapp = 'webapp-server'
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

// This creates a virtual network for the webapp side
// I've created a separate vnet for the webapp side to isolate it from the other cloud infrastracture
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
    // I wrote the subnet inside vnet because of best practice

    // Subnet: The subnet is defined first as it serves as the foundational 
    // component for the other resources. It specifies the address prefix for the subnet where the 
    // web server will be deployed.
    subnets: [
      {
        name: subnetName_webapp
        properties: {
          addressPrefix: vnet_addressPrefixes_webapp
          // By associating an NSG with a subnet, we can enforce network-level security policies for the resources within that subnet.
          networkSecurityGroup: {
            id: resourceId('Microsoft.Network/networkSecurityGroups', nsgName_webapp)
          }
          // serviceEndpoints: [
          //   // Add service endpoints if required
          // ]
          // // ToDo: Check the requirements if delegation is needed
          // delegation: {
          //   name: 'delegation'
          //   properties: {
          //     serviceName: 'Microsoft.Authorization/roleAssignments'
          //   }
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgName_webapp
  location: location
  // Contains the set of properties for the NSG, including the security rules.
  properties: {
    // security Rule are An array of security rules that define the network traffic rules for the NSG.
    securityRules: [
      // {
      //   name: securityRulesName_webapp
      //   properties: {
      //     // priority: Lower values indicate higher priority. In this case, the rule has a priority of 100.
      //     priority: 100
      //     access: 'Allow'
      //     // direction: Indicates the direction of the traffic. 'Inbound' means the rule applies to incoming traffic.
      //     direction: 'Inbound'
      //     protocol: 'Tcp'
      //     sourcePortRange: '*'
      //     // destinationPortRange: Specifies the destination port range for the traffic. In this example, it is set to '22', which is the default port for SSH
      //     // should it be '3389'
      //     destinationPortRange: '22' // Customize for SSH or RDP port
      //     // sourceAddressPrefixes: Defines the source IP addresses or ranges allowed for the traffic. You can add trusted source IP addresses or ranges that are allowed to access the management server.
      //     sourceAddressPrefixes: [
      //       // Add trusted source IP addresses/ranges
      //       // '10.20.20.0/24'
      //       // '10.10.10.0/24'
      //       '85.149.106.77'
      //     ]
      //     // destinationAddressPrefixes: Specifies the destination IP addresses or ranges for the traffic. In this case, it is set to '10.20.20.0/24', which represents the IP address range of the management subnet.
      //     destinationAddressPrefixes: [
      //       // Customize for webapp subnet address range
      //       vnet_addressPrefixes_webapp
      //     ]
      //   }
      // }
      // Add additional security rules as needed
      {
        name: 'specific-inbound-allow'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }

      // destinationAddressPrefix: 'VirtualNetwork' // Assuming you want to restrict access to the virtual network

      {
        name: 'specific-outbound-allow'
        properties: {
          priority: 200
          direction: 'Outbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          description: 'Allow specific IP address'
        }
      }
    ]
  }
}

// /* -------------------------------------------------------------------------- */
// /*                     Public IP                                              */
// /* -------------------------------------------------------------------------- */
// // PublicIP: The  public IP resource is created next. It provides a 
// // public IP address for the web server, allowing it to be accessible from the internet. 
// // Public IP resource does not have any dependencies on other resources.

// resource WebAppPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
//   name: publicIpName_webapp
//   location: location
//   properties: {
//     publicIPAllocationMethod: 'Dynamic'
//     dnsSettings: {
//       domainNameLabel: DNSdomainNameLabel_webapp
//     }
//   }
// }

/* -------------------------------------------------------------------------- */
/*                     Network Interface Card                                 */
/* -------------------------------------------------------------------------- */
// NetworkInterface: The network interface is defined next. It depends on the 
// NSG because it needs the NSG's configuration to associate the security rules with the 
// network interface. By placing the network interface definition here, we ensure that the NSG is created
//  and its properties are accessible.

// The network interface is responsible for connecting the resource to the VNet and a specific subnet within the VNet.

resource WebAppNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: nicName_webapp
  location: location
  dependsOn: [
    nsgWebApp
  ]
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
          // publicIPAddress: {
          //   id: WebAppPublicIP.id
          // }
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     PEERING                                                */
/* -------------------------------------------------------------------------- */
// peering: To connect the VNet for management server and the VNet for application, we can establish VNet peering.
// VNet peering enables virtual machines and other resources in one VNet to communicate with resources in the peered VNet, 
// as if they were part of the same network.

// ToDo: VnetPeering to connect this webapp vnet to the management vnet

resource vnetwebappvnetmngnt 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-11-01' = {
  parent: vnetWebApp
  name: '${virtualNetworkName_webapp}-${virtualNetworkName}'
  properties: {
    remoteVirtualNetwork: {
      id: vnetManagement.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */
// ToDo:
// - add output from other resources

output webAppVNetId string = vnetWebApp.id
// output webAppPublicIp string = webAppPublicIP.properties.ipTags[0].ipAddress
