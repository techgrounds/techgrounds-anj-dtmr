# Final Presentation

1. Design Architecture (What have I able to finish?)
2. Demo (Which resources are deployed and working?)
3. Decisions
4. Before Cloud Implementation & Cost Analysis
5. After Cloud Implementation & Cost Analysis
6. Q&A and feedbacks


## Design Architecture

![Final CLoud Design](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/Documentation/06_diagram/final-cloud.drawio.png)


## Demo

- Play the demo.


## Decisions

- [x] Azure SQL DB connected to both management server and web server using private endpoint
- [x] working management server
- [x] 1 Virtual Network with 1 app gateway subnet and 1 backend subnet both connected to VMSS
- [x] Azure Application Gateway with Web Application Firewall (WAF) capabilities to act as a proxy 
- [x] VMSS Load balancer
- [x] Both way peering
- [x] Azure SQL DB connected to both management server and web server using private endpoint

While Azure MySQL Database is way more Cost Effective, Open-Source Flexibility, Support for Non-Microsoft Platforms, has vast Community Support and Tools......

Advantages of Azure SQL Database:

1. Compatibility with Microsoft SQL Server: Azure SQL Database is based on Microsoft SQL Server, which means it offers compatibility with existing SQL Server applications and tools. This makes it an excellent choice for organizations with a Microsoft-centric technology stack. (Relate to bicep)

2. Seamless Managed Service: Azure SQL Database is a fully managed service, which means Microsoft handles the infrastructure management, backups, patching, and updates. This offloads the operational burden from the users, allowing them to focus more on application development and business logic.

3. Scalability: Azure SQL Database offers flexible scaling options, allowing you to easily adjust the performance tier based on your application's demands. You can scale up or down the database resources without significant downtime.

4. High Availability and Fault Tolerance: Azure SQL Database automatically provides high availability through automatic backups, geo-replication, and redundancy across multiple Azure data centers. This ensures data integrity and minimal downtime.

5. Advanced Security Features: Azure SQL Database offers robust security features such as Transparent Data Encryption (TDE), firewall rules, and Azure Active Directory integration to protect sensitive data.

6. Intelligent Performance Optimization: Azure SQL Database utilizes intelligent features like Query Performance Insight and Automatic Tuning to optimize database performance and improve query execution.


## Before Cloud Implementation & Cost Analysis

On on-premises infrastructure where the company manages its own hardware, networking, and software updates, we need to consider various cost components:

1. Hardware Costs Estimation:

- Server Hardware (2 servers): $15,000
- Networking Equipment (routers, switches, firewalls, and load balancers): $10,000

2. Software Licensing Costs Estimation:

- Windows Server Standard License (1 servers): $2,000
- SQL Server Standard License (2 servers): $20,000
- Linux Server Standard License (Open-source): $0

3. Power and Cooling Costs Estimation:

- Monthly Power and Cooling Costs: $2,000

4. Maintenance and Support Costs Estimation:

- Annual Maintenance and Support Costs: $5,000

5. Space and Facility Costs Estimation:

- Monthly Data Center Space Rent: $3,000


**Estimated Total On-Premises Infrastructure Cost (Per Year):**
- Hardware Costs: $25,000
- Software Licensing Costs: $22,000
- Power and Cooling Costs: $24,000
- Maintenance and Support Costs: $5,000
- Space and Facility Costs: $36,000

**Grand Total: $112,000 per year**


## After Cloud Implementation & Cost Analysis

- [Pay-as-you-go (Azure SQL Database)](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/Documentation/06_diagram/Cloud%20Cost%20Analysis%20-%20pay-as-you-go.pdf)

**Estimated Monthly bill: $702.02**

- [3-year (Azure SQL Database)](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/Documentation/06_diagram/Cloud%20Cost%20Analysis%20-%203-yr.pdf)

**Estimated Monthly bill: $315.26**


## Q&A and feedbacks

Salamat! Thank you! Bedankt!

