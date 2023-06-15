// In Azure, a Virtual Network (VNet) is a fundamental networking construct that enables 
// you to securely connect and isolate Azure resources, such as virtual machines (VMs), virtual 
// machine scale sets, and other services. A VNet acts as a virtual representation of a 
// traditional network, allowing you to define IP address ranges, subnets, and network security policies.

// Dependencies: Azure portal account, Azure Subscription, Azure Resource Group, Azure Region, Address Space, Subnets, Network Security Groups (NSGs)
// Additional: VnetPeering to connect this management vnet to the app vnet for later

//  Use this command to deploy
// az group create --name RGTestVnetManagement --location westeurope
// az deployment group create --resource-group RGTestVnetManagement --template-file vnetmanagement.bicep

// @description('Admin username')
// param adminUsername string

// @description('Admin password')
// @secure()
// param adminPassword string

@description('Location for all resources.')
param location string = resourceGroup().location

var virtualNetMngmntName = 'vNetManagement'

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetMngmntName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.10.0/24'
      ]
    }
    subnets: [
      {
        name: 'management-subnet'
        properties: {
          addressPrefix: '10.10.10.0/24'
        }
      }
    ]
  }
}

resource nsgManagement 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: 'management-nsg'
  location: location
  // Contains the set of properties for the NSG, including the security rules.
  properties: {
    // security Rule are An array of security rules that define the network traffic rules for the NSG.
    securityRules: [
      {
        name: 'AllowManagementAccess-mngmnt-security-rules'
        properties: {
          // priority: Lower values indicate higher priority. In this case, the rule has a priority of 100.
          priority: 100
          access: 'Allow'
          // direction: Indicates the direction of the traffic. 'Inbound' means the rule applies to incoming traffic.
          direction: 'Inbound'
          protocol: 'Tcp'
          sourcePortRange: '*'
          // destinationPortRange: Specifies the destination port range for the traffic. In this example, it is set to '22', which is the default port for SSH
          destinationPortRange: '22' // Customize for SSH or RDP port
          // sourceAddressPrefixes: Defines the source IP addresses or ranges allowed for the traffic. You can add trusted source IP addresses or ranges that are allowed to access the management server.
          sourceAddressPrefixes: [
            // Add trusted source IP addresses/ranges
            '10.10.10.0/24'
          ]
          // destinationAddressPrefixes: Specifies the destination IP addresses or ranges for the traffic. In this case, it is set to '10.20.20.0/24', which represents the IP address range of the management subnet.
          destinationAddressPrefixes: [
            '10.20.20.0/24' // Customize for management subnet address range
          ]
        }
      }
      // Add additional security rules as needed
    ]
  }
}

output managementVnetId string = vnetManagement.id

// ToDo:
//  - Adjust this according to requirements
