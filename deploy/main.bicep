@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The type of environment. This must be nonprod or prod.')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

@description('Indicates whether to deploy the storage account for irinchi manuals.')
param deployMsYamlIrinaStorageAccount bool

@description('A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

var appServiceAppName = 'irinchi-website-${resourceNameSuffix}'
var appServicePlanName = 'irinchi-website-plan'
var MsYamlIrinaStorageAccountName = 'irinchiweb${resourceNameSuffix}'

// Define the SKUs for each component based on the environment type.
var environmentConfigurationMap = {
  nonprod: {
    appServicePlan: {
      sku: {
        name: 'F1'
        capacity: 1
      }
    }
    MsYamlIrinaStorageAccount: {
      sku: {
        name: 'Standard_LRS'
      }
    }
  }
  prod: {
    appServicePlan: {
      sku: {
        name: 'S1'
        capacity: 2
      }
    }
    MsYamlIrinaStorageAccount: {
      sku: {
        name: 'Standard_ZRS'
      }
    }
  }
}
var MsYamlIrinaStorageAccountConnectionString = deployMsYamlIrinaStorageAccount ? 'DefaultEndpointsProtocol=https;AccountName=${MsYamlIrinaStorageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${MsYamlIrinaStorageAccount.listKeys().keys[0].value}' : ''

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: environmentConfigurationMap[environmentType].appServicePlan.sku
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'MsYamlIrinaStorageAccountConnectionString'
          value: MsYamlIrinaStorageAccountConnectionString
        }
      ]
    }
  }
}

resource MsYamlIrinaStorageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = if (deployMsYamlIrinaStorageAccount) {
  name: MsYamlIrinaStorageAccountName
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: environmentConfigurationMap[environmentType].MsYamlIrinaStorageAccount.sku
}
