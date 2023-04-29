# Azure Virtual Network (VNet)

## Key terminology

- [x] Network Security Group (NSG).
- [x] hub-and-spoke network
- [x] Het verschil tussen Basic en Premium Firewall.
- [x] Het verschil tussen een Firewall en een Firewall beleid (Firewall Policy).
- [x] Dat Azure Firewall veel meer is dan alleen een firewall.
- [x] Het verschil tussen Azure Firewall en NSG.

## Benodigdheden

- [x] Je Azure Cloud omgeving (link)
- [x] Azure documentatie

## Opdrachten

- [x] Zet een webserver aan. Zorg dat de poorten voor zowel SSH als HTTP geopend zijn.
- [x] Maak een NSG in je VNET. Zorg ervoor dat je webserver nog steeds bereikbaar is via HTTP, maar dat SSH geblokkeerd wordt.


## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1OtQ_wYxGEuVkk2XZKPJAU1GY6BQS7u8k)
- [Flashcard]()

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Did not had issue doing this task. Here's the step by step guide how I did it:**


Here you may find when my web server is working with SSH and HTTP
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-08-ssh-aan.png)

Created NSG
![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-08-nsg-create.png)

Here we can see that my SSH and HTTP are "allowed"
![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-08-nsg-allow.png)

Using the portal I found where I can adjust the action I want with the SSH
![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-08-ssh-deny.png)

Denied the SSH
![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-08-deny1.png)

![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-08-ssh-portal-off.png)

Here you may see that my Apache default page is still working in HTTP, while connection was timed out in my terminal, where I was trying to access SSH
![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-08-ssh-off.png)

Here's what inside my resource group after completing the task
https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-08-resource.png
