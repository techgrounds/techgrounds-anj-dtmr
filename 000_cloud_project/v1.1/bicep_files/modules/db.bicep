//  Resources: https://azure.microsoft.com/en-us/blog/sql-azure-connectivity-troubleshooting-guide/

/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// cd 000_cloud_project/v1.1/bicep_files/modules          
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file db.bicep
// Test-NetConnection -ComputerName itzgvtsfn62lm.database.windows.net -Port 1433

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

param sqlserverNamePrefix string = 'sqlserver'

var uniqueSuffix = uniqueString(substring(resourceGroup().id, 0, 10), deployment().name)

// The name of the SQL server.
@description('The name of the SQL server.')
var sqlServerName = '${sqlserverNamePrefix}${uniqueSuffix}'

// param sqlServerName string = uniqueString('sqlserver', resourceGroup().id)

// The name of the MySQL database.
@description('The name of the MySQL database.')
param mysqlDBName string

// The administrator username of the SQL logical server.
@description('The administrator username of the SQL logical server.')
param sqladminLogin string

// The administrator password of the SQL logical server.
@description('The administrator password of the SQL logical server.')
@secure()
param sqladminLoginPassword string

// The name of the SQL firewall rule for the management server.
@description('The name of the SQL firewall rule for the management server.')
param MansqlFirewallRulesName string

// The name of the SQL firewall rule for the web/app server.
@description('The name of the SQL firewall rule for the web/app server.')
param WebsqlFirewallRulesName string

// param privateDnsZoneNameManagement string = 'man-privatelink${environment().suffixes.sqlServerHostname}'

// param privateDnsZoneNameWebApp string = 'webApp-privatelink${environment().suffixes.sqlServerHostname}'

/* -------------------------------------------------------------------------- */
/*                                                                            */
/* -------------------------------------------------------------------------- */

// Note: dependencies of an Azure SQL Database
// Azure SQL Server: Typically, an Azure SQL Database is created under an Azure SQL Server. The SQL Server provides the logical container for multiple databases. Therefore, you may need to create the Azure SQL Server resource first and ensure it is provisioned before creating the Azure SQL Database.
// Virtual Network and Firewall Rules: If you want to restrict access to your Azure SQL Database to specific networks or IP addresses, you may need to configure the virtual network and firewall rules. In this case, the virtual network and associated firewall rules should be created before creating the Azure SQL Database.
// Azure Key Vault: If you plan to store sensitive information, such as connection strings or credentials, securely, you can leverage Azure Key Vault. You may need to create an Azure Key Vault and configure it to store and manage the secrets required for the Azure SQL Database. In this case, the Azure Key Vault should be provisioned and configured before creating the Azure SQL Database.

/* -------------------------------------------------------------------------- */
/*                     SQL Server                                             */
/* -------------------------------------------------------------------------- */

resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqladminLogin
    administratorLoginPassword: sqladminLoginPassword
    publicNetworkAccess: 'Enabled'
    // restrictOutboundNetworkAccess: 'Enabled'
  }
}

/* -------------------------------------------------------------------------- */
/*                     MYSQL DATABASE                                         */
/* -------------------------------------------------------------------------- */
// 
resource mysqlDB 'Microsoft.Sql/servers/databases@2021-11-01' = {
  parent: sqlServer
  name: mysqlDBName
  location: location
}

/* -------------------------------------------------------------------------- */
/*                     Virtual Network Rules                                  */
/* -------------------------------------------------------------------------- */

resource sqlVirtualNetworkRules 'Microsoft.Sql/servers/virtualNetworkRules@2021-11-01' = {
  parent: sqlServer
  name: 'sqlVirtualNetworkRulesManagement'
  properties: {
    ignoreMissingVnetServiceEndpoint: true
    virtualNetworkSubnetId: vnetManagement.properties.subnets[0].id
  }
}

resource sqlVirtualNetworkRules_webapp 'Microsoft.Sql/servers/virtualNetworkRules@2021-11-01' = {
  parent: sqlServer
  name: 'sqlVirtualNetworkRulesWebapp'
  properties: {
    ignoreMissingVnetServiceEndpoint: true
    virtualNetworkSubnetId: virtualNetwork.properties.subnets[0].id
  }
}

/* -------------------------------------------------------------------------- */
/*       Vnets where Azure SQL Database can reside                             */
/* -------------------------------------------------------------------------- */

param virtualNetworkName string

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: virtualNetworkName
}

param virtualNetworkName_webapp string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: virtualNetworkName_webapp
}

/* -------------------------------------------------------------------------- */
/*                     Private Endpoint for the SQL database in each VNet     */
/* -------------------------------------------------------------------------- */
// ToDo: create a subnet dedicated to the Azure SQL Database
// ToDo: and another subnet for the management & web server.

resource privateEndpointManagement 'Microsoft.Network/privateEndpoints@2022-11-01' = {
  name: 'privateEndpointManagement'
  location: location
  properties: {
    subnet: {
      id: vnetManagement.properties.subnets[0].id
    }
    privateLinkServiceConnections: [
      {
        name: 'managementprivateLinkServiceConnection'
        properties: {
          privateLinkServiceId: sqlServer.id
          groupIds: [
            'sqlServer'
          ]
          // requestMessage: {
          //   content: 'Please approve the private endpoint connection.'
          // }
        }
      }
    ]

  }
  dependsOn: [
    vnetManagement
  ]
}

resource privateEndpointWebApp 'Microsoft.Network/privateEndpoints@2022-11-01' = {
  name: 'privateEndpointWebApp'
  location: location
  properties: {
    subnet: {
      id: virtualNetwork.properties.subnets[1].id
    }
    privateLinkServiceConnections: [
      {
        name: 'webAppprivateLinkServiceConnection'
        properties: {
          privateLinkServiceId: sqlServer.id
          groupIds: [
            'sqlServer'
          ]
          // requestMessage: {
          //   content: 'Please approve the private endpoint connection.'
          // }
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork
  ]
}

// // // /* -------------------------------------------------------------------------- */
// // // /*                     Private DNS Zone                                       */
// // // /* -------------------------------------------------------------------------- */

// param privateDnsZoneName string = 'privateLink.mysql.database.azure.com'

// resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
//   name: privateDnsZoneName
//   location: 'global'
//   properties: {}
// }

// // /* -------------------------------------------------------------------------- */
// // /*                     Virtual Network Link                                   */
// // /* -------------------------------------------------------------------------- */

// resource virtualNetworkLinkManagement 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
//   name: '${privateDnsZone.name}man-links-web'
//   parent: privateDnsZone
//   location: 'global'
//   properties: {
//     registrationEnabled: false
//     virtualNetwork: {
//       id: vnetManagement.id
//     }
//   }
// }

// resource virtualNetworkLinkWebApp 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
//   name: '${privateDnsZone.name}web-links-man'
//   parent: privateDnsZone
//   location: location
//   properties: {
//     registrationEnabled: true
//     virtualNetwork: {
//       id: virtualNetwork.id
//     }
//   }
// }

// // /* -------------------------------------------------------------------------- */
// // /*                     private Dns Zone Groups                                  */
// // /* -------------------------------------------------------------------------- */

// // var pvtEndpointDnsGroupName = '${privateEndpointManagement.name}/dnsgroupname'

// resource pvtEndpointDnsGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2022-11-01' = {
//   name: 'pvtEndpoint/DnsGroup'
//   properties: {
//     privateDnsZoneConfigs: [
//       {
//         name: 'privateDnsZoneConfigsManagement'
//         properties: {
//           privateDnsZoneId: privateDnsZone.id
//         }
//       }
//     ]
//   }
//   dependsOn: [
//     privateEndpointManagement
//     privateEndpointWebApp
//   ]
// }

/* -------------------------------------------------------------------------- */
/*                     Firewall Rules                                         */
/* -------------------------------------------------------------------------- */

// Management Server: 10.20.20.0/24
// Web/App Server: 10.10.10.0/24

var rule = [
  {
    Name: 'webServerFirewallRule'
    StartIpAddress: '10.10.10.0'
    EndIpAddress: '10.10.10.255'
  }
  {
    Name: 'managementServerSqlFirewallRules'
    StartIpAddress: '10.20.20.0'
    EndIpAddress: '10.20.20.255'
  }
]

resource managementServerSqlFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-11-01' = {
  name: MansqlFirewallRulesName
  parent: sqlServer
  properties: {
    endIpAddress: rule[1].EndIpAddress
    startIpAddress: rule[1].StartIpAddress
  }
  dependsOn: [
    mysqlDB
    privateEndpointManagement
  ]
}

resource webServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-11-01' = {
  name: WebsqlFirewallRulesName
  parent: sqlServer
  properties: {
    endIpAddress: rule[0].EndIpAddress
    startIpAddress: rule[0].StartIpAddress
  }
  dependsOn: [
    mysqlDB
    privateEndpointWebApp
  ]
}

/* -------------------------------------------------------------------------- */
/*                     OUTPUT                                                 */
/* -------------------------------------------------------------------------- */

// The name of the SQL server.
@description('The name of the SQL server.')
output sqlServerName string = sqlServer.name

// The ID of the SQL server.
@description('The ID of the SQL server.')
output sqlServerID string = sqlServer.id

// The name of the MySQL database.
@description('The name of the MySQL database.')
output mysqlDBName string = mysqlDB.name

// The ID of the MySQL database.
@description('The ID of the MySQL database.')
output mysqlDBID string = mysqlDB.id

// Private Endpoint for the SQL database in each VNet
@description('Name of the Private Endpoint for the SQL database in each VNet.')
output privateEndpointManagementName string = privateEndpointManagement.name

// ID of the Private Endpoint for the SQL database in each VNet
@description('ID of the Private Endpoint for the SQL database in each VNet.')
output privateEndpointManagementID string = privateEndpointManagement.id

// Name of the Private Link Service Connection for the management Private Endpoint
@description('Name of the Private Link Service Connection for the management Private Endpoint.')
output manPrivateLinkServiceConnectionsName string = privateEndpointManagement.properties.privateLinkServiceConnections[0].name

// ID of the Private Link Service Connection for the management Private Endpoint
@description('ID of the Private Link Service Connection for the management Private Endpoint.')
output manPrivateLinkServiceConnectionsID string = privateEndpointManagement.properties.privateLinkServiceConnections[0].id

// Name of the management server SQL firewall rules
@description('Name of the management server SQL firewall rules.')
output managementServerSqlFirewallRulesName string = managementServerSqlFirewallRules.name

// ID of the management server SQL firewall rules
@description('ID of the management server SQL firewall rules.')
output managementServerSqlFirewallRulesID string = managementServerSqlFirewallRules.id

// Private Endpoint for the SQL database in each VNet
@description('Name of the Private Endpoint for the SQL database in each VNet.')
output privateEndpointWebAppName string = privateEndpointWebApp.name

// ID of the Private Endpoint for the SQL database in each VNet
@description('ID of the Private Endpoint for the SQL database in each VNet.')
output privateEndpointWebAppID string = privateEndpointWebApp.id

// Name of the Private Link Service Connection for the web/app Private Endpoint
@description('Name of the Private Link Service Connection for the web/app Private Endpoint.')
output webPrivateLinkServiceConnectionsName string = privateEndpointWebApp.properties.privateLinkServiceConnections[0].name

// ID of the Private Link Service Connection for the web/app Private Endpoint
@description('ID of the Private Link Service Connection for the web/app Private Endpoint.')
output webPrivateLinkServiceConnectionsID string = privateEndpointWebApp.properties.privateLinkServiceConnections[0].id

// Name of the web server SQL firewall rules
@description('Name of the web server SQL firewall rules.')
output webServerFirewallRulesName string = webServerFirewallRules.name

// ID of the web server SQL firewall rules
@description('ID of the web server SQL firewall rules.')
output webServerFirewallRulesID string = webServerFirewallRules.id
