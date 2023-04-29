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

Opdracht 1:

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

Opdracht 2:

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
- [ ]

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Here's the step by step guide how I did it::**
![Label]()
