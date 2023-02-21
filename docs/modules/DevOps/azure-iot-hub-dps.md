---
title: Azure IoT Hub DPS
description: Azure IoT Hub DPS
author: Chris Ayers
ms.author: chrisayers
ms.date: 02/06/2023
ms.topic: conceptual
ms.service: iot
services: iot
nav_order: 5
parent: DevOps for Azure IoT
grand_parent: IoT Production Training Pack
has_children: false
---

# Azure IoT Hub Device Provisioning Service (DPS) and Infrastructure as Code (IaC)

The IoT Hub Device Provisioning Service (DPS) is a helper service for [Azure IoT Hub](./azure-iot-hub.md) that enables zero-touch, just-in-time provisioning to the right IoT hub without requiring human intervention. DPS enables the provisioning of millions of devices in a secure and scalable manner. Azure IoT Hub DPS supports multiple device identities, attestation mechanisms, and provisioning protocols. Azure IoT Hub DPS provides a scalable and secure way to manage the entire device lifecycle.

## Azure IoT Hub DPS Resources
We can discover the various options and settings for Azure IoT Hub DPS by looking at the documentation. The documentation is a great resource for learning about the various Azure resources and their settings.

[ARM](https://learn.microsoft.com/en-us/azure/templates/microsoft.devices/provisioningservices?pivots=deployment-language-arm-template) / [Bicep](https://learn.microsoft.com/en-us/azure/templates/microsoft.devices/provisioningservices?pivots=deployment-language-bicep) / [Terraform AzApi](https://learn.microsoft.com/en-us/azure/templates/microsoft.devices/provisioningservices?pivots=deployment-language-terraform) / [Terraform azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps)

## Azure IoT Hub DPS Bicep Template
For our example, we will use the Bicep template to create an IoT Hub DPS instance. The Bicep template is a great way to learn about the various settings and options for Azure IoT Hub DPS.

At a high level, here's some of the capabilities and features you can configure:

- Create an IoT Hub DPS instance in a specified location with a given SKU (pricing tier)
- Link an IoT Hub DPS to an [Azure IoT Hub](./azure-iot-hub.md) instance.
- Define tags for the IoT Hub DPS instance
- Configure the identity of the IoT Hub DPS instance
- Define the properties of the IoT Hub DPS, such as the enrollment type, attestation mechanisms, allocation policy, and more.
- Configure custom allocation rules for the IoT Hub DPS instance
- Configure certificates for the IoT Hub DPS instance
- Configure endpoint configurations for the IoT Hub DPS instance

Note that this is not an exhaustive list of all the capabilities of Azure IoT Hub DPS, but it covers many of the key features.

A basic IoT Hub DPS instance can be created with the following Bicep template:

```bicep
@description('Specify the name of the Iot DPS hub.')
param iotDpsName string

@description('Specify the location of the resources.')
param location string = resourceGroup().location

@description('The SKU to use for the IoT DPS Hub.')
param skuName string = 'S1'

@description('The number of IoT DPS Hub units.')
param skuUnits int = 1

resource iotDps 'Microsoft.Devices/provisioningServices@2021-07-01' = {
  name: iotDpsName
  location: location
  sku: {
    name: skuName
    capacity: skuUnits
  }
  properties: {
    allocationPolicy: {
      type: 'Hashed'
      hashAlgorithm: 'SHA1'
    }
    attestation: {
      type: 'SymmetricKey'
    }
    enrollment: {
      attestation: {
        type: 'SymmetricKey'
      }
    }
  }
}
```

## Azure IoT Hub DPS Group Enrollment

Group enrollment is a method of provisioning devices to [Azure IoT Hub](./azure-iot-hub.md). In this method, a group of devices is provisioned to IoT Hub using a single enrollment entry. The enrollment entry contains the IoT Hub device connection string and the symmetric key used to authenticate the device. The enrollment entry also contains the device IDs of the devices that are part of the group. When a device in the group connects to IoT Hub, the device ID is used to authenticate the device. The device ID is matched against the list of device IDs in the enrollment entry. If the device ID is found, the device is provisioned to IoT Hub. If the device ID is not found, the device is not provisioned to IoT Hub.

![](media/dps-provisioning-flow.png)

### AZ CLI

We can create a group enrollment using the Azure CLI. The following command creates a group enrollment with the name "myGroupEnrollment" and the device IDs "device1" and "device2".

```bash
az iot dps enrollment-group create -g {resource_group_name} --dps-name {dps_name} --enrollment-id {enrollment_id} --certificate-path /certificates/Certificate.pem
```

```bash
az iot dps enrollment-group create -g {resource_group_name} --dps-name {dps_name} --enrollment-id {enrollment_id} --certificate-path /certificates/Certificate.pem --provisioning-status enabled --initial-twin-properties "{'location':{'region':'US'}}" --initial-twin-tags "{'version_dps':'1'}"
```


### Demo
Please see the [/modules/DevOps/IotHub](https://github.com/Azure/IoTTrainingPack/tree/main/modules/DevOps/IoTHub-DPS) folder for code samples.
