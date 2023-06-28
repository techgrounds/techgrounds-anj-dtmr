/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-nsg.bicep

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
var nsgName_webapp = 'webapp-nsg'

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

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
