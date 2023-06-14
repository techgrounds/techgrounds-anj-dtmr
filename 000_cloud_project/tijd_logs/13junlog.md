# June 13, 2023 Tuesday

## Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- Today I was in a rabbit hole of Errors, Errors, Errors.

## Obstakels & Oplossingen

1. Asking better questions

- [ ] is there a deployement id for resource group?

No, resource groups in Azure do not have deployment IDs associated with them. Deployment IDs are specific to deployments made using Azure Resource Manager (ARM) templates or Bicep files.

A deployment ID is generated when you initiate a deployment using ARM templates or Bicep files through tools like Azure CLI, Azure PowerShell, Azure portal, or Azure DevOps. The deployment ID represents a specific deployment instance and can be used to retrieve information about that deployment.

On the other hand, resource groups are logical containers for organizing and managing Azure resources. They do not have a direct association with deployment IDs. However, you can associate resources deployed within a resource group with a specific deployment by examining the deployment history or properties of those resources.

To summarize, deployment IDs are tied to deployments made using ARM templates or Bicep files, whereas resource groups serve as containers for organizing resources in Azure.

- [ ] is subscription id changing every resources deployement?

No, the subscription ID does not change for each resource deployment. The subscription ID is associated with the Azure subscription itself and remains constant regardless of the number or frequency of resource deployments within that subscription.

When you deploy resources in Azure, such as virtual machines, storage accounts, or databases, those resources are created within the context of a specific Azure subscription. The subscription ID is used to uniquely identify and scope operations within that subscription.

Each resource deployed within a subscription is associated with its own set of unique identifiers, such as a resource ID, resource group name, and resource name. These identifiers help to manage and access the individual resources, but they are independent of the subscription ID.

The subscription ID is typically used for administrative tasks, managing access control, and scoping permissions across the entire subscription. It provides the overall context for the resources and services available within that subscription.

In summary, the subscription ID remains constant and does not change for each resource deployment. It serves as a top-level identifier for the Azure subscription and helps to manage and govern all resources and services within that subscription.

## Learnings

- how to use module to another bicep file and connect to the right path
- Variables don't need types to be specified
- Expressions: By using subscription() without any arguments, it references the current subscription as the scope for the module.

---

## Plans for tomorrow

1. Leren over expressions, modules

2. Write down a management server

3. Architecture

4. Continue

https://learn.microsoft.com/en-gb/shows/learn-live/use-bicep-deploy-azure-infrastructure-as-code-ep02-build-first-bicep-template?WT.mc_id=learnlive-20220315A

https://learn.microsoft.com/en-us/training/modules/build-first-bicep-template/

https://learn.microsoft.com/en-us/events/learn-events/learnlive-iac-and-bicep/

https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI

https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/

5. Turn assumptions into a daily planning

6. Ready a bit for the presentation
