/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// az group create --name TestRGcloud_project --location westeurope
// az deployment group create --resource-group TestRGcloud_project --template-file man-pubip.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('Location for all resources.')
param location string

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */

// publicIpName: Name of the management public IP resource.
@description('Name of the management public IP resource.')
param publicIpName string

// DNSdomainNameLabel: Domain name label for the management server.
@description('Domain name label for the management server.')
param DNSdomainNameLabel string = 'management-server'

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */
// managementPublicIP: The management public IP resource is created next. It provides a 
// public IP address for the management server, allowing it to be accessible from the internet. 
// Public IP resource does not have any dependencies on other resources.

resource managementPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpName
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: DNSdomainNameLabel
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */
// managementPublicIPName: Name of the created management public IP resource.
@description('Name of the created management public IP resource.')
output managementPublicIPName string = managementPublicIP.name

// managementPublicIPID: ID of the created management public IP resource.
@description('ID of the created management public IP resource.')
output managementPublicIPID string = managementPublicIP.id

// managementPublicIPAddress: IP address of the created management public IP resource.
@description('IP address of the created management public IP resource.')
output managementPublicIPAddress string = managementPublicIP.properties.ipAddress

// managementDnsDomainNameLabel: Domain name label of the created management public IP resource.
@description('Domain name label of the created management public IP resource.')
output managementDnsDomainNameLabel string = managementPublicIP.properties.dnsSettings.domainNameLabel
