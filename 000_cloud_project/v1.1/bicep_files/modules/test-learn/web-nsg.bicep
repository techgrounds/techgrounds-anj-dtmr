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

resource nsgWebApp 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: nsgName_webapp
  location: location
  // Contains the set of properties for the NSG, including the security rules.
  properties: {
    // security Rule are An array of security rules that define the network traffic rules for the NSG.
    securityRules: [
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
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */
// ToDo:
// - add output from other resources

output nsgWebAppID string = nsgWebApp.id
output nsgWebAppName string = nsgWebApp.name

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
