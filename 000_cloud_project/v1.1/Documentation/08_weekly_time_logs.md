# Weekly Time Logs

Check [v1.0 time logs](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.0/Documentation/08_weekly_time_logs.md) for the first weeks.

# WEEK 4

July 3, 2023 Monday

### Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- gelezen de pdf, gaat meer over de web server en health check
- de v1.0 en v1.1 requirements vergelijken maar ook niets veel gaan veranderen
- ik heb user stories geschreven
- Planning voor mezelf geschreven
- over key terminologies (proxy en self-signed certificate) gelezen/gekeken
- advies vragen: zal ik eerst een main.bicep maken met module of verder met web server vmss + application gateway/key vault & disk encryption verder of module. Can I let you see the things that I did for the v1.0 and my planning to take for v1.1

### Obstakels & Oplossingen

1. {"status":"Failed","error":{"code":"DeploymentFailed","target":"/subscriptions/087b5dd7-9fd5-472a-bf25-7e63675fb8e2/resourceGroups/TestRGcloud_project/providers/Microsoft.Resources/deployments/main","message":"At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.","details":[{"code":"ResourceDeploymentFailure","target":"/subscriptions/087b5dd7-9fd5-472a-bf25-7e63675fb8e2/resourceGroups/TestRGcloud_project/providers/Microsoft.Resources/deployments/mysqlDB","message":"The resource write operation failed to complete successfully, because it reached terminal provisioning state 'Failed'.","details":[{"code":"DeploymentFailed","target":"/subscriptions/087b5dd7-9fd5-472a-bf25-7e63675fb8e2/resourceGroups/TestRGcloud_project/providers/Microsoft.Resources/deployments/mysqlDB","message":"At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.","details":[{"code":"MissingRegistrationForLocation","message":"The subscription is not registered for the resource type 'privateDnsZones' in the location 'westeurope'. Please re-register for this provider in order to have access to this location."}]}]}]}}

To register a resource provider in Azure using Azure CLI in Visual Studio Code (VSCode), you can follow these steps:

1. Open VSCode and ensure you have the Azure CLI extension installed. You can search for "Azure CLI" in the extensions marketplace and install it if needed.

2. Open the integrated terminal in VSCode by going to `View` → `Terminal` or using the keyboard shortcut `Ctrl+` backtick `(`Ctrl+``).

3. Sign in to Azure CLI by running the following command in the terminal:

   ```bash
   az login
   ```

   This command will open a browser window prompting you to log in with your Azure account. Follow the instructions to complete the login process.

4. After successfully logging in, set the subscription you want to work with by running the following command:

   ```bash
   az account set --subscription <subscription_id>
   ```

   Replace `<subscription_id>` with the ID of your desired subscription. You can get the list of available subscriptions by running `az account list`.

5. To register the resource provider for 'privateDnsZones', run the following command:

   ```bash
   az provider register --namespace Microsoft.Network --wait
   ```

   This command registers the 'privateDnsZones' resource provider under the 'Microsoft.Network' namespace. The `--wait` flag will make the CLI command wait until the registration process is completed.

   Note: Depending on your account permissions, you might require elevated access or administrator privileges to register resource providers. If you encounter any permission issues, contact your Azure administrator.

6. Once the registration is complete, you should receive a message indicating the success of the registration process.

After following these steps, you should be able to deploy resources that depend on the 'privateDnsZones' resource provider in the 'westeurope' location without encountering the "MissingRegistrationForLocation" error.

2.
3. Asking better questions

- [ ] Why we don't need a public IP on web server anymore? Proxy use than public IP
- [ ] Health check, vanaf de load balancer or gateway - gateway functioneer als load balancer dan in load balancer een health check configureren
- [ ] SLA bepaalde uptime
- [ ] web application firewall, azure ad proxy
- [ ] er is HTTP maar automatisch naar HTTPS
- [ ] listener is ook een poort
- [ ] Moet van de traffic van gateway encrypted zijn? hoef niet per se verseuteld te zijn
- [ ] web to management - ssh (intern verbinding)
- [ ] web server public ip niet meer nodig
- [ ] load balancer vervangen naar app gateway

- [ ] Een vraag over deze zin "You may not have finished everything yet and that's okay. In this case, you would indicate to your manager that you need more time and discuss this with the client. Since this is still a simulation, this is not necessary." In de echte werk omgeving, hoe ga je dat met je manager bespreken? Without feeling incompetent because of not reaching the deadline. Ben benieuwd hoe het is in Nederland. Thanks.

- [ ] why does a customer need proxy

There are several reasons why an organization might choose to implement a proxy server in their infrastructure. Here are some common reasons:

1. Security: A proxy server can act as a security barrier between the internet and the internal network. It can help protect the web server from direct exposure to potential threats, such as malicious traffic, unauthorized access attempts, and DDoS attacks. By intercepting and inspecting incoming requests, the proxy server can filter out potentially harmful traffic, block suspicious IP addresses, and provide an additional layer of security.

2. Anonymity and Privacy: By using a proxy server, clients can hide their real IP addresses and route their internet traffic through the proxy. This can help protect their privacy and prevent websites from tracking their online activities. The proxy server acts as an intermediary, making requests on behalf of the client and returning the responses. It can also help bypass censorship or access content that may be restricted based on geographical location.

3. Load Balancing: A proxy server can distribute incoming traffic across multiple web servers to balance the load and ensure optimal resource utilization. By using load balancing algorithms, the proxy server can route requests to the least busy or most available server, thereby improving overall performance and handling increased traffic.

4. Caching: A proxy server can cache frequently accessed web content and serve it to clients without forwarding requests to the web server. This reduces the response time and network bandwidth required for subsequent requests, resulting in faster and more efficient delivery of web content.

5. Content Filtering: Proxy servers can be configured to filter or restrict certain types of content based on predefined rules. This can be useful in organizations or educational institutions to enforce internet usage policies, block access to malicious websites, or prevent the download of unauthorized files.

6. Protocol Translation: In some cases, a proxy server can translate requests and responses between different protocols or communication standards. This can be useful when there is a need to bridge communication between clients and servers that use different protocols or versions of protocols.

- [ ] is application gateway enough for proxy for an azure iac bicep project?

Yes, the Azure Application Gateway can be a suitable option for implementing a proxy server in an Azure infrastructure as code (Bicep) project. The Application Gateway is a layer 7 load balancer that provides various features, including proxy functionality, to enhance the security and performance of web applications.

Here's how the Application Gateway can fulfill the requirements mentioned in your project:

1. Proxy Functionality: The Application Gateway acts as a reverse proxy, receiving incoming requests from clients and forwarding them to the appropriate backend servers (web servers). It can perform SSL termination, URL-based routing, session affinity, and other proxy-related functions.

2. HTTPS and TLS: The Application Gateway supports terminating SSL/TLS connections, enabling you to configure HTTPS endpoints for client connections. You can upload a self-signed certificate to the Application Gateway, as mentioned in your project, to establish an encrypted connection. Note that while this provides encryption, the self-signed certificate may generate a browser warning due to the lack of trust from a recognized certificate authority.

3. Load Balancing: The Application Gateway provides load balancing capabilities to distribute traffic across multiple backend servers. It supports different load balancing algorithms and can be configured to evenly distribute requests among the available web servers. This helps ensure scalability and high availability.

4. Health Checks: The Application Gateway can perform health checks on the backend servers (web servers) by periodically sending requests and evaluating their responses. If a server fails the health check, the Application Gateway can automatically stop forwarding traffic to that server, ensuring that only healthy servers receive requests.

5. Auto Scaling: While the Application Gateway itself does not provide auto scaling for backend servers, it can integrate with Azure services like Azure Virtual Machine Scale Sets or Azure Kubernetes Service (AKS) to achieve auto scaling. These services allow you to automatically increase the number of backend servers based on defined criteria, such as CPU usage or request count.

6. Security: The Application Gateway includes various security features, such as Web Application Firewall (WAF), to protect against common web vulnerabilities and attacks. It can inspect and filter incoming requests, block malicious traffic, and provide additional security measures to safeguard your web applications.

By leveraging the capabilities of the Azure Application Gateway, you can meet the proxy requirements specified in your project while benefiting from its additional features for load balancing, scalability, and security.

- [ ] are azure load balance and azure auto scaling the same?
      Azure Load Balancer and Azure Auto Scaling are not the same. Azure Load Balancer is a Layer 4 (TCP, UDP) load balancer that distributes incoming traffic among healthy instances of services defined in a load-balanced set. It can be used for both inbound and outbound scenarios. On the other hand, Azure Auto Scaling is a service that automatically scales resources up or down based on demand or a schedule. It can be used to scale Virtual Machine Scale Sets

### Learnings

- [ ] Self-signed certificates are usually used for testing environment

### Plans for tomorrow

1. Tomorrow I would like to ask question to the learning coach and my team mates on how to proceed smartly. morgen wil ik over vmss beginnen of module??????

---

July 4, 2023 Tuesday

### Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

Important things I've learned from the last year trasitioning to tech are:

1. Make the code works
2. Follow the best practice (DRY, split your code into smaller, more manageable files)

From v1.0 I did made my code work, learned the syntax, deployment process, understood the infrastracture better than the beginning (like SSH is for internal connections to be secured).

Today I will use Bicep module to follow the best practices. I might be late than my other team, but how would I know better. I'm here to act and learn as I go.

Update: I successfully deployed all management resources using module!!!
Another update: I successfully deployed a sql db

### Obstakels & Oplossingen

1. At first I thought I need to create all param in main.bicep from all the output I've created from the resources, like the blob endpoint. But all I need is find the right path from the (dot)outputs.

2. Under the storage bicep file, there is a container. I thought I should create another module for container. The easy and correct way is to call it under the params
3. Asking better questions

- [ ] How shall I confirm if my sql db is connected to the management server and web server?
- [ ] What are the dependencis of a database?

### Learnings

- [ ] How to use module, outputs, params

- [ ] Today I've learned that a database need a database server, virtual network and firewall rules and key vault.

The dependencies of an Azure SQL Database resource in Bicep:

Azure SQL Server: Typically, an Azure SQL Database is created under an Azure SQL Server. The SQL Server provides the logical container for multiple databases. Therefore, you may need to create the Azure SQL Server resource first and ensure it is provisioned before creating the Azure SQL Database.

Virtual Network and Firewall Rules: If you want to restrict access to your Azure SQL Database to specific networks or IP addresses, you may need to configure the virtual network and firewall rules. In this case, the virtual network and associated firewall rules should be created before creating the Azure SQL Database.

Azure Key Vault: If you plan to store sensitive information, such as connection strings or credentials, securely, you can leverage Azure Key Vault. You may need to create an Azure Key Vault and configure it to store and manage the secrets required for the Azure SQL Database. In this case, the Azure Key Vault should be provisioned and configured before creating the Azure SQL Database.

### Plans for tomorrow

- [ ] apache
- [ ] Continue with key vault
- [ ] Data encryption
- [ ] Write down documentataion on management.bicep and web/app.bicep
- [ ] Miro planning
- [ ] VMSS for webserver
- [ ] Recovery service vault
- [ ] Database

---

July 5, 2023 Wednesday

### Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- [ ] Made modules for the web network
- [ ] Successfuly deployed a db server and database
- [ ] Connect web server and management server using private endpoint

---- na de q&a ga ortho rond 2 tot 4

### Obstakels & Oplossingen

1. The Storage Container was failing when I was trying to deploy the main.bicep. I uncomment it for now, because the management server does need a storage account but not the container.

2. Using the module, output, param the correct way. Read the error and troubleshoot. Make one change, then test.

3. Asking better questions

- [ ] How can I check if the db is really connected with the server? Open the web server using ssh or rdp then ping the ip address/server name in the command prompt.
- [ ] How to start with v1.1? VMSS or application gateway?

### Learnings

- [ ] Virtual Network Rule for db can only be connected with one vnet, while endpoints can be connected with multiple vnets
- [ ] How to open the management server using Microsoft Remote Desktop, use powershell and use ping command from there.

### Plans for tomorrow

- [ ] apache
- [ ] Continue with key vault
- [ ] Data encryption
- [ ] Write down documentataion on management.bicep and web/app.bicep
- [ ] Miro planning
- [ ] VMSS for webserver
- [ ] Recovery service vault
- [ ] Database

---

July 6, 2023 Thursday

### Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- [ ] Not so much productive today, I deployed the quickstart for application gateway, to play around with it using the portal.

### Obstakels & Oplossingen

1. Today, I did not found any good resources to understand application gateway. I will continue with that tomorrow.

2.
3. Asking better questions

- [ ] are Virtual Network rule and private endpoint rule the same? if no what are their difference?
- [ ]

### Learnings

- [ ] ping is another protocol

### Plans for tomorrow

- [ ] apache
- [ ] Continue with key vault
- [ ] Data encryption
- [ ] Write down documentataion on management.bicep and web/app.bicep
- [ ] Miro planning
- [ ] VMSS for webserver
- [ ] Recovery service vault
- [ ] Database

---

July 7, 2023 Friday

### Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- Prepared for the presentation
- Understood why I need backend pool subnet for.
- Errors. Errors. Errors.

### Obstakels & Oplossingen

1. This error meant that the IDs paths are not correct. I've learned that when you use 'id: resourceId()' then I need to use the 'NAME' of the resource and not the 'ID'.

`bash
"details": [
{
"code": "ResourceDeploymentFailure",
"target": "/subscriptions/087b5dd7-9fd5-472a-bf25-7e63675fb8e2/resourceGroups/v1test/providers/Microsoft.Resources/deployments/webapp-nic",
"message": "The resource write operation failed to complete successfully because it reached terminal provisioning state 'Failed'.",
"details": [
{
"code": "DeploymentFailed",
"target": "/subscriptions/087b5dd7-9fd5-472a-bf25-7e63675fb8e2/resourceGroups/v1test/providers/Microsoft.Resources/deployments/webapp-nic",
"message": "At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.",
"details": [
{
"code": "ResourceNotFound",
"message": "The Resource 'Microsoft.Network/publicIPAddresses/webapp-public-ip' under resource group 'v1test' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix"
}
]
}
]
}
]

`

2.
3. Asking better questions

- [ ]
- [ ]

### Learnings

- [ ] azure sql database should not connect via the internet then management server. what should i do to private ip address

If you want to connect to an Azure SQL Database using a private IP address instead of connecting via the internet, you can follow these steps:

1. Virtual Network (VNet): Create a Virtual Network in Azure or use an existing one where your Azure SQL Database and management server can reside. This VNet will provide a private network environment.

2. Subnet: Within the Virtual Network, create a subnet dedicated to the Azure SQL Database and another subnet for the management server.

3. Azure SQL Database: Configure the Azure SQL Database to use the VNet integration feature. This feature allows you to associate the Azure SQL Database with a subnet within the Virtual Network.

4. Private Endpoint: Set up a private endpoint for the Azure SQL Database. A private endpoint enables private access to the database using the private IP address within the Virtual Network. The private endpoint will be associated with the subnet created for the Azure SQL Database.

5. Network Security Group (NSG): Create and configure Network Security Groups for both subnets. NSGs allow you to define inbound and outbound rules to control network traffic. Configure the NSG for the subnet containing the Azure SQL Database to allow necessary traffic, such as SQL traffic on port 1433, between the management server and the database subnet.

6. Private DNS Zone: If you want to use a custom domain name to access the Azure SQL Database internally, you can create a private DNS zone within the Virtual Network. Associate the private DNS zone with the Azure SQL Database and configure the necessary DNS records.

7. Management Server Configuration: Configure the management server to use the same Virtual Network and subnet as the Azure SQL Database. This will allow the management server to have a private IP address within the same network environment.

8. Connect using the private IP address: Update the connection string or configuration of your application or client to use the private IP address of the Azure SQL Database instead of the public endpoint or server name.

By following these steps, you can establish a private connection between the management server and the Azure SQL Database using their respective private IP addresses within the Virtual Network. This ensures that the communication remains within the Azure network and does not go through the public internet.

### Plans for tomorrow

1. Presentation
2. VMSS & Application Gateway

---

## WEEK 15

### Dagverslag

Wat zijn jou wins voor deze week?-----

- Documentation for v1.1 is updated
- I did sprint review presentation
- Deploy a basic App Gateway
- Deploy VMSS

