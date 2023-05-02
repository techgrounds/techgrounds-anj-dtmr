# Azure Load Balancer (ALB) & Auto Scaling

## Key terminology

- [ ] Autoscaling
- [ ] spiky workload
- [ ] VM Scale Set
- [ ] Azure Monitor
- [ ] load balancer

## Benodigdheden

- [x] Je Azure Cloud omgeving

## Opdrachten

### Opdracht 1:

● Maak een Virtual Machine Scale Set met de volgende vereisten:
○ Ubuntu Server 20.04 LTS - Gen1
○ Size: Standard_B1ls
○ Allowed inbound ports:
■ SSH (22)

■ HTTP (80)
○ OS Disk type: Standard SSD
○ Networking: defaults
○ Boot diagnostics zijn niet nodig
○ Custom data:

```
#!/bin/bash
sudo su
apt update
apt install apache2 -y
ufw allow 'Apache'
systemctl enable apache2
systemctl restart apache2
```

○ Initial Instance Count: 2
○ Scaling Policy: Custom
■ Aantal VMs: minimaal 1 en maximaal 4
○ Voeg een VM toe bij 75% CPU gebruik
○ Verwijder een VM bij 30% CPU gebruik

### Opdracht 2:

● Controleer of je via het endpoint van je load balancer bij de webserver kan komen.
● Voer een load test uit op je server(s) om auto scaling the activeren. Er kan een delay zitten in het creëren van nieuwe VMs, afhankelijk van de settings in je VM Scale Set.

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1CSe6Ot_T9tnaY3qcUCGhXI_3_SjTiFDq)
- [Flashcard](https://quizlet.com/642919545/az-104-improve-application-scalability-and-resiliency-by-using-azure-load-balancer-flash-cards/)
- [Use custom scale-in policies with Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-scale-in-policy)
- [CPU Usage Definition](https://www.solarwinds.com/resources/it-glossary/what-is-cpu#:~:text=CPU%20utilization%20indicates%20the%20amount,various%20programs%20on%20a%20computer.)
- [What Is CPU In The Cloud?](https://blogs.vmware.com/cloudhealth/what-is-cpu/)
- [Quickstart: Create and run a load test with Azure Load Testing](https://learn.microsoft.com/en-us/azure/load-testing/quickstart-create-and-run-load-test)
- [Tutorial: Create a Virtual Machine Scale Set and deploy a highly available app on Linux](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-create-vmss)
- [Orchestration modes for Virtual Machine Scale Sets in Azure](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes)
- [Create azure virtual machine scale set](https://www.youtube.com/watch?v=Y_STYgRQyAE)
- [What are Virtual Machine Scale Sets?](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview)
- [Azure Load Balancer Tutorial](https://www.youtube.com/watch?v=T7XU6Lz8lJw)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ] What are the difference between VMSS and Availability Set
- [ ] zijn de networking default settings incompatible met de opdracht? Je hebt geen load balancer met defaults. Alleen een NIC en geen SSH / http

Issue 2: The first day, I could not find the way I could add http port while I was creating the VMSS. I took enough sleep and ready myself for another day. Please check below how I run through this task smoothly after a good night of sleep.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Here's the step by step guide how I did it::**

**Description:**
![Label]()
