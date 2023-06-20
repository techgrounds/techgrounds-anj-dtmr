# Weekly Time Logs

## Week 1

June 5, 2023 Monday

## Dagverslag (1 zin)

1. Allowed myself to have time to read the pdf where all the information about the details is explained
2. Find tools on how I can manage the project efficiently: github project, miro, timeblocking, whiteboarding
3. To start this project, I research first on what kind of tools I can use for project management.
4. I have noticed on myself that I work better if I have a macro view of the task. On this project we are asked to use IaC using Azure Bicep, since I am both unfamiliar with both of the concept, I decided to focus on the theory aspect first.

I decided to watch/do these:

- [Use Bicep to deploy your Azure infrastructure as code Ep1: Introduction to infrastructure as code using Bicep](https://learn.microsoft.com/en-gb/shows/learn-live/use-bicep-deploy-azure-infrastructure-as-code-ep01-introduction-infrastructure-as-code-using-bicep?WT.mc_id=learnlive-20220308A)

## Obstakels & Oplossingen

1. Asking better questions

- [ ] How to start this project technically? How do I start my IaC Azure Bicep app project?

2. No clue how to start it. Especially that it was written in Dutch, but I start with noting down the words,
   that are not familiar, translate it, read the sentence again, then decide if it's important for the project or not.
3. The pdf has many words I could not comprehend with one reading,
   so I reread and reread until I understood.
4. The pdf has 12 pages, that could be overwhelming. I've creating bullet points and used a kanban method
   to ensure I miss nothing from the important details about the project itself.
5. Focus was a challenge because of the routine during and after the az-900, I created a gitHub project for
   myself where I have the important dates and information.

## Learnings

1. Bicep is a type of ARM template

## Key terminology

- [ ] automatiseert
- [ ] eigen cloud provider - AZURE
- [ ] suggereren
- [ ] Infrastructure as Code
- [ ] Git Tag commits
- [ ] uitwerking
- [ ] Ontwerp Documentatie
- [ ] Beslissing Documentatie

---

June 6, 2023 Tuesday

## Dagverslag (1 zin)

1. Today, I decided to focus on understanding what the user stories are and its connection to the requirements we have. I used a miro board instead of a traditional kanban board, as this is more flexible.

2. I decided to follow what terminologies I don't know from the project pdf. Because I know, without knowing about these concepts, I won't know how the project should be in a big picture.

I decided to watch/do these:

- [What is infrastructure as code (IaC)?](https://learn.microsoft.com/en-us/devops/deliver/what-is-infrastructure-as-code)
- [Fundamentals of Bicep](https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/)

## Obstakels & Oplossingen

1. Asking better questions

- [ ] To my team, what questions did you use to start writing about the assumptions?
- [ ] Do we need to use another github repository for the project? Or git tag should be enough?

2. My day was puzzling about how I can manage all these information, in a more systematic way of working.
   I used [miro board](https://miro.com/app/board/uXjVMTGcfGo=/?share_link_id=416105946697) to map how I want to implement the project.

## Learnings

1. I can use Azure CLI on my MAC. Read the documentation first before installing anything.

---

June 7, 2023 Wednesday

## Dagverslag (1 zin)

- [x] Made a README file for this project

Finished the first three user stories:

- [x] Als team willen wij duidelijk hebben wat de eisen zijn van de applicatie
- [x] Als team willen wij een duidelijk overzicht van de aannames die wij gemaakt hebben.
- [x] Als team willen wij een duidelijk overzicht hebben van de Cloud Infrastructuur die de applicatie nodig heeft

## Obstakels & Oplossingen

1. Asking better questions

- [ ] How do I start my IaC Azure Bicep app project?
- [ ] why is it important to point out assumptions during the start of a project?
- [ ] how to define the network architecture?
- [ ] what is web server. how does web server look like?
- [ ] how to create a public IP resource in Azure and associating it with the server?
- [ ] what is network interface in azure cloud?
- [ ] why All subnets must be protected by a firewall at the subnet level?
- [ ] why SSH or RDP connections to the Web server should only be established from the admin server?
- [ ] what is ssh and rdp? should i use ssh or rdp?
- [ ] web server deployed in availability zone 2, application subnet with nsg. what does it mean?
- [ ] management server deployed in availability zone 1management subnet with NSG. what does it mean?
- [ ] how does post deployment scripts look like
- [ ] how to setup my iac azure bicep environment

## Learnings

1. How to write assumptions.

---

June 8, 2023 Thursday

## Dagverslag (1 zin)

Today I focused on learning what Bicep is.

I successfully set up my environment too.

I decided to watch/do these:

- [Bicep documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

## Obstakels & Oplossingen

1. Asking better questions

- [ ] shall i first create a management server for my iac bicep project?
- [ ] hoe kan ik draw.io gebruiken met azure icons?

2.
3.

## Learnings

1. I learned how to set up my bicep environtment in VSCode.
2. Found out that I could visualize the bicep script using vscode.
3. Difference between imperative and declarative code.

Imperative code focuses on describing how to achieve a desired outcome step by step. It tells the computer exactly what to do and how to do it. In imperative code, you need to specify each individual action or operation to be performed.

On the other hand, declarative code focuses on describing what the desired outcome should be, without specifying the step-by-step process of achieving it. It allows you to declare the desired state or result, and the underlying system figures out how to achieve it. Declarative code is more focused on the end goal rather than the specific actions to get there.

To put it simply, imperative code tells the computer how to do something, while declarative code tells the computer what you want to be done, and it figures out the how on its own.

## Plans for tomorrow

1. Continue

https://learn.microsoft.com/en-gb/shows/learn-live/use-bicep-deploy-azure-infrastructure-as-code-ep02-build-first-bicep-template?WT.mc_id=learnlive-20220315A

https://learn.microsoft.com/en-us/training/modules/build-first-bicep-template/

https://learn.microsoft.com/en-us/events/learn-events/learnlive-iac-and-bicep/

https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI

https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/

---

## Week 2

June 12, 2023 Monday

## Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- Vandaag heb ik verder bicep geleerd, vooral over parameters and variables.

- Ik heb de bash command om te deployen geleerd en de juiste parameters and path aan te passen.

- I successfully deploy a resource group using azure cli, check it

## Obstakels & Oplossingen

1. Asking better questions

- [ ] do you have tips on how to start the architecture/ topology? shall I first use the given architecture then build and iterate from it or should I make a topology the way I my assumptions are written? because the challenge also is I cannot see the macro view of this project in an architecture way. I understand how important it is from the beginning

- [ ] how to deploy resources using vscode and azure cli

- [ ] do you have tips on how to start the architecture/ topology? shall I first use the given architecture then build and iterate from it or should I make a topology the way I my assumptions are written? because the challenge also is I cannot see the macro view of this project in an architecture way. I understand how important it is from the beginning

## Learnings

- I've learned how the syntax of bicep more using parameters and variables.
- I saw the magic of deploying it on vscode then it appears on the portal.

## Plans for tomorrow

1. Leren over expressions, modules

2. Write down a Vnet resource and management server

3. Architecture

4. Continue

https://learn.microsoft.com/en-gb/shows/learn-live/use-bicep-deploy-azure-infrastructure-as-code-ep02-build-first-bicep-template?WT.mc_id=learnlive-20220315A

https://learn.microsoft.com/en-us/training/modules/build-first-bicep-template/

https://learn.microsoft.com/en-us/events/learn-events/learnlive-iac-and-bicep/

https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI

https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/

---

June 13, 2023 Tuesday

## Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- Today I was in a rabbit hole of Errors, Errors, Errors.

## Obstakels & Oplossingen

1. I was trying to deploy a resource group and vnet but it only keeps giving me error about target scope. I gave myself a half day to resolve it, then delete all the code and restart and think of new technique to go further.

2. Asking better questions

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

---

June 14, 2023 Wednesday

## Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- Yesterday I was trying to deploy multiple resources at one time. I only got errors, did not gave up until the end of the day. But today to be much more productive and reach the deadline, I will code one resource at a time then test the deployment for each, one at a time too. Meaning they won't be connected with each other and might be deployed separately (let's see if I can do that within one resource group)

ex. of files:
network.bicep, storage.bicep,

then deploy them first one by one if they are working, then find a way to have a command to deploy them as a group

## Obstakels & Oplossingen

1.

2.
3. Asking better questions

- [ ]
- [ ]

## Learnings

- bicep --help
- I will implement using publish branch, pull request and merging in this project.

## Plans for tomorrow

1. Review pull requests

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

---

# June 15, 2023 Thursday

## Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- I successfully merged the first pull requests I have to main branch for this project
- Successfully deployed a vnet with subnet, nsg, public ip, nic
  <<<<<<< Updated upstream
  =======
- Made a draft for the architecture
- Started storage last friday for post-deployment script but errors
- I've created a sort of mind mapping for myself for this project using miro board, compare my assumptions to all the requirements given
  > > > > > > > Stashed changes

## Obstakels & Oplossingen

1. I first created the subnet as a separate resource, but I keep getting an error, I remembered from the other meeting we had with the team that it's best practice to put the subnet within vnet and that's what I did.

2. When I was creating the nic, I need to connect the subnet ID. I did not know what that meant, is it the name? the ip address. I needed to find the correct command to reach the properties inside the subnet. The subnet ID refers to the unique identifier of a subnet within a virtual network.

3. Asking better questions

- [ ] What's the essense of using creating a new branch, and making a pull request for this project? what do you write when you create a pull request. Shall I delete the branch if I successfully merge it for less confusion? or any other tips.

- [ ] what does it like when a management subnet with nsg bicep
- [ ] what's the difference of having separate nsg and connecting the nsg to subnet?
- [ ] why do I need NIC
- [ ] VMSS hele jaar betaald?

## Learnings

- [ ] What is the dependencies of vnet: Azure portal account, Azure Subscription, Azure Resource Group, Azure Region, Address Space, Subnets, Network Security Groups (NSGs)

Additional: VnetPeering to connect this management vnet to the app vnet for later

## Plans for tomorrow

- [x] ToDo: connect nsg with subnet within the vnet
- [x] ToDo: recreate my app network using the management network
- Write down documentataion on management.bicep

- [x] Review pull requests
- [x] Adjust the Architecture accordingly

---

## Week 3

June 19, 2023 Monday

## Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- I was able to create Web/App Network just by re-using the codes I wrote for management Network. It was successfully deployed, change the port of management nsg to RDP.
- Successfully connect the two Networks using Azure Network Peering

## Obstakels & Oplossingen

1. At first I had a separate file: management.bicep and web/app.bicep. But I could not connect them successfully, I decided to bring them into one file, check it first if everything's working as is. Then try the peering code with parent parameters.

2. Connecting the nsg to subnet was not difficult but checking if it's successfully connected using the portal is a bit confusing. I played around to different tabs until I found where it was indicated.

3. Asking better questions

- [ ] what shall do first peering of the networks or the virtual machine

To establish network peering between virtual networks and connect a virtual machine (VM), it is generally recommended to perform the following steps:

Create the virtual networks: Define and deploy the virtual networks that you want to peer. This involves creating the necessary VNet resources, including subnets, network security groups (NSGs), and any other required configurations.

Configure network peering: Once the virtual networks are created, configure network peering between them. This allows the networks to communicate with each other using private IP addresses. You can define network peering in the resource declarations of your Bicep or ARM template, specifying the remote virtual network's ID or name.

Deploy virtual machines: After the network peering is established, deploy the virtual machines within the respective virtual networks. Ensure that the VMs are associated with the correct subnets and have the necessary configurations for network connectivity.

By following this sequence, you first set up the networking infrastructure by creating and peering the virtual networks. Then, you deploy the VMs within the connected virtual networks, allowing them to communicate seamlessly using the network peering connection.

Remember to replace placeholder values, such as VNet IDs and subnet names, with the actual values relevant to your setup.

- [ ]

## Learnings

## Plans for tomorrow

- Write down documentataion on management.bicep and web/app.bicep
- Continue microsoft module

https://learn.microsoft.com/en-gb/shows/learn-live/use-bicep-deploy-azure-infrastructure-as-code-ep02-build-first-bicep-template?WT.mc_id=learnlive-20220315A

https://learn.microsoft.com/en-us/training/modules/build-first-bicep-template/

https://learn.microsoft.com/en-us/events/learn-events/learnlive-iac-and-bicep/

https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI

https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/

- Turn assumptions into a daily planning

- Ready a bit for the presentation(peer to peer review)

---

June 20, 2023 Tuesday

## Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- [ ] gister / sinds de vorige bereikt:
- [ ] vandaag doelen:
- [ ] soft skills doel vandaag (Learning to learn, Peer 2 peer learning and Searching,
      Computational thinking, Rules, values and guiding principles, Time management, Presenting,
      Self reflection, Solution oriented, Networking, Assertiveness, Communication, Employability,
      Proactive, Self management, Team work, Empathie.):

- [ ] vandaag bereikt:
- [ ] 10 mins before/after the dagafsluiting: active recalling with the use of flashcards/quizlet/brainscape/anki
- [ ] self-reflection:
- [ ] vanavond: stop om 17u

## Obstakels & Oplossingen

1. Understanding how key vault works, what's requirements for the project and what resource uses it

2. Help others to user prettier for their code.

3. Asking better questions

- [ ] Waarom moet je de port pingen?

Key vault access policies

- [ ] Bij de key vault, wat soort access policies hebben de project nodig, moet ik de object id van jou team nodig, application ID???????? object ID

By specifying the objectId of the admin user, you limit access to only this specific user, reducing the attack surface and potential security risks.

- [ ] how to save the object ID without hard coding it on the keyvault.bicep file. .env file possible????

## Learnings

- learned about using 'existing' than output if you're using module.

## Plans for tomorrow

- zoek welke applicaties hebben de de key vault nodig
- .env objectID ----- environment
- Write down documentataion on management.bicep and web/app.bicep
- Continue microsoft module

https://learn.microsoft.com/en-gb/shows/learn-live/use-bicep-deploy-azure-infrastructure-as-code-ep02-build-first-bicep-template?WT.mc_id=learnlive-20220315A

https://learn.microsoft.com/en-us/training/modules/build-first-bicep-template/

https://learn.microsoft.com/en-us/events/learn-events/learnlive-iac-and-bicep/

https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI

https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/

- Turn assumptions into a daily planning

- Ready a bit for the presentation(peer to peer review)

---
