/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */
// The WebAppPublicIP resource provides a public IP address for the web server, allowing it 
// to be accessible from the internet. It allocates a static IP address and can optionally 
// configure DNS settings.
// Public IP resource does not have any dependencies on other resources.

// public ip
param publicIpName_ag string = 'AGpublicIp'

resource agPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpName_ag
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

output agPublicIPIPName string = agPublicIP.name
output agPublicIPID string = agPublicIP.id

output agPublicIPAddress string = agPublicIP.properties.ipAddress
// output webAppDnsDomainNameLabel string = WebAppPublicIP[0].properties.dnsSettings.domainNameLabel
