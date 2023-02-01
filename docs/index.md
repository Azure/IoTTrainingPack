---
title: IoT Production Training Pack
has_children: true
nav_order: 1
---

# IoT Production Training Kit

The IoT Production Training Kit contains a collection of examples and best practices to address common IoT use cases and challenges. The content is a combination of experiences from Microsoft teams and learnings from customer engagements.

The IoT Production Training Kit can help you to implement best practices, use the Azure IoT service which fits best to your scenario and to avoid common pitfalls when implementing IoT projects using Microsoft Azure IoT.

The IoT Production Training Kit is modular so you can jump to any section of interest or start at the beginning. The slides, demos and source code for each module are shared with a creative commons (with attribution) license to help your organization build effective IoT solutions With Azure IoT.

## Overview

A typical IoT scenario consists of: 

* IoT devices
* Field gateways
* A cloud gateway (edge based processing and storing capabilities)
* Cloud based processing and storage capabilities

![Overview](assets/images/ScenarioOverview.png)

## Modules

The training kit focuses on the following independent modules:
![KitContent](assets/images/KitContent.png)
* [IoT Edge](modules/IoTEdge/index.md): This module covers the capabilites Azure IoT Edge can bring into your IoT solutions including edge computing, offline support, cost optimization, etc.

* [Data Egress](modules/DataEgress/index.md): This module covers multiple ways to egress data from IoT Hub
  * [IoT Hub Routes](modules/DataEgress/index.md) provides and overview and gives best practices how IoT Hub's data routing functionality can be used to ***push*** data to other Azure PaaS services like Service Bus, Event Hubs or Azure Storage. It highlights how messages ingested to IoT Hub can be enriched and how messages can be filtered.
  * Event Grid integration: Will be provided soon.
  * Service Endpoints: Will be provided soon.

* Certificates: Will be provided soon.

* DevOps for IoT Hub: Will be provided soon.

## Summary & Highlights

* IoT Edge:
  * [IoT Concepts](modules/IoTEdge/index.md/#iot-concepts): covers common concepts and definitions to get up to speed with IoT solutions language.
  * [What is Azure IoT Edge](modules/IoTEdge/index.md/#what-is-azure-iot-edge): get a closer look to the capabilities and scenarios where you can use Azure IoT Edge.
  * [Create and manage IoT Edge devices](modules/IoTEdge/index.md/#create-and-manage-iot-edge-devices): covers considerations and provides pointers to further documentation to allow you to ask important questions so you can make correct choices for production scenarios.

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
