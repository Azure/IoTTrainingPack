---
title: Certificate file formats
description: An introduction to digital certificates.
author: Michael C. Bazarewsky
ms.author: micbaz
ms.date: 07/07/2023
ms.topic: conceptual
ms.service: iot
services: iot
nav_order: 3
parent: Certificates 101
grand_parent: Home
has_children: false
---

# Certificate File Formats

We've covered details of what's in a certificate, and how it's used.  However,
there is one topic that is somewhat hidden but very often causes trouble
if the implementer doesn't understand about it, and that's what kind of file
formats are used to transfer and manage certificates on devices.  Different
runtimes and operating systems use different formats, and, like
[XKCD 927](https://xkcd.com/927/) implies, there are multiple "standards"
related to those formats.  This document talks about some of the most
common formats a certificate-consuming developer or administrator is
likely to encounter.

## Encodings

Before getting into specific file formats, some notes about
encodings would be good, to avoid repetition later.

An *encoding* defines the file format for how the certificate data
is stored in the certifcate file.  In other words, it defines how 
the certificate data is translated into bytes that will be stored in the
file.

There are three encodings generally seen in the field - DER encoding,
Base64 encoding, and PFX/PKCS#12 encoding.  Two of these are cross-format,
while the last, PFX/PKCS#12, is only used in that specific file type, and
thus is described later for that extension specifically.

### DER encoding

DER (Distinguished Encoding Rules) encoding is a relatively complex
file format that is derived from the 
[ASN.1](https://en.wikipedia.org/wiki/ASN.1) standard.  The details
of the formatting are outside of the scope of this documentation; 
the key point to understand is that this is a binary format, which
means it can be more complicated to manage in some cases.

### Base64 encoding

Base64 encoding is a general encoding format that converts binary
into ASCII format.  Although there have been some variants of this,
the standard way to do this is defined in
[RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648#section-4).

The important takeaway for Base64 is that because it's an ASCII
format, it's very easy to transfer, including if appropriate
in source code text strings or files stored side-by-side as
source files in source code control.  (**Note that you should
never store private keys in source code control!**)

## PFX/P12 files

A `PFX` (or PKCS#12 - the formal name for the format) is a binary format
that supports holding both a private and a public key, with an optional
password protecting the private key.

It also supports holding an entire certificate chain, up to an including a 
root CA public key, which means that a server using or importing a `PFX` file
can present the entire chain for validation by a client.  As described in 
[the X.509](02_x509) content, a full chain to a trusted root is required to 
perform proper validation.

Technically, PFX is not exactly the same as PKCS#12, but in common practice,
it's not unusual to see the terms used interchangably, although "PFX" is
much more commonly used
as the format name.

This file format is the typical file format used in Microsoft Windows and in
Azure.

## PVK

A `PVK` file is a Microsoft-proprietary format for binary storage of a private
key exclusively.  In practice, this is often a temporary format that is then
used after a CA issues a certificate tied to the public half of the key pair;
the public and private key are then combined into a PFX for future management
and distribution.  There's documentation on this at
[Microsoft Learn](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/personal-information-exchange---pfx--files)
in a few [different pages](https://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/pvk2pfx).

These commmonly are seen for code-signing in Microsoft environments.

## SPC

An `SPC` file (Software Publisher Certificate) is a DER-encoded file that
stores one or more certificates and keys; often this is seen as the public-key
companion to a PVK file, where the combination of a PVK and an SPC act as one 
or more certificates.  Some CAs issue certificates for use cases such as
code-signing through a pairing of `SPC` and `PVK`, although that's not as
commonnly seen nowadays.

## PEM (CRT, CER)

A `PEM` file is a Base64-encoded that acts as a container for one or more
base64-encoded certificates and keys.  This format is very common; for example,
it's used by
[nginx](https://www.nginx.com/blog/secure-distribution-ssl-private-keys-nginx/),
Because the format is essentially just a text file format that stores one or more
base64-encoded objects, it's very flexible; it can store
just a public leaf key, or a certificate chain, or just a private key,
or some combination of the above.  

These are sometimes seen with the `CRT` extension (e.g. OpenSSL commonly uses
that extension) or the `CER` extension (e.g. on Windows; note that Windows
`CER` files may also be in the `DER` format).

One other common use case for PEM files is SSH - SSH tools generally store
their public and private keys in seperate PEM files.  For example,
the `~/.ssh/id_rsa` file is a PEM file that represents an SSH private key,
while the `~/.ssh/id_rsa.pub` represents an SSH public key.

## P7B (PKCS#7)

`P7B` files (or PKCS#7 files) are Base64-encoded files that store only
public key chains, without private keys.  They are seen in both Microsoft
Windows and Java environments.

## Converting between formats

There are multiple tools that can convert between different file formats,
but the one most commonly seen is the open source `openssl` tool.  Examples
of hwo to do this are available online at multiple sources, including:

* [DigiCerts's "How convert a certificate into the appropriate format"](https://knowledge.digicert.com/solution/SO26449.html)

* [HowToUseLinux's "Understanding PFX Files with Examples"](https://www.howtouselinux.com/post/pfx-file-with-examples)

* [SSL.com's "Create a .pfx/.p12 Certifcate File Using OpenSSL"](https://www.ssl.com/how-to/create-a-pfx-p12-certificate-file-using-openssl/)
