# How to proceed from v1.0 requirements to v1.1?

## Backup v1.0

- [ ] Before I make any changes, I've created a backup of the existing v1.0 Bicep project. This will ensure that I have a safe copy in case anything goes wrong during the upgrade process.

## Understand the Changes

- [ ] I started by reviewing the release notes or changelog for Bicep version 1.1. This gave me better understanding into the new features, bug fixes, and any breaking changes introduced in the new version. I make sure to understand the implications of these changes for my IaC project.

## Write the user stories

- [ ] See under [Project Introduction]()

## Break Down Key Terminologies

- [ ] As a beginner, it helps me understand the bigger picture by starting to understand every word I encounter.

1. Web Server: A web server is a software or hardware system that serves web content, such as webpages, to clients (users) who request it over the internet.

2. Proxy: A proxy is an intermediary server that acts on behalf of clients and forwards their requests to other servers. In this case, the customer prefers to have a proxy between the internet and the web server for security and other purposes.

3. Public IP Address: A public IP address is a unique address assigned to a device (in this case, the web server) on the internet. It allows the server to be directly accessible from the internet. The project specifies that the web server should no longer have a public IP address.

4. Load Balancer: A load balancer distributes incoming network traffic across multiple servers (in this case, web servers) to optimize resource utilization, maximize throughput, and ensure high availability. It helps distribute the workload evenly and improves performance.

5. HTTP and HTTPS: HTTP (Hypertext Transfer Protocol) is the protocol used for transmitting web content over the internet. HTTPS (HTTP Secure) is the secure version of HTTP, where the communication is encrypted using SSL/TLS protocols to ensure data privacy and integrity.

6. TLS (Transport Layer Security): TLS is a cryptographic protocol that provides secure communication over the internet. It encrypts data transmitted between a client (e.g., web browser) and a server (e.g., web server) to protect it from eavesdropping or tampering. The project specifies that the connection should be secured with at least TLS 1.2 or higher.

7. Health Check: A health check is a mechanism used to assess the status and availability of a resource, such as a web server. It periodically sends requests to the server to ensure it is functioning properly. If the server fails the health check, it indicates a problem, and appropriate actions can be taken.

8. Server Restoration: If a web server fails the health check, it needs to be automatically restored. This typically involves restarting the server or taking remedial actions to bring it back to a healthy state.

9. Scaling: Scaling refers to the ability to handle increased workload or traffic by adding additional resources, such as servers. In this case, if the web server is under continuous load, a temporary additional server should be started to handle the increased demand. The project mentions that there should be a maximum of three servers running concurrently.

10. Self-Signed Certificate: A self-signed certificate is a digital certificate that is signed by its own creator instead of a trusted third-party certificate authority (CA). It is used to establish an encrypted HTTPS connection. However, self-signed certificates are not validated by trusted CAs, so web browsers typically show a warning to users when accessing a website using a self-signed certificate.

## Services

v1.1

- [ ] Web server VMSS with application gateway as load balancer
- [ ] Application Gateway provides load balancing capabilities to distribute traffic across multiple backend servers
- [ ] Application Gateway does not provide auto scaling for backend servers so use VMSS or Azure Kubernetes Service (AKS)
- [ ] Application Gateway with reverse proxy
- [ ] The Application Gateway supports terminating SSL/TLS connections, enabling you to configure HTTPS endpoints for client connections
- [ ] Upload a self-signed certificate to the Application Gateway
- [ ] Application Gateway can perform health checks
- [ ] Application Gateway includes various security features, such as Web Application Firewall (WAF)

## Planning

### July 3 - 7

3.

- [x] Planning

4.

- [x] Use module (main.bicep) for management network

Resources: https://learn.microsoft.com/en-us/events/learn-events/learnlive-iac-and-bicep/

- [x] NSG (management)

- [x] Deploy a SQL Database

5.

- [x] Use module (main.bicep) for web network

- [x] Deploy a SQL Database that is connected to both the web server and admin/management server.

6.

- [ ] Web server VMSS with application gateway as load balancer v1.1 (- Deploy the VM's to an Availability Set?????)

- NSG (web) and apache

- [ ] Application Gateway does not provide auto scaling for backend servers so use VMSS or Azure Kubernetes Service (AKS)

- [ ] Application Gateway with reverse proxy

- [ ] The Application Gateway supports terminating SSL/TLS connections, enabling you to configure HTTPS endpoints for client connections
- [ ] Upload a self-signed certificate to the Application Gateway
- [ ] Application Gateway can perform health checks
- [ ] Application Gateway includes various security features, such as Web Application Firewall (WAF)

7.

- [ ] Key Vault, Disk Encryption:

All VM disks must be encrypted.
Utilize Key Vault to securely store any secrets or credentials required for accessing and executing the bootstrap/post-deployment scripts.
Use Key Vault to manage and store the cryptographic keys required for encrypting and decrypting the data within the infrastructure.
Connect the web and admin server to the Key Vault to retrieve necessary secrets.

- [ ] Deploy a Recovery Service Vault

- [ ] Recovery Service Vault: The Web server should be backed up daily. Backups must be retained for 7 days. Create a Recovery Services Vault and configure it to back up the VMSS in the webserver subnet.

### July 10 - 14

- [ ] Extend the things I can't finish from last week

### July 17, 18, 19

- [ ] Documentation and Prepare final presentation

### July 20

- [ ] Final Presentation

### July 21

- [ ] Graduation
