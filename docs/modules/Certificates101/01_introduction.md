---
title: Introduction to Certificates
description: An introduction to the basic ideas around certificates
author: Michael C. Bazarewsky
ms.author: micbaz
ms.date: 02/06/2023
ms.topic: conceptual
ms.service: iot
services: iot
nav_order: 1
parent: Certificates 101
grand_parent: Home
has_children: false
---

# Introduction to Certificates

Something that most people experiences every day is the reassuring lock
icon on the browser, telling the user that the connection is secure, and
the site uses a "valid certificate issued by a trusted authority":

![Browser connection details indicating "Connection is secure"](media/Certificates_2.png)

![Browser "Connection is secure" details](media/Certificates_3.png)

From time to time, though, a user may experience a "not secure"
connection warning, which is recommending us not to share any sensitive
information with the website because it uses an invalid certificate:

!["Your connection to this site isn't secure"](media/Certificates_4.png)

![Browser "Your connection to this site isn't secure" details](media/Certificates_5.png)

What do these messages mean? What is the "certificate" in question, and
where does it come from? That's the purpose of this content.

The content starts with an overview of digital certificates, including
the underlying concepts, the concept of certificate trust, and the full
certificate lifecycle. After that underlying foundation, there's a
discussion of how the Azure IoT platform uses certificates.
