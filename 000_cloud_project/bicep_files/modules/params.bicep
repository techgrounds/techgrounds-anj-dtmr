/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file main.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// vnet webapp
@description('Name of the virtual network where the VM will be attached')
var virtualNetworkName_webapp = 'webapp-vnet'
// vnet management
var virtualNetworkName = 'management-vnet'

// subnet webapp
@description('Name of the subnet where the VM will be attached')
var subnetName_webapp = 'webapp-subnet'
// subnet management
var subnetName = 'management-subnet'

// nsg webapp
var nsgName_webapp = 'webapp-nsg'
// nsg management
var nsgName = 'management-nsg'

// public ip webapp
var publicIpName_webapp = 'webapp-public-ip'
// public ip management
var publicIpName = 'management-public-ip'

// nic webapp
var nicName_webapp = 'webapp-nic'
// nic management
var nicName = 'management-nic'

// addressPrefixes webapp
var vnet_addressPrefixes_webapp = '10.10.10.0/24'
// addressPrefixes management
var vnet_addressPrefixes = '10.20.20.0/24'

// security rules webapp
var securityRulesName_webapp = 'webapp-AllowManagementAccess-security-rules'
// security rules management
var securityRulesName = 'management-AllowManagementAccess-security-rules'

// DNS webapp
var DNSdomainNameLabel_webapp = 'webapp-server'
// DNS management
var DNSdomainNameLabel = 'management-server'

// IP config webapp
var IPConfigName_webapp = 'webapp-ipconfig'
// IP config management
var IPConfigName = 'management-ipconfig'
