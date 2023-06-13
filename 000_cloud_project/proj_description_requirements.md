# Cloud Project

## What this project is all about?

This project is focused on helping a company transition to the cloud by building an Infrastructure as Code (IaC) application. The project is divided into two phases: v1.0 and v1.1.

In v1.0, the goal is to deliver the IaC application and all the required documentation based on the existing architecture and requirements. The application should include features such as encrypted VM disks, daily backups of the web server, automated installation of the web server, accessibility of the admin/management server through a public IP, restricted access to the admin/management server from trusted locations, protection of subnets with firewalls, and restricted SSH or RDP connections to the web server from the admin server. The application should be developed using Azure Bicep.

During the project, we worked individually on our own elaborations but in teams. Each member worked on the same user stories, and collaboration and knowledge sharing among teams are encouraged. There were sprint reviews and retrospectives at the end of each sprint to discuss progress, improvements, and any challenges faced.

Overall, the project aims to apply and expand knowledge of cloud technologies, automation, and infrastructure deployment, while working in a team environment and delivering a functional and well-documented solution for the company's cloud transition.

## Deliverables:

The following deliverables are expected in your GitHub repository at the end of this project:

- A working CDK / Bicep app from the MVP
- Design Documentation
- Decision Documentation
- Time logs
- Final presentation

## Requirements

- All VM disks must be encrypted.
- The Web server should be backed up daily. Backups must be retained for 7 days.
- The Web server must be installed in an automated manner.
- The admin/management server must be reachable by a public IP.
- The admin/management server should be accessible only from trusted locations (office/admin's home)
- The following IP ranges are used: 10.10.10.0/24 & 10.20.20.0/24
- All subnets must be protected by a firewall at the subnet level.
- SSH or RDP connections to the Web server should only be established from the admin server.
- Don't be afraid to suggest or implement improvements in the architecture, but make hard choices so you can meet the deadline.
