# Networking case study

Steps I took to solve this task:

1. What is Network Administrator? What is their normal roles in a company?

Network Administrator is responsible for installing, maintaining and upgrading any software or hardware required to efficiently run a computer network.0 They oversee the information technology within an organization, serving as the go-to people for major computer or technical issues. In charge of the wired and wireless networks in an organization, including the necessary hardware and software. System administrators manage the installation of hardware and software for the entire organization, including any servers, and ordering hardware for the organization.

2. What is the role of a network administrator setting up a network in the new office of a small e-commerce company?

![Role of NA](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-07-role.png)

3. Requirement analysis

- new office means new networking of a small e-commerce company
- network security is **extremely** important
- office contains:
  ● A web server where our webshop is hosted
  ● A database with login credentials for users on the webshop
  ● 5 workstations for the office workers
  ● A printer
  ● An Active Directory (AD) Server
  ● A file server containing internal documents
- As a network administrator you get to choose which networking devices get used.

4. Prioritize and separate my network devices into internal and external networks.

## Key terminology

- [ ] Firewall
- [ ] Database Server
- [ ] DMZ (Demilitarized Zone) network
- [ ] Active Directory (AD) Server
- [ ] File Server
- [ ] Firewall

## Benodigdheden

- [x] https://app.diagrams.net/

## Opdrachten

- [x] Design a network architecture for the above use case.
- [x] Explain your design decisions

Security is extremely important for this company, so I research how can network be protected, what kind of devices/software used in the current time. In this case, we can use firewall. I separated the network base of which of the devices are for WAN and LAN. I found out that I can use DMZ to protect both of my internal and external networks. So that even though an attacker could reach my external network, I have another protection, it wont easily reach and affect the internal network.

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1ngTMmDk8hX61yQQGFieqFLswh6UdoEGO)
- [DMZ](https://www.youtube.com/watch?v=dqlzQXo1wqo)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: I have to be honest, drawing network architecture is the most challenging so far. What I did is read the challenges of the trainees, what kind of new terminologies are there. Aside from reading, watching a Youtube video that uses animation to visualize how networking really helps.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Get to understand more of networking:**
![result](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-07-result.png)
