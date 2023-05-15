# Azure Functions

Azure Functions is a serverless compute service that lets you run event-triggered code without having to explicitly provision or manage infrastructure. It is like a vending machine that dispenses snacks when you insert coins. Similarly, Azure Functions executes your code when an event occurs

Azure Functions is een serverless oplossing waarmee u minder code kunt schrijven, minder infrastructuur hoeft te onderhouden en kosten kunt besparen. In plaats van u zorgen te maken over het implementeren en onderhouden van servers, biedt de cloudinfrastructuur alle up-to-date resources die nodig zijn om uw applicaties draaiende te houden.

Azure Functions kan worden gebruikt in on-premises omgevingen om klanten te helpen bij het optimaliseren van lokale hardware en software. Azure Functions kan ook worden gebruikt in cloudomgevingen zoals Azure om klanten te helpen bij het optimaliseren van virtuele machines of Kubernetes-clusters.

Het verschil tussen Azure Functions en andere gelijksoortige diensten is dat Azure Functions specifiek is ontworpen voor Azure-implementaties. Andere serverless diensten kunnen breder zijn en advies geven over een breed scala aan technologieën.

U kunt deze dienst vinden in de Azure Portal onder de categorie "Functions". U kunt deze dienst inschakelen door u aan te melden bij de Azure Portal en vervolgens Functions te openen.

## Bestudeer

- [x] Waar is Azure Functions voor?
- [x] Waar wordt Azure Functions voor gebruikt?
- [x] Hoe past Azure Functions / vervangt Azure Functions in een on-premises setting?
- [x] Hoe kan ik Azure Functions combineren met andere diensten?
- [x] Wat is het verschil tussen Azure Functions en andere gelijksoortige diensten?
- [x] Waar kan ik deze dienst vinden in de console?
- [x] Hoe zet ik deze dienst aan?
- [x] Hoe kan ik deze dienst koppelen aan andere resources?

## Sources list used for solving the exercise

- [Notes]()
- [Flashcard]()
- [Create a Python function in Azure from the command line](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-cli-python?tabs=azure-cli%2Cbash&pivots=python-mode-configuration)
- [Create a function in Azure with Python using Visual Studio Code](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-python?pivots=python-mode-configuration)
- [Zip deployment for Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/deployment-zip-push)
- [Resolve errors for resource not found](https://learn.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-not-found?tabs=bicep)
- Azure Functions Overview | Microsoft Learn. https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview.
- Getting started with Azure Functions | Microsoft Learn. https://learn.microsoft.com/en-us/azure/azure-functions/functions-get-started.
- Azure Functions – Serverless Functions in Computing | Microsoft Azure. https://azure.microsoft.com/en-au/products/functions/.

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ]

[Issue 2:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/func-issue2.png) I could not upload the API using VSCode, it's not showing the resources. I use the portal to follow the rest of the steps to solve this.


## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Here's the step by step guide how I did it:**

I chose to Create a function in Azure with Python using Visual Studio Code and Zip deployment for Azure Functions

1. Configure the environment:
- [x] An Azure account with an active subscription.
- [x] Visual Studio Code
- [x] Python extension and a versions that are supported by Azure Functions
- [x] Installed Azure Tool with The Azure Functions Core Tools.

![azure](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/1func-vscode-dl-azure.png)

2. Sign in to Azure from VSCode
![signin](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/2func-signedin.png)

4. Create a local project
![local](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/3func-createfunc.png)
![proj](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/4func-funcoverview.png)

5. Run the function locally
![run](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/5func-run.png)

6. Then execute the function
![execute](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/6func-runmsg.png) 

![HTTP](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/8func-browser-works.png)
![name](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/9func-namechange.png)

7. Create function app using the azure portal
![funcapp](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/10func-createfuncapp-portal.png)

![overview](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/func-app-overview1.png)

8. Upload API
![upload](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/11func-upload.png)

9. Copy the URL from the overview and check if your func app is working
![working](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/12func-browser.png)

10. Delete the resources
![delete](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-6-includes/func-delete.png)
