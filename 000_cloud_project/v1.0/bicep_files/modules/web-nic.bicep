/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-nic.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

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
// IP config
var IPConfigName_webapp = 'webapp-ipconfig'
// addressPrefixes
var vnet_addressPrefixes_webapp = '10.10.10.0/24'
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

// // vnet
// var virtualNetworkName_webapp = 'webapp-vnet'
// // subnet
// var subnetName_webapp = 'webapp-subnet'
// // nsg
// var nsgName_webapp = 'webapp-nsg'

// // addressPrefixes
// var vnet_addressPrefixes_webapp = '10.10.10.0/24'

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
// nsg
// var nsgName_webapp = 'webapp-nsg'
param allowedIPAddresses array = [ '85.149.106.77' ]

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
        name: 'Allow-HTTP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }

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
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */
// ToDo:
// - add output from other resources

output nsgWebAppID string = nsgWebApp.id
output nsgWebAppName string = nsgWebApp.name

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */
// PublicIP: The  public IP resource is created next. It provides a 
// public IP address for the web server, allowing it to be accessible from the internet. 
// Public IP resource does not have any dependencies on other resources.

// // public ip
// var publicIpName_webapp = 'webapp-public-ip'

resource WebAppPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpName_webapp
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

output WebAppPublicIPName string = WebAppPublicIP.name
output WebAppPublicIPID string = WebAppPublicIP.id

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
            id: '${vnetWebApp.id}/subnets/${subnetName_webapp}'
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: WebAppPublicIP
        }
      }
    ]
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

output WebAppNetworkInterfaceName string = WebAppNetworkInterface.name
output WebAppNetworkInterfaceID string = WebAppNetworkInterface.id
