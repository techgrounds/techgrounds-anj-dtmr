## Decision Documentation

Why did you used this services? Write out your considerations and substantiate your decisions. Assumptions and improvements.

June 5, 2023
Focused on understanding the project description. I don't have any specific to write here now focusing on improvements.

June 6, 2023
Focused on understanding every sentence of the project description. Start brainstorming how I want to plan this project.

June 7, 2023
Today I focused on documentation and planning. I don't have any specific to write here now.

June 8, 2023
Today I focused on learning bicep and IaC. I don't have any specific to write here now.

June 12, 2023
Today I focused on learning further about bicep. Deployed a resource group as I find it logical to do, because I remember when we were using the portal we also first make resource group and assign resources to it.

June 13, 2023
Trial and full of errors days

June 14, 2023
Today I was trying to deploy Azure Vnet to start the virtual network within the resource group I created. I would use it to connect the servers.

June 15, 2023
I'm focusing on my management side today, because I heard from other trainees that it is the logical resources to do first.

June 19, 2023
I wanted to divide the bicep file into management network and web/app network. It was working individually accordingly, but when I was peering them, I could not get to find a way to connect them. At the end I decided to merge the two files into one and create a peering resource for each. It was a success.

June 20, 2023
Today I decided to create my key vault first before the vm's from the 2 servers. This is to ready from the start, a place where I can keep my secrets.

June 21, 2023
Deployed key vault and storage account with container, before deploying the vmss.

June 23, 2023
Today I started with the difficult, deploy a vmss for the web server, since according to my notes the web server needs to be scalable with the best possible price still. But I only keep getting error from the quickstart template from microsoft. I decided to move on to recovery vault, but it seems like there is a problem with the API. So i moved forward with the management server and successfully deployed the cheapest server I could find. I spent the rest of the afternoon trying to understand the requirements for nsg and re-edit my code and successfully deployed it to.

June 26, 2023
The last few weeks is all discovery about my learning process. Today I asked someone to be a one on one buddy on this project, as I'm confident that would have a positive significant impact on how I can perform and give an mvp result for this project. We've talked about from the start, what we understand and NOT understand from the project

June 27, 2023
Yesterday was about key vault, I could not proceed to recovery service fault without it.

June 28, 2023
It is 3 days before the submission, I decided to focus on cleaning up the working code that I have, the resources that can be successfully deployed and the documentation.

June 29, 2023
Yesterday I felt accomplished on having a well documented project. Today I focused on separating my storage accounts for management server, web server and for post deployment scripts. Because according to our dear AI friend:

it's important to note that while you can have multiple VMs in one storage account, it might not be the most optimal configuration for a management server and a web server, especially from a security standpoint. Here's why:

Management Server: A management server typically requires administrative access to manage and control other resources in your Azure environment. Placing your management server and its associated VM in the same storage account as your web server could increase the attack surface. If an attacker gains access to your web server, they may also be able to access the management server files or manipulate the shared storage resources, potentially compromising your management infrastructure.

Web Server: A web server is publicly accessible and can be prone to security vulnerabilities and attacks. Placing it in the same storage account as your management server could expose your management resources to potential attacks targeting your web server. Isolating the web server and its associated VM in a separate storage account provides an additional layer of security, making it more challenging for an attacker to compromise your management infrastructure.

Best practices recommend implementing proper network segmentation and isolation to protect critical resources. It is advisable to separate your management server and web server into separate Azure subscriptions, resource groups, and storage accounts to minimize the impact of a security breach.

By following this approach, you can enhance the security posture of your infrastructure and reduce the potential risks associated with having both the management server and web server in the same storage account.

I'll leave this decision here until the next version's requirements and move on to building the web server today and tomorrow.

I've successfully deployed a web server with a storage account and private container.
