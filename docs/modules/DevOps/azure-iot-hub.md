---
title: Azure IoT Hub
description: How to use DevOps when using Azure IoT Hub in your architecture
author: Chris Ayers
ms.author: chrisayers
ms.date: 02/06/2023
ms.topic: conceptual
ms.service: iot
services: iot
nav_order: 4
parent: DevOps for Azure IoT
grand_parent: IoT Production Training Pack
has_children: false
---

# Azure IoT Hub and Infrastructure as Code (IaC)

Azure IoT Hub is a fully managed service that enables reliable and secure bi-directional communications between millions of IoT devices and a solution back end. IoT Hub supports multiple messaging patterns, including device-to-cloud, cloud-to-device, and cloud-to-cloud. IoT Hub also supports file upload and notifications via HTTP, MQTT, AMQP, and HTTPS.

Azure IoT Hub has settings and configuration for Identity and Authentication, Communication, Telemetry, Properties, Commands, Endpoints, Routing.

## Azure IoT Hub Resources

We can discover the various options and settings for Azure IoT Hub by looking at the documentation. The documentation is a great resource for learning about the various Azure resources and their settings.

[ARM](https://learn.microsoft.com/en-us/azure/templates/microsoft.devices/iothubs?pivots=deployment-language-arm-template) / [Bicep](https://learn.microsoft.com/en-us/azure/templates/microsoft.devices/iothubs?pivots=deployment-language-bicep) / [Terraform AzApi](https://learn.microsoft.com/en-us/azure/templates/microsoft.devices/iothubs?pivots=deployment-language-terraform) / [Terraform azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub)

## Azure IoT Hub Bicep Template

For our example, we will use the Bicep template to create an IoT Hub instance. The Bicep template is a great way to learn about the various settings and options for Azure IoT Hub.

At a high level, here's some of the capabilities and features you can configure:

- Create an IoT Hub instance in a specified location with a given SKU (pricing tier)
- Define tags for the IoT Hub instance
- Configure the identity of the IoT Hub instance
- Define the properties of the IoT Hub, such as the allowed FQDN list, authorization policies, cloud-to-device messaging settings, device streams, disablement of SAS, and more.
- Enable encryption and data residency for the IoT Hub instance
- Configure [routing endpoints](../DataEgress/) for the IoT Hub, such as Event Hubs, Service Bus, and Storage Containers
- Configure routing enrichments and routes for the IoT Hub instance
- Configure IP filter rules for the IoT Hub instance
- Define private endpoint connections and public network access for the IoT Hub instance

Note that this is not an exhaustive list of all the capabilities of Azure IoT Hub, but it covers many of the key features.
We can also create and link our Azure IoT Hubs to [Azure IoT Hub Device Provisioning Service](./azure-iot-hub-dps.md).

A basic IoT Hub instance can be created with the following Bicep template:

```bicep
@description('Specify the name of the Iot hub.')
param iotHubName string

@description('Specify the location of the resources.')
param location string = resourceGroup().location

@description('The SKU to use for the IoT Hub.')
param skuName string = 'S1'

@description('The number of IoT Hub units.')
param skuUnits int = 1

resource iotHub 'Microsoft.Devices/IotHubs@2021-07-02' = {
  name: iotHubName
  location: location
  sku: {
    name: skuName
    capacity: skuUnits
  }
  properties: {}
}
```

### Demo
 
Please see the [/modules/DevOps/IotHub](https://github.com/Azure/IoTTrainingPack/tree/main/modules/DevOps/IoTHub) folder for code samples.
