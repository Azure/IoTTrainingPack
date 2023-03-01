@description('Specifies the name of the IoT Hub.')
@minLength(3)
param iotHubName string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Specifies the IotHub SKU.')
param skuName string = 'F1'

@description('Environment Tag')
param environmentTag string = 'dev'

@description('Specifies the number of provisioned IoT Hub units. Restricted to 1 unit for the F1 SKU. Can be set up to maximum number allowed for subscription.')
@minValue(1)
@maxValue(1)
param capacityUnits int = 1

var consumerGroupName = '${iotHubName}/events/cg1'

//https://learn.microsoft.com/en-us/azure/templates/microsoft.devices/iothubs?pivots=deployment-language-bicep
resource iotHub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: iotHubName
  location: location
  properties: {
    eventHubEndpoints: {
      events: {
        retentionTimeInDays: 1
        partitionCount: 2
      }
    }
    cloudToDevice: {
      defaultTtlAsIso8601: 'PT1H'
      maxDeliveryCount: 10
      feedback: {
        ttlAsIso8601: 'PT1H'
        lockDurationAsIso8601: 'PT60S'
        maxDeliveryCount: 10
      }
    }
    messagingEndpoints: {
      fileNotifications: {
        ttlAsIso8601: 'PT1H'
        lockDurationAsIso8601: 'PT1M'
        maxDeliveryCount: 10
      }
    }
    // For using the New DigiCert Global G2 Root Certificate instead of the Baltimore CyberTrust Root
    rootCertificate: {
        enableRootCertificateV2: true
    }
  }
  sku: {
    name: skuName
    capacity: capacityUnits
  }
  tags: {
    environment: environmentTag
  }
}

resource consumerGroup 'Microsoft.Devices/IotHubs/eventHubEndpoints/ConsumerGroups@2022-04-30-preview' = {
  name: consumerGroupName
  properties: {
    name: 'cg1'
  }
  dependsOn: [
    iotHub
  ]
}

output iotHubName string = iotHub.name
