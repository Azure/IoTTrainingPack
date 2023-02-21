@description('Location for all resources.')
param location string = resourceGroup().location

// Create a log analytics workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name: 'iot-hub-log-analytics'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

// Create an IoT Hub
resource iotHub 'Microsoft.Devices/IotHubs@2020-03-01' = {
  name: 'iot-hub-bicep'
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
  properties: {
    eventHubEndpoints: {
      events: {
        retentionTimeInDays: 1
        partitionCount: 4
        path: 'events'
      }
    }
    ipFilterRules: []
    minTlsVersion: '1.2'
  }
}
//enable all logs and metrics
// Create a diagnostic setting to send IoT Hub logs and metrics to log analytics workspace
resource iotHubDiagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'iot-hub-diagnostic-setting'
  scope: iotHub
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        categoryGroup: 'allLogs'
        enabled: true
      }
      {
        categoryGroup: 'audit'
        enabled: true
      }      
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}
