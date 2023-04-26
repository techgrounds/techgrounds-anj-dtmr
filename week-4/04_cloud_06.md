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

![Create](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-createVM.png)
![Review](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-reviewVM.png)
![Private key](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-privekey.png)
![Overview](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-overview.png)
![Activity Log](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-activitylog.png)
![Properties](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-properties.png)


- [x] Controleer of je server werkt.

![Connect](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-connect.png)
![Login](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-loginssh.png)
![chmod](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-chmod.png)
![Commands](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-VMcommands.png)
![Networks](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-network.png)
![Monitoring](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-VMmonitoring.png)


- [x] Let op! Vergeet na de opdracht niet alles weer weg te gooien. Je kan elk onderdeel individueel verwijderen, of je kan in 1 keer de resource group verwijderen.

![Stopping](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-stopping.png)
![Deleting](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-deleting.png)
![Deleted](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-4-includes/az-06-deleted.png)

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
