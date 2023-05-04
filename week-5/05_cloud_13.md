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
- [Quickstart: Create and use an Azure file share](https://learn.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-portal?tabs=azure-portal)
- [Explore Azure database and analytics services](https://learn.microsoft.com/en-us/training/modules/azure-database-fundamentals/)
- [Create a SQL database](https://learn.microsoft.com/en-us/training/modules/azure-database-fundamentals/exercise-create-sql-database)
- [Quickstart: Create an Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/instance-create-quickstart?view=azuresql)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ] As cloud engineer, how can I make sure that I optimize all the possible resources and services?

Issue 2: Too expensive to make databases. I was afraid to go over the budget, so i kept playing around the portal, until I found a much more cheaper choice.

![hundred](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-issue2.1.png)
![thousand](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-issue2.png)


## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Azure Files:**

1. Create a storage account. Select the storage account from your dashboard. On the storage account page, in the Data storage section, select File shares. On the menu at the top of the File shares page, select + File share. The New file share page drops down. 

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-fileshare.png)
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-fs-overview.png)

2. I've created a VM using the azure shell, using the scripts below.

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

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-createVM.png)

3. I downloaded the Microsoft Remote Desktop and open the VM. I used the given informations and ip address from the portal. To connect the VM that I made and the fileshare that I manually made, go to Storage Account > File Share > Click the file share created > Connect > copy the script > Open the powershell/CLI from your Microsoft Remote Desktop > Paste the script and press Enter.

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-mremote.png)

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-windows.png)

4. To test if the connection is successful, go back to Azure portal and upload a sample image using the Upload button.

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-upload.png)

5. Go back to Microsoft Remote Desktop and check if the file is there

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-checkuploadVM.png)

6. Try creating a text file from Microsoft Remote Desktop
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-maketxtVM.png)

7. Check if it's at the File Share section of your Azure portal.
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-portalcheck.png)

8. Check and delete the resource group

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-rsc.png)


**Azure Database:**

1. Signed in to the Azure portal.
2. Selected Create a resource > Databases > SQL database. The Create SQL Database pane appears.
3. Click the +Add button and entered the following values for each setting. Also here I used the existing sample data. Selected Review + create to validate configuration entries.

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-create-db.png)
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-create-db1.png)

4. When deployment is complete, select Go to resource. The db1 SQL database Overview pane shows the essentials of the newly deployed database

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-deploying-details.png)
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-db-overview.png)

5. To test the database. In Azure resources menu, select All resources. Search for and select the SQL database resource Type, and ensure that your new database was created. You might need to refresh the page. 

6. Select db1, the SQL database created.
7. 
8. In the SQL database menu, select Query editor (preview). The Query editor (preview) pane appears.

8. A sign in page will appear, signin using your credentials. If you did not enabled your firewall, you might not able to log in.

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-sigin-error.png)

9. To enable the firewall, in the Query editor menu, select Overview (your edits will be lost), and in the command bar, select Set server firewall. The Firewall settings page appears. In the Client IP address section, your IP will be shown (verify that it is the same client IP address from the error you received in the previous step). In the command bar select Add your client IPv4 address. This will add a Rule name that contains your IP address in both the Start IP and End IP fields. Select Save to save this firewall rule.

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-Set-server%20firewall.png)
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-Setserver%20firewall-success.png)

10. To continue testing the database, select your db1 database in the breadcrumb at the top of the page to return to your SQL database, and then select Query editor (preview) from the menu. Sign in again as sqluser, with the password Pa$$w0rd1234. This time you should succeed. It might take a couple of minutes for the new firewall rule to be deployed. If you still get an error, verify the client IP address in the error, and return to Firewall settings to add the correct client IP address.

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-login-success.png)

11. After you sign in successfully, the query pane appears. Enter the following SQL query into the editor pane.
```
SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName
FROM SalesLT.ProductCategory pc
JOIN SalesLT.Product p
ON pc.productcategoryid = p.productcategoryid;
```

![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-dbsample.png)

12. Select Run, and then review the query results in the Results pane. The query should run successfully.


![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-query.png)

13. Check the server, resource group and delete.

![Server](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-sqlserver.png)
![Server](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-sqlserver-db.png)
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-dbrsc.png)
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-5-includes/az-13-delete.png)
