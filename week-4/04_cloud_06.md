# Azure Virtual Machines

## Key terminology

- [ ] Instance
- [ ] Remote Desktop Protocol (RDP)
- [ ] Custom Data
- [ ] cloud-init script
- [ ] Reserved Instances
- [ ] Spot Instances
- [ ] Premium disk support
- [ ] OS disk: Premium SSD, Standard SSD en Standard HDD
- [ ] NIC network security group
- [ ] Azure VM Components:
- OS
- Virtual Hard Disks
- Virtual Networks
- Availability Sets

## Benodigdheden

- [x] Je Azure-cloud omgeving

## Opdrachten

- [x] Log in bij je Azure Console.
- [x] Maak een VM met de volgende vereisten:
      Ubuntu Server 20.04 LTS - Gen1
      Size: Standard_B1ls
      Allowed inbound ports:
      HTTP (80)
      SSH (22)
      OS Disk type: Standard SSD
      Networking: defaults
      Boot diagnostics zijn niet nodig
      Custom data:

```
#!/bin/bash
sudo su
apt update
apt install apache2 -y
ufw allow 'Apache'
systemctl enable apache2
systemctl restart apache2
```

- [x] Controleer of je server werkt.
- [x] Let op! Vergeet na de opdracht niet alles weer weg te gooien. Je kan elk onderdeel individueel verwijderen, of je kan in 1 keer de resource group verwijderen.

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1dMGzHTd2HhMeAN-G6LSTn9Zrn_XI8Vgu)
- [Creating A Virtual Machine In Azure](https://www.youtube.com/watch?v=QOv_-xBXkpo&pp=ygUgY3JlYXRlIGF6dXJlIHZpcnR1YWwgbWFjaGluZSBtYWM%3D)
- [How to Create an Azure Virtual Machine](https://www.youtube.com/watch?v=1GwTtvxNMbA)
- [Flashcards - Microsoft Azure Virtual Machines](https://quizlet.com/714874752/microsoft-azure-virtual-machines-flash-cards/)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ] Het wordt aangeraden om network security groups te configureren op subnet niveau (en dus niet op instance niveau) waar mogelijk, maar soms heb je een allow/deny rule nodig op een specifieke instance, dus de optie is er
- [ ] User data is een nieuwe versie van Custom data. Het grootste verschil is dat user data beschikbaar blijft gedurende de hele levensduur van de VM

Issue 2:
Issue 3:
Issue 4:
Issue 5:
Issue 6:

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Label]()
