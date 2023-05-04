# Files, AppServices, CDN, DNS, Database

## Bestudeer

**1. App Service**

- Waar is App Service voor? Enables to build and host web apps, mobile back ends, and RESTful APIs in the programming language of choice without managing infrastructure. In another words, it allows to build and run web applications and APIs without having to worry about the underlying infrastructure. It handles things like scaling, load balancing, and security, so the clients can focus on what matters most like developing the app.

- Hoe past App Service / vervangt App Service in een on-premises setting? In an on-premises setting, the team from the client would typically need to manage their own servers and infrastructure to host the web applications. App Service replaces this by providing a fully managed and scalable platform for hosting their apps in the cloud. While having a ready to use dashboard like azure portal to manage it live.

- Hoe kan ik App Service combineren met andere diensten? App Service can be combined with other cloud services like Azure Functions, Azure Storage, and Azure SQL Database to create more complex applications that can handle different types of data and workloads.

- Wat is het verschil tussen App Service en andere gelijksoortige diensten? App Service is similar to other cloud services like AWS Elastic Beanstalk and Google App Engine, but it offers more flexibility and customization options. For example, we can choose to run the apps in a variety of different programming languages, and we can also use custom Docker containers.

- Waar kan ik deze dienst vinden in de console? We can find App Service in the Azure portal by navigating to the "App Services" section.

- Hoe zet ik deze dienst aan? To activate App Service, we need to create a new App Service instance in the Azure portal and configure it with the app code and other settings.

- Hoe kan ik deze dienst koppelen aan andere resources? We can link App Service to other Azure resources like Azure Functions, Azure Storage, and Azure SQL Database by configuring the appropriate connections and settings in app code and in the Azure portal.

**2. Content Delivery Network (CDN)**

- Waar is Content Delivery Network (CDN) voor? A Content Delivery Network (CDN) is a system of distributed servers that helps to deliver web content, such as images and videos, more quickly and efficiently to users around the world. This improves website performance and user experience.

- Hoe past Content Delivery Network (CDN) / vervangt Content Delivery Network (CDN) in een on-premises setting? In an on-premises setting, the team of the client would typically need to manage their own web servers and infrastructure to serve the website content. A CDN replaces this by distributing the content across a network of servers, which can be closer to the users and provide faster delivery.

- Hoe kan ik Content Delivery Network (CDN) combineren met andere diensten? A CDN can be combined with other cloud services like Azure Blob Storage and Azure Media Services to store and deliver different types of content more efficiently.

- Wat is het verschil tussen Content Delivery Network (CDN) en andere gelijksoortige diensten? CDNs are similar to other cloud services like Amazon CloudFront and Google Cloud CDN, but they offer different features and pricing models. For example, some CDNs may offer more global server locations or specialized features for certain types of content.

- Waar kan ik deze dienst vinden in de console? We can find the Azure CDN service in the Azure portal by navigating to the "Content Delivery Network" section.

- Hoe zet ik deze dienst aan? To activate the Azure CDN service, we need to create a new CDN profile and configure it with the content delivery settings and endpoints.

- Hoe kan ik deze dienst koppelen aan andere resources? We can link the Azure CDN service to other Azure resources like Blob Storage or Media Services by configuring the appropriate CDN endpoints and settings in the content delivery code and in the Azure portal.

**3. Azure DNS**

- Waar is Azure DNS voor? Azure DNS is a cloud-based domain name system (DNS) that allows to host the domain names and map them to the IP addresses. This allows users to easily access the web applications and services through the custom domain names.

- Hoe past Azure DNS / vervangt Azure DNS in een on-premises setting? In an on-premises setting, the team of the client would typically need to manage their own DNS servers and infrastructure to map the domain names to IP addresses. Azure DNS replaces this by providing a fully managed and scalable platform for hosting DNS records in the cloud.

- Hoe kan ik Azure DNS combineren met andere diensten? Azure DNS can be combined with other Azure services like App Service, Virtual Machines, and Traffic Manager to manage the DNS records more efficiently and direct traffic to the applications and services.

- Wat is het verschil tussen Azure DNS en andere gelijksoortige diensten? Azure DNS is similar to other cloud-based DNS services like Amazon Route 53 and Google Cloud DNS, but it offers more integration options with other Azure services and can be managed using the same Azure portal and APIs.

- Waar kan ik deze dienst vinden in de console? We can find Azure DNS in the Azure portal by navigating to the "DNS zones" section.

- Hoe zet ik deze dienst aan? To activate Azure DNS, we need to create a new DNS zone in the Azure portal and configure the domain names and DNS records.

- Hoe kan ik deze dienst koppelen aan andere resources? We can link Azure DNS to other Azure resources like App Service or Traffic Manager by configuring the appropriate DNS settings and endpoints in the application code and in the Azure portal.

## Opdrachten

**1. Azure Files**

- Waar is Azure Files voor? Azure Files is a cloud-based file storage service that allows to store and access files from anywhere, using a server message block (SMB) protocol or network file system (NFS) protocol. This allows to easily share files across multiple users and applications.

- Hoe past Azure Files / vervangt Azure Files in een on-premises setting? In an on-premises setting, the team of the client would typically need to manage their own file servers and storage infrastructure to store and access the files. Azure Files replaces this by providing a fully managed and scalable platform for storing and accessing the files in the cloud.

- Hoe kan ik Azure Files combineren met andere diensten? Azure Files can be combined with other Azure services like Azure Virtual Machines, Azure Backup, and Azure Site Recovery to create a comprehensive file storage and backup solution.

- Wat is het verschil tussen Azure Files en andere gelijksoortige diensten? Azure Files is similar to other cloud-based file storage services like Amazon EFS and Google Cloud Filestore, but it offers more integration options with other Azure services and can be managed using the same Azure portal and APIs.

- Waar kan ik deze dienst vinden in de console? We can find Azure Files in the Azure portal by navigating to the "Storage accounts" section and creating a new storage account with the "File storage" option.

- Hoe zet ik deze dienst aan? To activate Azure Files, we need to create a new storage account with the "File storage" option in the Azure portal and configure the file shares and access permissions.

- Hoe kan ik deze dienst koppelen aan andere resources? We can link Azure Files to other Azure resources like Virtual Machines or Azure Backup by configuring the appropriate file share and access settings in the application code and in the Azure portal.

**2. Azure Database (+ managed instance)**

- Waar is Azure Database (+ managed instance) voor? Azure Database is a cloud-based relational database service that allows to create, manage and scale databases on the cloud. Azure Managed Instance is a managed version of SQL Server that provides all the benefits of a fully-managed database service, while offering a near-complete feature parity with on-premises SQL Server.

- Hoe past Azure Database (+ managed instance) / vervangt Azure Database (+ managed instance) in een on-premises setting? In an on-premises setting, the team would typically need to manage their own database servers and infrastructure to store and access the databases. Azure Database and Azure Managed Instance replace this by providing a fully managed and scalable platform for hosting and managing the databases on the cloud.

- Hoe kan ik Azure Database (+ managed instance) combineren met andere diensten? Azure Database and Azure Managed Instance can be integrated with other Azure services like Azure Virtual Machines, Azure Functions, Azure Logic Apps, and Azure App Service to create a comprehensive cloud-based application platform.

- Wat is het verschil tussen Azure Database (+ managed instance) en andere gelijksoortige diensten? Azure Database and Azure Managed Instance are similar to other cloud-based database services like Amazon RDS and Google Cloud SQL, but they offer more integration options with other Azure services and provide more advanced features like Azure Security Center integration, intelligent performance monitoring, and automatic backups.

- Waar kan ik deze dienst vinden in de console? We can find Azure Database and Azure Managed Instance in the Azure portal by navigating to the "Azure SQL" section and creating a new database instance or managed instance.

- Hoe zet ik deze dienst aan? To activate Azure Database or Azure Managed Instance, we need to create a new instance in the Azure portal, specify the database settings like server name, database name, and credentials, and configure access and security settings.

- Hoe kan ik deze dienst koppelen aan andere resources? We can link Azure Database and Azure Managed Instance to other Azure resources like Virtual Machines or App Service by configuring the appropriate connection strings in the application code and in the Azure portal, and by setting up access and security permissions.

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1CSe6Ot_T9tnaY3qcUCGhXI_3_SjTiFDq)
- [Flashcard]()
- [App Service documentation](https://learn.microsoft.com/en-us/azure/app-service/)
- [Intro File Share](https://github.com/MarczakIO/azure4everyone-samples/tree/master/azure-files-introduction)
- [Explore Azure database and analytics services](https://learn.microsoft.com/en-us/training/modules/azure-database-fundamentals/)
- [Create a SQL database](https://learn.microsoft.com/en-us/training/modules/azure-database-fundamentals/exercise-create-sql-database)
- [Quickstart: Create an Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/instance-create-quickstart?view=azuresql)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ]
- [ ]

Issue 2:
Issue 3:
Issue 4:
Issue 5:
Issue 6:

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Azure Files:**
![Label]()

```
group=azure-files-tutorial
name=my-windows-vm
az group create -g $group -l northeurope
password=Adm1nPasSword$RANDOM

az vm create \
  -n $name \
  -g $group \
  -l eastus2 \
  --image Win2019Datacenter \
  --admin-username amdemoadmin \
  --admin-password $password \
  --nsg-rule rdp

az vm show \
  -g $group \
  -n $name \
  -d \
  --query "{name:name,publicIps:publicIps,user:osProfile.adminUsername,password:'$password'}" \
  -o jsonc > clouddrive/$name.json

cat clouddrive/$name.json
```

to connect the VM that I made and the fileshare that I made, I copy pasted on Azure bash shell the script from the portal

**Azure Database:**
![Label]()
