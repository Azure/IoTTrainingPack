@description('Specify the name of the Iot hub.')
param iotHubName string

@description('Specify the name of the provisioning service.')
param provisioningServiceName string

@description('The SKU to use for the IoT Hub.')
param skuName string = 'S1'

@description('The number of IoT Hub units.')
param skuUnits int = 1

@description('Specify the location of the resources.')
param location string = resourceGroup().location

@description('Specify the certificate to use for the provisioning service.')
param certificateName string = 'provisioning-certificate'

@description('Specify the certificate to use for the provisioning service.')
@secure()
param certificateContents string

var iotHubKey = 'iothubowner'
var iotHubLocations = [ 'eastus', 'centralus', 'westus' ]

// deploy module n times
resource iotHubs 'Microsoft.Devices/IotHubs@2021-07-02' = [for iotHubLocation in iotHubLocations: {
  name: '${iotHubName}-${iotHubLocation}'
  location: iotHubLocation
  sku: {
    name: skuName
    capacity: skuUnits
  }
  properties: {}
}]

resource provisioningService 'Microsoft.Devices/provisioningServices@2022-02-05' = {
  name: provisioningServiceName
  location: location
  sku: {
    name: skuName
    capacity: skuUnits
  }
  properties: {
    allocationPolicy: 'GeoLatency'
    iotHubs: [for (iotHub, i) in iotHubLocations: {
      connectionString: 'HostName=${iotHubs[i].properties.hostName};SharedAccessKeyName=${iotHubKey};SharedAccessKey=${iotHubs[i].listkeys().value[0].primaryKey}'
      location: iotHubs[i].location
    }]
  }
}

resource certificate 'Microsoft.Devices/provisioningServices/certificates@2022-02-05' = {
  name: certificateName
  parent: provisioningService
  properties: {
    certificate: certificateContents
  }
}
