# How to proceed from v1.0 requirements to v1.1?

## Backup v1.0

- [ ] Before I make any changes, I've created a backup of the existing v1.0 Bicep project. This will ensure that I have a safe copy in case anything goes wrong during the upgrade process.

## Understand the Changes

- [ ] I started by reviewing the release notes or changelog for Bicep version 1.1. This give me insights into the new features, bug fixes, and any breaking changes introduced in the new version. I make sure to understand the implications of these changes for my IaC project.

## Write the user stories yourself:

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

## Review Breaking Changes

- [ ] If there are any breaking changes introduced in version 1.1, carefully review them and identify how they impact your existing code. Considerations might include changes to syntax, deprecated features, or modifications to resource types.

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

- [ ] Extend the things I can't finish the last week

### July 17, 18, 19

- [ ] Documentation and Prepare final presentation

### July 20

- [ ] Final Presentation

### July 21

- [ ] Graduation
