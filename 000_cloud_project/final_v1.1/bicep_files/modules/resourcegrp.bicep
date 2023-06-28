targetScope = 'subscription'

param rgName string = 'TestRGcloud_project'
param location string = 'uksouth'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: location
}
