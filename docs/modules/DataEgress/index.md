---
title: Data Egress
has_children: true
nav_order: 2
parent: Home
---

# Data Egress

## Overview

Azure IoT Hub is a fully managed service that helps enable reliable and secure bi-directional communications between millions of devices and a solution back end.

Custom functionality which processes data or messages sent from devices to IoT Hub can retrieve information using two different patterns:

![DataEgressOverview](img/DataEgressOverview.png)  

* Data Egress: This module covers multiple ways to egress data from IoT Hub
  * [IoT Hub Routes](routing.md) provides and overview and gives best practices how IoT Hub's data routing functionality can be used to ***push*** data to other Azure PaaS services like Service Bus, Event Hubs or Azure Storage. It highlights how messages ingested to IoT Hub can be enriched and how messages can be filtered.

    ### Example Code
    
    Please see the [DataEgress-Routing](https://github.com/Azure/IoTTrainingPack/tree/main/modules/DataEgress-101-Routing) folder for code samples.

  * [Event Grid integration](eventgrid.md): provides and overview how the IoT Hub Event Grid integration can be used to ***push*** data to other Azure PaaS services.
    ### Example Code
    
    Please see the [DataEgress-EventGrid](https://github.com/Azure/IoTTrainingPack/tree/main/modules/DataEgress-101-EventGrid) folder for code samples.


  * Service Endpoints: Will be provided soon.

