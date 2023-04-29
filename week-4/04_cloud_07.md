# Azure Disk Storage

## Key terminology

- [ ] virtual hard drive in de cloud
- [ ] OS disk (waar het OS op staat)
- [ ] Data Disk (te vergelijken met een externe harde schijf)
- [ ] Unmanaged Disks zijn goedkoper, maar je hebt er wel een Storage Account nodig (en je moet de disk dus zelf managen)
- [ ] Managed Data Disks kunnen gedeeld worden tussen meerdere VMs, maar dat is een relatief nieuwe feature en er zitten wat haken en ogen aan
- [ ] Incremental Snapshots
- [ ] Liminitations of SSD and HDD

## Benodigdheden

- [x] Je Azure Cloud omgeving

## Opdrachten

- [x] Start 2 Linux VMs. Zorgt dat je voor beide toegang hebt via SSH.
- [x] Maak een Azure Managed Disk aan en koppel deze aan beide VMs tegelijk.
- [x] Creëer op je eerste machine een bestand en plaats deze op de Shared Disk.
- [x] Kijk op de tweede machine of je het bestand kan lezen.
- [x] Maak een snapshot van de schijf en probeer hier een nieuwe Disk mee te maken
- [x] Mount deze nieuwe Disk en bekijk het bestand.

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1OtQ_wYxGEuVkk2XZKPJAU1GY6BQS7u8k)
- [Flashcard]()
- [What is Cloud Storage?](https://www.youtube.com/watch?v=O-XBhVv2pgE)
- [Azure Disk Storage](https://www.javatpoint.com/azure-disk-storage)
- [Quickstart: Create a Linux virtual machine in the Azure portal](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal?tabs=ubuntu)
- [Use the portal to attach a data disk to a Linux VM](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal?tabs=ubuntu)
- [Create a snapshot of a virtual hard disk](https://learn.microsoft.com/en-us/azure/virtual-machines/snapshot-copy-managed-disk?tabs=cli)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ] Als je een external device (inclusief een Data Disk) wilt gebruiken op Linux, moet je hem eerst mounten. Hoe ziet het eruit? Waarom?

Issue 2: I must admit, this task took me two to three days to understand. I did not know how a hard drives even works how can I understand cloud? I need to start from researching how it works from a physical infrastracture to using it in a cloud infrastracture. But even after these reading and watching a lot of resources, I could not complete this task without asking the help of my colleagues and peeking to their reports. Thru their simplified explanations, with the point of view of beginners (and I guess challenging them too to use words I better understand), I did the task on my own successfully.

Issue 3: Because of the issue above, and the frustrations of not grasping the concept the way other easily did, I noticed how my focus only last from 9-17, and that was not enough for me to further to complete all the tasks.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Label]()
