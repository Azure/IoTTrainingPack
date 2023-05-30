---
title: Infrastructure as Code (IaC)
description: An introduction to the basic ideas around Infrastructure as Code (IaC)
author: Chris Ayers
ms.author: chrisayers
ms.date: 02/06/2023
ms.topic: conceptual
ms.service: arm, bicep, terraform, cli, PowerShell
services: arm, bicep, terraform, cli, PowerShell
nav_order: 2
parent: DevOps for Azure IoT
grand_parent: Home
has_children: false
---

# Infrastructure as Code (IaC)

Infrastructure as Code (IaC) is the management of infrastructure (networks, virtual machines, load balancers, and connection topology) in a descriptive model, using version control to store the files.​

## Why use Infrastructure as Code (IaC)?

In code, you define the infrastructure that needs to be deployed. The infrastructure code becomes part of your project. Just like the application code, you store the infrastructure code in a source repository and version it. Anyone on your team can run the code and deploy similar environments.

Using infrastructure as code in Azure has many benefits, such as:

- **Reusability**: You can use IaC modules to avoid duplicating work or creating multiple templates for the same or similar purposes. Infrastructure modules should be reusable and flexible and should have a clear purpose.
- **Versioning**: You can store your infrastructure code in a source code repository, such as GitHub or Azure Repos, and track the changes over time. This adds governance, collaboration, and auditability to your infrastructure deployments.
- **Scalability**: You can easily provision new environments or infrastructure from your IaC configuration code, and scale them up or down as needed. This reduces the manual effort and human error involved in managing infrastructure.
- **Consistency**: You can use tools like Bicep, Azure Resource Manager (ARM), Terraform, or Azure CLI to declaratively script the cloud infrastructure you require, and ensure that the same environment is generated every time you deploy. This reduces the risk of configuration drift or mismatched dependencies.

## What Infrastructure as Code (IaC) are available Azure?

| Tool | Description | Pros | Cons |
| --- | --- | --- | --- |
| [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview) | A domain-specific language (DSL) that simplifies writing ARM templates using a more concise and readable syntax. | - Simplifies and improves the authoring experience of ARM templates. <br> - Supports intellisense, validation, and refactoring. <br> - Supports converting existing ARM templates to bicep files. | - Requires installing and updating the AZ CLI or the bicep CLI or VS Code extension. <br> - Limited support for cross-cloud or hybrid scenarios. |
| [Azure Resource Manager (ARM)](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/overview) | A native service that allows you to create, update, and delete resources in your Azure subscription using declarative templates. | - Fully integrated with Azure and its features. <br> - Supports role-based access control, policies, tags, and locks. <br> - Supports exporting existing resources as templates. | - Learning curve for the template syntax and structure. <br> - Limited support for cross-cloud or hybrid scenarios. <br> - Difficult to debug and test templates. |
| [Terraform](https://www.terraform.io/docs/providers/azurerm/index.html) | An open-source tool that enables you to provision and manage infrastructure across multiple cloud providers using a common configuration language. | - Declarative and modular approach. <br> - Supports state management and drift detection. <br> - Supports cross-cloud and hybrid scenarios. | - Learning curve for the configuration language and tool. <br> - Requires installing and maintaining the tool and plugins. <br> - May not support the latest Azure features or changes. |
| [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/) | A command-line tool that lets you manage Azure resources using scripts or commands. | - Easy to install and use. <br> - Supports multiple platforms and shells. <br> - Supports interactive mode and query filters. | - Imperative rather than declarative approach. <br> - Requires scripting skills and knowledge of Azure commands. <br> - Not idempotent by default. |
| [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/) | A set of modules that provide cmdlets to manage Azure resources using PowerShell. | - Familiar and powerful tool for Windows users. <br> - Supports multiple Azure services and features. <br> - Supports remote execution and automation. | - Imperative rather than declarative approach. <br> - Requires PowerShell skills and knowledge of Azure cmdlets. <br> - Not idempotent by default. |

Infrastructure as Code (IaC) is a powerful approach to managing cloud infrastructure, and it has many benefits such as reusability, versioning, scalability, and consistency. By using IaC tools such as Bicep, you can define and deploy your infrastructure as code, and ensure that it is consistent and reproducible across environments. Azure provides a variety of IaC tools that have different pros and cons, depending on your needs and preferences. By leveraging IaC and Azure, you can streamline your infrastructure management, reduce the risk of errors and drift, and enable collaboration and governance.

