/* -------------------------------------------------------------------------- */
/*                     Use this command to deploy                             */
/* -------------------------------------------------------------------------- */

// az login
// az account set --subscription 'Cloud Student 1'
// cd 000_cloud_project/v1.1/bicep_files/modules
// az group create --name TestRGcloud_project --location uksouth
// az deployment group create --resource-group TestRGcloud_project --template-file web-vmss.bicep

/* -------------------------------------------------------------------------- */
/*                     LOCATION FOR EVERY RESOURCE                            */
/* -------------------------------------------------------------------------- */

// location
@description('The Azure Region into which the resources are deployed.')
param location string = resourceGroup().location

/* -------------------------------------------------------------------------- */
/*                     PARAMS & VARS                                          */
/* -------------------------------------------------------------------------- */
//Imported parameters
@description('The environment name. "dev" and "prod" are valid inputs.')
@allowed([
  'dev'
  'prod'
])
param envName string = 'dev'

@secure()
@description('The administrator username.')
param adminUsername string

@secure()
@description('The administrator password.')
param adminPassword string

// @secure()
// @description('The password for the SSL certificate.')
// param sslPassword string

// param Vnet1Identity string
// param vnet1Subnet1Identity string
// param diskEncryptionSetName string
// param storageAccountName string
///////

//Parameters for the VMSS
@description('The name of the webserver VM scaleset.')
param webServerName string = '${take(envName, 3)}${take(location, 6)}websv${take(uniqueString(resourceGroup().id), 4)}'

@description('The SKU size for the VMSS.')
param webServerSku string = envName == 'dev' ? 'Standard_B1s' : 'Standard_B2s'

// @description('The base URI where artifacts required by this template are located. For example, if stored on a public GitHub repo, you\'d use the following URI: https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/201-vmss-windows-webapp-dsc-autoscale/.')
// param _artifactsLocation string = deployment().properties.templateLink.uri

@description('When true this limits the scale set to a single placement group, of max size 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified to false. However, if singlePlacementGroup is false, it may not be modified to true.')
param singlePlacementGroup bool = true
//////

// resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
//   name: storageAccountName
// }

//variables for VMSS
var vmScaleSetName = toLower(substring('vmss${uniqueString(resourceGroup().id)}', 0, 9))
var longvmScaleSet = toLower(webServerName)
var instanceCount = 1
var vmssId = webServer.id
var platformFaultDomainCount = 1
var imageReference = {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-jammy'
  sku: '22_04-lts-gen2'
  version: 'latest'
}

//variables for other resources
var publicIPAddressName = '${vmScaleSetName}pip'
var appGatewayName = '${vmScaleSetName}gateway'
var bePoolName = '${vmScaleSetName}bepool'
var bePoolID = resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGatewayName, bePoolName)
var nicName = '${vmScaleSetName}nic'
var ipConfigName = '${vmScaleSetName}ipconfig'
var publicIpSku = 'Standard'
var autoScaleResourceName = '${webServerName}AutoScale'
var autoScaleDefault = '1'
var autoScaleMin = '1'
var autoScaleMax = '3'
var durationTimeWindow = 10
var predictiveAutoscaleMode = 'ForecastOnly'
var scaleOutCPUPercentageThreshold = 75
var scaleInCPUPercentageThreshold = 25
var scaleOutInterval = '1'
var scaleInInterval = '1'

// var base64EncodedCert = 'MIIKaQIBAzCCCiUGCSqGSIb3DQEHAaCCChYEggoSMIIKDjCCBg8GCSqGSIb3DQEHAaCCBgAEggX8MIIF+DCCBfQGCyqGSIb3DQEMCgECoIIE/jCCBPowHAYKKoZIhvcNAQwBAzAOBAjvWPffozVr5QICB9AEggTYYKdWaTy21/luenq4J3CUrXbs4lOWU41zFQMgc42m4BukTFpXC+NmvHOBdR+JHcch0NH5t048SWPxFwunl5pgwYgeD/1wNw2S3ZsSJ0HkzcFRnaAWOXQnhKYQIdXSNQpvadIwALe4YvA/3me60bUI5cnlx3NMteXbFcOpGL3P1dlk5cYUiMG2uSONT+diEKVKUcJtWSnUXA73lmlNpjDfbdu4+68VdykbOFpbQqvvBdYdx/SZQlEkbEkED/zFp3x1LwSuNZUWk6PQ8iBPWc4ZQkKGEvtdJMf/BNSvTJ0usQbIzp81hcfsKsF84yzucG3CgDTamE0buzqY/KBUb+VAWO+hIPpvp80aAPvM/p93QxMYs3j0wHXpKnogHEUI/l/gMPyYzudJdJ1EOEU4m9MuslOwoKI3PY2tys1xlLFMd9RxKUadkZOREgGRkRt3nWob587eb+AQCJtOw7eHERVE5mNaP1QA2sHKIvh9F1+rO5ROXCVonWhCNZ4Q2BP1uX1laJeyFqjliwcTt+v4XkUVs8Uf6C8ET/OYcLiUGiQmVyrIj0uyQlhz2+KwuN/7teofxTNbJzLN095Vosb6DAO1HbZes2ihSnWbyeuzltE8i7pycisN4uO62SC2Fghj5Wd62STuvVxLnJBQ/VXD9mfBAY6CRCTDXTc3dGHiXTr97MMY2eQvdqI8SX+3nBEQjYOZVia4Pk56enwvkcioGnVTSyo+7+Up3BM75a3zuKoW9+Dy1rUtcsSX/t2afAJQVS24jcgKjNH5Lgoml/PJYVpPwqM+gpAqx5j2cgn5LaWoN1e9WaBMaZwUHh6wWjIyzQMmutjj4b0uQtsGJ991ob02A+9seo0T+AxbCKmtNImvKS9hzuB7TvguJWWS8SCzbpEwNSXe5jJteEKQS5FINuVMX7nGPuiqq77arWCoLSy62xEvjCf/T0kXr1qrkB+oBqeyBemCRs5+MI/45dGDl1r+cucsty2aaooKDwyBDwNxBccZoQVd/13hgYOudjCtQkcNClcKwlH5gW7S2kUAy5eRfKx4YKR3ivyx0/zLm82oRBRTgusjERT5oZ5ZmuE8uNzHOl/O4iApO6UR5HHFHc+eiPhHwC9eCQmJ25/YvNXWtoZ/b/1+soRNThT/bQOiXScKq/Ig/KJag1HALzhWBkhYhgVunM1m7O0DrZYOVtILlfxxB62fblu3m+C6z6vG8aSxOxXewjzmg7yRLHH9szt1yLUkfO7GbgrkNWiKbM8HlJg9y02kWFVHaCyKAIHNKeRM6l4lGT4+Ga0lePH0hBGUTMUsurfMGaez/F4u0LKFVNJFN8umasD0Due/5oGtLei/IYJ97Nl/wq4/WQdTar7PVh0J3f7nnnhcFOdg0vwGH4rByWFg4l2sR/7+rPoFG4NezKhZklPkeW3Ndmdyl93A8U39xDXOiD7s5j+CoOa7INxTXGeWLCWlI1AbRNsJdv03Hm6Kd7DCoI6v7DGPwyCcxq4FgnzBm7lnLEmU1KgjGw5iKA3M+h+Xax8GmTkcCZ6Sg7VLQnVAKDkbT3zDj8OvZR5Px7RA9Aj96fIDbeyzypycwWSWeRJbO4ViWo+LokQA+tL0cQTOrQKNAtE+75YHDWn2kvyAleXaIRZs12QxvzplOWPCy13P0TGB4jANBgkrBgEEAYI3EQIxADATBgkqhkiG9w0BCRUxBgQEAQAAADBdBgkqhkiG9w0BCRQxUB5OAHQAZQAtAGUANgBkAGEANwA0AGMAOQAtAGUAZQA3AGQALQA0ADQAMQAxAC0AYQA4ADQAMwAtADkAYwBjAGUAOABhADMAMQBkAGQANgAzMF0GCSsGAQQBgjcRATFQHk4ATQBpAGMAcgBvAHMAbwBmAHQAIABTAG8AZgB0AHcAYQByAGUAIABLAGUAeQAgAFMAdABvAHIAYQBnAGUAIABQAHIAbwB2AGkAZABlAHIwggP3BgkqhkiG9w0BBwagggPoMIID5AIBADCCA90GCSqGSIb3DQEHATAcBgoqhkiG9w0BDAEDMA4ECE9NuaYlCum+AgIH0ICCA7CDpn7WROmsFF7QVVDyYCMnB9UGJE8iHiqlq3380Lrm6THK7PuPx+hDkgzSH0sF/Cc2Qi1TNrI213Vq7znOuyr1v5bzlMw3V/CAjv8fb2QH9ocXJ2gwrpxrQIN2Rg+kzT5vdhah9D6ar8FkyiYrHCQ9nFDbXqUAC6Y6fo/4PofRt+H4KRktZH1zvT+qGxPIcpHMGMovzeI4VZN5elzBnoypmW5xGvgjps3p+p7Ur5DjpH+PePQTCJpDLSFSpEqaemBa089YBmwPMqbDSSaqW/cIJY9cJNcmJIZldA+d6yn3vqsxngSgS6uoWiyh8u1TOixkVIoMTKahXueKhyHJ8Ezh3w+ImIJ9wIAkjEf52k28rsxMOtsMh/tFo1n6Fw/cNQ7RFDQyMsIrJlEUN4SkSVuHw6HvI/v9G9NAXy+rz7Vc3sA1ydiMKIfal4E+gC5DAdPO0oXToK135Wjl1Y1lyiqm8yIYDRHrHH+5cM2LNLRqhqWp+nmfSStyk3+4r2OIIvj+OqaB6rGglaLtKfhyXlMAClAdpYA+0rsQw4dY6SmIk5RV5QIaEm/RVZNWFrQYZfaq2kT/ShRZ72lyiJl7uCf4vfShPAhKAsgnODxCIGdVsUGBXK350R0MklrYOIwAGl6yPhEV8dUdF9FcYdyQVAPi7J1OhRhUNc20kZu9ngmkm+z3AuZB4No/odrYyOTwnSYMAnM0ZgZEN91FH6nA+9vyR0aIVL30E4IpwLjpg9uDcVQym/OLAKt9z0xn1pKFLsQECJrZYItUhFeGiU70xbNYoVlXxzrqFpHhPSzpqcuas4aPkrLgtBWyl8PvT9CDoVJ4DixzflaHFpMIee4dxwwUc/PXmMRrEqsY60/E+9/u5eNSy0WaU2gLTdIRWbv2Z9z84ft2J85Md8K9M4G2VUs0n9uxO/QZe34LsJvWaG87c28oNxNjwhNZDgehNjCdER8cElSLqAWTXUNUifLsrJzkn6sbSMKndvaa3mNw2iV7Dd37w6BzvDS02jqwzKsyTQVvvF9+Jv+hpzeo4LoZdoGznq/cw+et8JKp3vUZBJ7BE/KIsFtEEhRED8C9bwsrKaJIElUV8UR+fz7FRLoO596tTl8dCkBveZextTYEnyyDmBEbF0h34ni+ZRgR+AwTGyKvbqrleFNwXIUykP/TS4TT7UP/AYXyGvjkx5y20ZStgfSZEzyTv1HyP5FiB0pdzcTscJ6Fjt+lTpbLXmTebjbHWb4vO4SFDCET0AJZm7CgljA7MB8wBwYFKw4DAhoEFIzL64ubaB2QyFOt66ogsK1ZIdUdBBQLruM+WYa6x4qy3YQhW8TB5qzqUwICB9A='
//var webServerScriptName = '${vmScaleSetName}Script'
// var launchScript = 'IyEvYmluL2Jhc2gKc3VkbyBzdQphcHQgdXBkYXRlCmFwdCBpbnN0YWxsIGFwYWNoZTIgLXkKdWZ3IGFsbG93ICdBcGFjaGUnCnN5c3RlbWN0bCBlbmFibGUgYXBhY2hlMgpzeXN0ZW1jdGwgcmVzdGFydCBhcGFjaGUy'
///////

// resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2022-07-02' existing = {
//   name: diskEncryptionSetName
// }

resource vnetagvmssWebApp 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: virtualNetworkName_webapp
}

// A virtual machine scale set
resource webServer 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: webServerName
  location: location
  tags: {
    Environment: envName
    Location: location
  }
  sku: {
    capacity: int(instanceCount)
    name: webServerSku
    tier: 'Standard'
  }
  properties: {
    overprovision: true
    upgradePolicy: {
      mode: 'Automatic'
    }
    singlePlacementGroup: singlePlacementGroup
    platformFaultDomainCount: platformFaultDomainCount
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
          managedDisk: {
            storageAccountType: 'StandardSSD_LRS'
            // diskEncryptionSet: {
            //   id: diskEncryptionSet.id
            // }
          }
        }
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: vmScaleSetName
        adminUsername: adminUsername
        adminPassword: adminPassword
        customData: launchScript
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: nicName
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: ipConfigName
                  properties: {
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetagvmssWebApp, vnetagvmssWebApp[0].id)
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                        id: bePoolID
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
    // automaticRepairsPolicy: {
    //   enabled: true
    //   //repairAction: 'Replace'
    //   gracePeriod: 'PT10M'
    // }
  }
  // dependsOn: [
  //   appGateway
  // ]
}

//A public IP for the load balancer.
resource webServerPublicIP 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: publicIpSku
  }
  tags: {
    Environment: envName
    Location: location
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: longvmScaleSet
    }
  }
}

// Autoscaling resource for the vmss
resource autoScaleResource 'Microsoft.Insights/autoscalesettings@2022-10-01' = {
  name: autoScaleResourceName
  location: location
  properties: {
    name: autoScaleResourceName
    targetResourceUri: vmssId
    enabled: true
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: autoScaleMin
          maximum: autoScaleMax
          default: autoScaleDefault
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricNamespace: ''
              metricResourceUri: vmssId
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT${durationTimeWindow}M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: scaleOutCPUPercentageThreshold
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: scaleOutInterval
              cooldown: 'PT1M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricNamespace: ''
              metricResourceUri: vmssId
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: scaleInCPUPercentageThreshold
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: scaleInInterval
              cooldown: 'PT1M'
            }
          }
        ]
      }
    ]
    predictiveAutoscalePolicy: {
      scaleMode: predictiveAutoscaleMode
      scaleLookAheadTime: 'PT14M'
    }
  }
}

//Output webserver name
output webServerName string = webServer.name
output webServerID string = webServer.id
