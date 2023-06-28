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
var publicIpName_webapp = 'webapp-public-ip'

/* -------------------------------------------------------------------------- */
/*                     Public IP                                              */
/* -------------------------------------------------------------------------- */
// PublicIP: The  public IP resource is created next. It provides a 
// public IP address for the web server, allowing it to be accessible from the internet. 
// Public IP resource does not have any dependencies on other resources.

resource WebAppPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpName_webapp
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

/* -------------------------------------------------------------------------- */
/*                     Output                                                 */
/* -------------------------------------------------------------------------- */

output WebAppPublicIPName string = WebAppPublicIP.name
output WebAppPublicIPID string = WebAppPublicIP.id
