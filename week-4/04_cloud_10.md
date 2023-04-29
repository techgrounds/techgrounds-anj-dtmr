# Subject

## Key terminology

- [ ] Azure virtual networks (VNets)
- [ ] Point-to-site VPNs
- [ ] Site-to-site VPNs
- [ ] Azure Expressroute
- [ ] user-defined Routing (UDR)

## Benodigdheden

- [x] Je Azure Cloud omgeving

## Opdrachten

###Opdracht 1:

- [x] Maak een Virtual Network met de volgende vereisten:
      Region: West Europe
      Name: Lab-VNet
      IP range: 10.0.0.0/16
- [x] Vereisten voor subnet 1:
      Name: Subnet-1
      IP Range: 10.0.0.0/24
      Dit subnet mag geen route naar het internet hebben
- [x] Vereisten voor subnet 2:
      Name: Subnet-2
      IP Range: 10.0.1.0/24

###Opdracht 2:

- [x] Maak een VM met de volgende vereisten: Een apache server moet met de volgende custom data geïnstalleerd worden:

```
#!/bin/bash
sudo su
apt update
apt install apache2 -y
ufw allow 'Apache'
systemctl enable apache2
systemctl restart apache2
```

Er is geen SSH access nodig, wel HTTP
Subnet: Subnet-2
Public IP: Enabled

- [x] Controleer of je website bereikbaar is

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1OtQ_wYxGEuVkk2XZKPJAU1GY6BQS7u8k)
- [Flashcard]()

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ] 

[Issue 2:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-issue2.1.png) I could not create a new ip address space because of the conflict. I deleted the NetworkWatcher and repeat the process

[Issue 3:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-issue3.2.png) Even after deleting this NetworkWatcher I still got the error. I played around the portal and found out that I need to delete the default ip address.



## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Here's the step by step guide how I did it::**


First I created a Virtual Network following the requirements above with 2 subnets.
![VN](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-issue2.png)

I created a VM following the requirements above. With the subnet 2 that should have internet connection
![Create](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-vm.png)

With the subnet 2 that should have internet connection
![overview](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-vm-overview.png)
![VM](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-vm-sub2.png)
![net](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-vmnetwork.png)

From this, I could call the public IP Address given to open a apache default page. This is working properly
![apache](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-result-before.png)

To dive deeper onto this task, I tried the process what I learned from the Q&A. I created a route table for my subnet-2 (with internet connection)
![rtable](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-sub2-rtable.png)
![rtable](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-sub2-rtable%20copy.png)
![rtable](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-route-table.png)

Check the effective routes after I made the step above.
![routes](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-0000.png)

As a result of that I could not reach my apache default page anymore
![result](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-result-after.png)

Here's the glimpse of resource group after completing the task
![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-rscgrp.png)

Deleted
![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-10-deleting.png)


