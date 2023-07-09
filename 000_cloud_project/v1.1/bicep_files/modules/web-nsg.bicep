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
param nsgName_webapp string

/* -------------------------------------------------------------------------- */
/*                     Network Security Group                                 */
/* -------------------------------------------------------------------------- */

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' = [for i in range(0, 2): {
  name: '${nsgName_webapp}${i + 1}'
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
      //       // Customize for management subnet address range
      //       vnet_addressPrefixes_webapp
      //     ]
      //   }
      // }
      // Add additional security rules as needed
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
      // {
      //   name: 'HTTPS-rule'
      //   properties: {
      //     protocol: 'TCP'
      //     sourceAddressPrefix: '*'
      //     destinationAddressPrefix: '*'
      //     sourcePortRange: '*'
      //     destinationPortRange: '443'
      //     access: 'Allow'
      //     priority: 1000
      //     direction: 'Inbound'
      //   }
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
      //     priority: 1080
      //     direction: 'Inbound'
      //   }
      // }
      // // Web/App Server: 10.10.10.0/24
      // {
      //   name: 'SSH-rule'
      //   properties: {
      //     protocol: 'TCP'
      //     sourceAddressPrefix: '10.10.10.10/32'
      //     sourcePortRange: '*'
      //     destinationAddressPrefix: '*'
      //     destinationPortRange: '22'
      //     access: 'Allow'
      //     priority: 1200
      //     direction: 'Inbound'
      //   }
      // }
      {
        name: 'RDP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
        }
      }
      {
        name: 'Allow-port-80'
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
    ]
  }
}]

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */
// ToDo:
// - add output from other resources

output nsgWebAppID string = nsgWebApp[0].id
output nsgWebAppName string = nsgWebApp[0].name

// /* -------------------------------------------------------------------------- */
// /*                     Network Security Group                                 */
// /* -------------------------------------------------------------------------- */
// // Creates a network security group for the web application.
// // The nsgWebApp resource creates a Network Security Group (NSG) for the web application. 
// // An NSG is used to enforce network-level security policies for the resources within a subnet. 
// // It contains security rules that define network traffic rules, 
// // such as allowing inbound traffic on ports 443 (HTTPS), 80 (HTTP), and 22 (SSH).

// resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
//   name: nsgName_webapp
//   location: location
//   // Contains the set of properties for the NSG, including the security rules.
//   properties: {
//     // security Rule are An array of security rules that define the network traffic rules for the NSG.
//     securityRules: [
//       {
//         name: 'HTTPS-rule'
//         properties: {
//           protocol: 'TCP'
//           sourceAddressPrefix: '*'
//           destinationAddressPrefix: '*'
//           sourcePortRange: '*'
//           destinationPortRange: '443'
//           access: 'Allow'
//           priority: 1000
//           direction: 'Inbound'
//         }
//       }
//       {
//         name: 'HTTP-rule'
//         properties: {
//           protocol: 'TCP'
//           sourceAddressPrefix: '*'
//           destinationAddressPrefix: '*'
//           sourcePortRange: '*'
//           destinationPortRange: '80'
//           access: 'Allow'
//           priority: 1080
//           direction: 'Inbound'
//         }
//       }
//       // // Management Server: 10.20.20.0/24
//       // // Web/App Server: 10.10.10.0/24
//       {
//         name: 'SSH-rule'
//         properties: {
//           protocol: 'TCP'
//           // Enable the NSG rules to allow SSH connections only from the admin/management server.
//           sourceAddressPrefix: '10.20.20.10/32'
//           sourcePortRange: '*'
//           destinationAddressPrefix: '*'
//           destinationPortRange: '22'
//           access: 'Allow'
//           priority: 100
//           direction: 'Inbound'
//         }
//       }
//     ]
//   }
// }

// output nsgWebAppID string = nsgWebApp.id
// output nsgWebAppName string = nsgWebApp.name
