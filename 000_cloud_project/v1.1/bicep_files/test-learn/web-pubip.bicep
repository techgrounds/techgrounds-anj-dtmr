/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-pubip.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// public ip
param publicIpName_webapp string
// DNS
// param DNSdomainNameLabel_webapp string = 'webapp-server'

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */
// The WebAppPublicIP resource provides a public IP address for the web server, allowing it 
// to be accessible from the internet. It allocates a static IP address and can optionally 
// configure DNS settings.
// Public IP resource does not have any dependencies on other resources.

// Why is this 3?
resource WebAppPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpName_webapp
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    // dnsSettings: {
    //   domainNameLabel: DNSdomainNameLabel_webapp
    // }
    idleTimeoutInMinutes: 4
    // publicIPAllocationMethod: 'None'
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

output WebAppPublicIPName string = WebAppPublicIP.name
output WebAppPublicIPID string = WebAppPublicIP.id

output webAppPublicIpAddress string = WebAppPublicIP.properties.ipAddress
// output webAppDnsDomainNameLabel string = WebAppPublicIP[0].properties.dnsSettings.domainNameLabel
