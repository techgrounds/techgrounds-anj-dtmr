/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file man-nsg.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// nsg
var nsgName = 'management-nsg'
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
    // security rules are An array of security rules that define the network traffic rules for the NSG.
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
      // {
      //   name: 'specific-inbound-allow'
      //   properties: {
      //     priority: 200
      //     direction: 'Inbound'
      //     access: 'Allow'
      //     protocol: '*'
      //     sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
      //     destinationAddressPrefix: '*'
      //     sourcePortRange: '*'
      //     destinationPortRange: '*'
      //     description: 'Allow specific IP address'
      //   }
      // }

      // // destinationAddressPrefix: 'VirtualNetwork' // Assuming you want to restrict access to the virtual network

      // {
      //   name: 'specific-outbound-allow'
      //   properties: {
      //     priority: 200
      //     direction: 'Outbound'
      //     access: 'Allow'
      //     protocol: '*'
      //     sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
      //     destinationAddressPrefix: '*'
      //     sourcePortRange: '*'
      //     destinationPortRange: '*'
      //     description: 'Allow specific IP address'
      //   }
      // }
      {
        name: 'SSH-rule'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '22'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
        }
      }
      {
        name: 'RDP-rule'
        properties: {
          protocol: 'TCP'
          sourceAddressPrefix: '${allowedIPAddresses[0]}/32'
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          access: 'Allow'
          priority: 1100
          direction: 'Inbound'
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

output nsgManagementID string = nsgManagement.id
output nsgManagementName string = nsgManagement.name
