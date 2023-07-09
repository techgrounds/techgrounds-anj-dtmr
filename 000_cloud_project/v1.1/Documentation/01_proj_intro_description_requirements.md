# Cloud Project

This file:

- Provide a brief introduction to the project and its purpose.
- Outline the scope and objectives of the project.
- Outline the deliverables and requirements for both versions.
- Explain the benefits of using Bicep for infrastructure provisioning.

## Introduction and Overview

This project is focused on helping a company transition to the cloud by building an Infrastructure as Code (IaC) application.

## Scope and objectives of the project

The project is divided into two phases: v1.0 and v1.1.

In v1.0, the goal is to deliver the IaC application and all the required documentation based on the existing architecture and requirements. The application should include features such as encrypted VM disks, daily backups of the web server, automated installation of the web server, accessibility of the admin/management server through a public IP, restricted access to the admin/management server from trusted locations, protection of subnets with firewalls, and restricted SSH or RDP connections to the web server from the admin server. The application should be developed using Azure Bicep.

While in v1.1, additional requirements for the web server should be implemented.

I've combined the user stories for v1.0 and v1.1 that you may check below.

During the project, we worked individually on our own elaborations but in teams. Each member worked on the same user stories, and collaboration and knowledge sharing among teams are encouraged. There were sprint reviews and retrospectives at the end of each sprint to discuss progress, improvements, and any challenges faced.

Overall, the project aims to apply and expand knowledge of cloud technologies, automation, and infrastructure deployment, while working in a team environment, talking with a product owner and delivering a functional and well-documented solution for the company's cloud transition.

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

## User Stories

### v1.0

1. As a team, we want to be clear what the requirements of the application are.

   - Epic: Exploration
   - Description: You've already gotten a lot of information. There are some requirements already listed in this document, but this list may be incomplete or unclear. It's important to have all the ambiguities sorted out before you do any major work.
   - Deliverable: A point-by-point description of all requirements

2. As a team, we want a clear record of the assumptions we have made.

   - Epic: Exploration
   - Description: You've already gotten a lot of information. There may be questions that none of the stakeholders were able to answer. Your team should be able to produce an overview of the assumptions you make as a result.
   - Deliverable: A point-by-point overview of all assumptions

3. As a team, we want to have a clear overview of the Cloud Infrastructure the application needs.

   - Epic: Exploration
   - Description: You've already gotten a lot of information. And already a design. Only missing from the design are things like IAM/AD. Identify these additional services that you will need and list all of them.
   - Deliverable: An overview of all the services that will be used.

4. As a customer, I want to have a working application that allows me to deploy a secure network.

   - Epic: v1.0
   - Description: The application must build a network that meets all requirements. An example of a stated requirement is that only traffic from trusted sources may access the management server.
   - Deliverable: IaC code for the network and all components

5. As a client, I want to have a working application with which to deploy a working web server.

   - Epic: v1.0
   - Description: The application must start a Web server and make it available to general audiences.
   - Deliverable: IaC code for the web server and all supplies

6. As a customer, I want to have a working application with which to deploy a working management server.

   - Epic: v1.0
   - Description: The application should start a management server and make it available to a limited audience.
   - Deliverable: IaC code for a management server with all supplies

7. As a client, I want to have a storage solution in which bootstrap/post-deployment scripts can be stored.

   - Epic: v1.0
   - Description: There must be a location where bootstrap scripts become available. These scripts should not be publicly accessible.
   - Deliverable: IaC code for a script storage solution

8. As a customer, I want all my data in the infrastructure to be encrypted.

   - Epic: v1.0
   - Description: Great importance is attached to the security of data at rest and in motion. All data must be encrypted.
   - Deliverable: IaC code for encryption facilities

9. As a customer, I want to have a backup every day that is maintained for 7 days.

   - Epic: v1.0
   - Description: The client would like a backup to be available, should it be necessary to return the servers to a previous state. (Make sure the Backup actually works)
   - Deliverable: IaC code for backup facilities

10. As a customer, I want to know how to use the application.

    - Epic: v1.0
    - Description: Make sure the customer can understand how to use the application. Make sure it is clear what the client must configure before the deployment can start and what arguments the program requires.
    - Deliverable: Documentation for using the application

11. As a customer, I want to be able to deploy an MVP for testing.
    - Epic: v1.0
    - Description: The client itself wants to test your architecture internally before they start using the code in production. Ensure that configuration is available that allows the customer to deploy an MVP.
    - Deliverable: Configuration for an MVP deployment

### v1.1

1. As a customer, I want the web server to be protected by a proxy so that it is not directly accessible on the internet without any intervention.

2. As a customer, I want the web server to no longer have a public IP address to enhance security and minimize exposure to potential threats.

3. As a user, when I connect to the load balancer via HTTP, I want the connection to be automatically upgraded to HTTPS for a more secure communication.

4. As a customer, I want the connection between the client and the server to be secured with at least TLS 1.2 or higher to ensure data integrity and confidentiality.

5. As an administrator, I want the web server to undergo regular health checks to ensure its availability and performance.

6. As an administrator, if the web server fails the health check, I want it to be automatically restored to maintain uninterrupted service.

7. As a customer, if the web server experiences continuous high load, I want a temporary additional server to be started to handle the increased traffic efficiently.

8. As a customer, I expect that no more than three servers will be needed at any given time based on past user activity levels.

9. As a development team, we acknowledge that using a self-signed certificate is acceptable for establishing an HTTPS connection, even though it may trigger a browser warning.

Note: Since we don't want to purchase a domain name for everyone, it is difficult to establish an HTTPS connection in the correct way. You may use a self-signed certificate for this purpose. However, you will receive a warning in your browser, but the connection will still be encrypted.

10. As a development team, we will update the architectural drawing to reflect the changes in the infrastructure design.

11. As a development team, we will document and substantiate the new services used in the design document for version 1.1.

12. As a development team, we will provide an MVP of version 1.1 of the application that includes the implemented security and cloud-related enhancements.

13. As a development team, we will maintain a day log to record our findings and progress throughout the project.

14. As a development team, we will conduct intermediate presentations to showcase our progress and receive feedback.

15. As a development team, we will deliver a final presentation to summarize the implemented changes, demonstrate the MVP, and discuss the future direction of the project.

## What is Bicep and its usage benefits

Bicep is:

- a Domain-Specific Language (DSL) meaning it is a programming language or syntax specifically designed to address a particular domain or problem space, in Bicep's case is for Azure resources.
- a declarative syntax for defining meaning it describe what should be accomplished rather than specifying how it should be done.

It offers several benefits for infrastructure provisioning compared to traditional methods like ARM templates or manual configuration:

1. Abstraction and Simplification: Bicep provides a higher-level, declarative language that simplifies the provisioning of infrastructure. It abstracts away the complexities of writing low-level ARM templates, allowing engineers to focus on the desired end state rather than the implementation details.

2. Consistency and Reusability: Bicep promotes code reuse by allowing engineers to define reusable modules, similar to using standardized building blocks in construction. This enables consistent provisioning across multiple environments or projects and reduces duplication of effort.

3. Scalability and Maintainability: With Bicep, engineers can easily scale infrastructure by defining resources as code. Adding or modifying resources becomes as straightforward as updating the blueprint. This approach also makes it easier to maintain and track changes over time, improving collaboration and reducing the risk of configuration drift.

4. Readability and Understandability: Bicep's syntax is more concise and readable compared to raw ARM templates. It uses familiar programming constructs, making it easier for both developers and infrastructure engineers to understand and contribute to the codebase. The code acts as a clear documentation of the infrastructure design.

5. Integration with Azure Ecosystem: Bicep is specifically designed for provisioning Azure resources and seamlessly integrates with the Azure ecosystem. It leverages the Azure Resource Manager (ARM) APIs and supports all Azure resource types and features, ensuring compatibility and access to the latest Azure capabilities.

6. Tooling and Ecosystem Support: Bicep benefits from a growing ecosystem of tools, extensions, and community support. It has its own command-line interface (CLI) for compiling and deploying Bicep files. Additionally, it can be integrated into existing DevOps pipelines and works well with Azure DevOps, Azure CLI, and other popular CI/CD tools.
