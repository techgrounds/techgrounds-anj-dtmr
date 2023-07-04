/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// cd 000_cloud_project/v1.1/bicep_files/modules          
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file db.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// The name of the SQL server.
@description('The name of the SQL server.')
param sqlServerName string = uniqueString('sqlserver', resourceGroup().id)

// The administrator username of the SQL logical server.
@description('The administrator username of the SQL logical server.')
param sqladminLogin string

// The administrator password of the SQL logical server.
@description('The administrator password of the SQL logical server.')
@secure()
param sqladminLoginPassword string

// The name of the SQL virtual network rule.
@description('The name of the SQL virtual network rule.')
param sqlVirtualNetworkRulesName string

// The name of the SQL firewall rule.
@description('The name of the SQL firewall rule.')
param sqlFirewallRulesName string = 'sqlFirewallRules'

// The name of the MySQL database.
@description('The name of the MySQL database.')
param mysqlDBName string

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
  }
}

/* -------------------------------------------------------------------------- */
/*                     Virtual Network Rules                                  */
/* -------------------------------------------------------------------------- */

param virtualNetworkName string

resource vnetManagement 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: virtualNetworkName
}

resource sqlVirtualNetworkRules 'Microsoft.Sql/servers/virtualNetworkRules@2021-11-01' = {
  parent: sqlServer
  name: sqlVirtualNetworkRulesName
  properties: {
    ignoreMissingVnetServiceEndpoint: true
    virtualNetworkSubnetId: vnetManagement.properties.subnets[0].id
  }
}

/* -------------------------------------------------------------------------- */
/*                     Firewall Rules                                         */
/* -------------------------------------------------------------------------- */

// Management Server: 10.20.20.0/24
// Web/App Server: 10.10.10.0/24

var rule = [
  {
    Name: 'rule1'
    StartIpAddress: '10.10.10.0'
    EndIpAddress: '10.10.10.255'
  }
  {
    Name: 'rule2'
    StartIpAddress: '10.20.20.0'
    EndIpAddress: '10.20.20.255'
  }
]

resource sqlFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-11-01' = {
  name: sqlFirewallRulesName
  parent: sqlServer
  properties: {
    endIpAddress: rule[1].EndIpAddress
    startIpAddress: rule[1].StartIpAddress
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
  dependsOn: []
}

/* -------------------------------------------------------------------------- */
/*                     OUTPUT                                                 */
/* -------------------------------------------------------------------------- */

// The name of the MySQL database.
@description('The name of the MySQL database.')
output mysqlDBName string = mysqlDB.name

// The name of the SQL virtual network rule.
@description('The name of the SQL virtual network rule.')
output sqlVirtualNetworkRulesName string = sqlVirtualNetworkRules.name
