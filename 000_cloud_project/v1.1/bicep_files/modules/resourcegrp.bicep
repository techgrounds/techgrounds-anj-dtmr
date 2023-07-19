targetScope = 'subscription'

@description('Name of the resource group.')
param resourceGroupName string

@description('Location for the resources.')
param location string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: location
}
