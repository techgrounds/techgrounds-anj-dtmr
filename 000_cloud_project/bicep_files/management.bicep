/* -------------------------------------------------------------------------- */
/*                              Management Server                             */
/* -------------------------------------------------------------------------- */

//  Use this command to deploy
// az group create --name RGTestVnetManagement --location westeurope
// az deployment group create --resource-group RGTestVnetManagement --template-file vnetmanagement.bicep

// Management Server: 10.20.20.0/24
// Web/App Server: 10.10.10.0/24

// In Azure, a Virtual Network (VNet) is a fundamental networking construct that enables 
// you to securely connect and isolate Azure resources, such as virtual machines (VMs), virtual 
// machine scale sets, and other services. A VNet acts as a virtual representation of a 
// traditional network, allowing you to define IP address ranges, subnets, and network security policies.

// Dependencies: Azure portal account, Azure Subscription, Azure Resource Group, Azure Region, Address Space, Subnets, Network Security Groups (NSGs)
// Additional: VnetPeering to connect this management vnet to the app vnet for later

// @description('Admin username')
// param adminUsername string

// @description('Admin password')
// @secure()
// param adminPassword string

@description('Location for all resources.')
param location string = resourceGroup().location

var virtualNetMngmntName = 'vNetManagement'

/* -------------------------------------------------------------------------- */
/*                     Virtual Network with subnet                            */
/* -------------------------------------------------------------------------- */
// managementSubnet: The management subnet is defined first as it serves as the foundational 
// component for the other resources. It specifies the address prefix for the subnet where the 
// management server will be deployed.

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetMngmntName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    subnets: [
      {
        name: 'management-subnet'
        properties: {
          addressPrefix: '10.20.20.0/24'
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
            '10.20.20.0/24'
          ]
          // destinationAddressPrefixes: Specifies the destination IP addresses or ranges for the traffic. In this case, it is set to '10.20.20.0/24', which represents the IP address range of the management subnet.
          destinationAddressPrefixes: [
            // Customize for management subnet address range
            '10.20.20.0/24'
          ]
        }
      }
      // Add additional security rules as needed
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
  name: 'management-public-ip'
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: 'management-server'
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

resource managementNetworkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: 'management-nic'
  location: location
  dependsOn: [
    nsgManagement
  ]
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: {
            // The ID is written like this because I wrote down the subnet inside the vnet
            id: '${vnetManagement.id}/subnets/management-subnet'
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
/*                     Virtual Machine / Server                               */
/* -------------------------------------------------------------------------- */
// managementVirtualMachine: Finally, the management virtual machine resource is defined. It depends on 
// the managementNetworkInterface because it requires a network interface to be associated with the virtual 
// machine. By placing the virtual machine definition last, we ensure that all the necessary dependencies, 
// such as the network interface, NSG, and subnet, are created and available.

// resource VMManagement 'Microsoft.Compute/virtualMachines@2023-03-01' = {
//   name: 
//   location: 
// }

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

output managementVnetId string = vnetManagement.id

// ToDo:
//  - Adjust this according to requirements
