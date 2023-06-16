# June 15, 2023 Thursday

## Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- I successfully merged the first pull requests I have to main branch for this project
- Successfully deployed a vnet with subnet, nsg, public ip, nic

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

---

## Plans for tomorrow

- ToDo: connect nsg with subnet
- Write down documentataion on management.bicep

- Review pull requests
- Architecture
- Continue microsoft module

https://learn.microsoft.com/en-gb/shows/learn-live/use-bicep-deploy-azure-infrastructure-as-code-ep02-build-first-bicep-template?WT.mc_id=learnlive-20220315A

https://learn.microsoft.com/en-us/training/modules/build-first-bicep-template/

https://learn.microsoft.com/en-us/events/learn-events/learnlive-iac-and-bicep/

https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI

https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/

- Turn assumptions into a daily planning

- Ready a bit for the presentation
