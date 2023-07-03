# Weekly Time Logs

Check [v1.0 time logs]() for the first weeks.

# WEEK 4

July 3, 2023 Monday

### Dagverslag (1 zin)

Wat zijn jou wins vandaag?-----

- gelezen de pdf, gaat meer over de web server en health check
- de v1.0 en v1.1 requirements vergelijken maar ook niets veel gaan veranderen
- Can I let you see the things that I did for the v1.0 and my planning to take for v1.1
- ik heb user stories geschreven
- Planning voor mezelf geschreven
- over proxy en self-signed certificate gelezen/gekeken
- morgen wil ik over vmss
- advies vragen: zal ik eerst een main.bicep maken met module of verder met web server vmss + application gateway/key vault & disk encryption verder of module

### Obstakels & Oplossingen

1.

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

1. Tomorrow I would like to ask question to the learning coach and my team mates on how to proceed smartly.

---
