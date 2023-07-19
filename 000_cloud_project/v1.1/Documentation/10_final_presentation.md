# Final Presentation

1. Design Architecture (What have I able to finish?)
2. Demo (Which resources are deployed and working?)
3. Decisions, Challenges, Learnings
4. Before Cloud Implementation & Cost Analysis
5. After Cloud Implementation & Cost Analysis
6. Q&A and feedbacks


## Design Architecture (What have I able to finish?)

- ![Final CLoud Design](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/Documentation/06_diagram/final-cloud.drawio.png)

## Demo (Which resources are deployed and working?)

- Play the demo.

## Decisions, Challenges, Learnings

- Application Gateway
- 1 Virtual Network with 1 app gateway subnet and 1 backend subnet both connected to VMSS
- Both way peering
- Azure SQL Database


- Spent too much focus on DB



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
Hardware Costs: $25,000
Software Licensing Costs: $22,000
Power and Cooling Costs: $24,000
Maintenance and Support Costs: $5,000
Space and Facility Costs: $36,000

Grand Total: $112,000 per year

## After Cloud Implementation & Cost Analysis

- [Pay-as-you-go (Azure SQL Database)](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/Documentation/06_diagram/Cloud%20Cost%20Analysis%20-%20pay-as-you-go.pdf)

**Estimated Monthly bill: $702.02**

- [3-year (Azure SQL Database)](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.1/Documentation/06_diagram/Cloud%20Cost%20Analysis%20-%203-yr.pdf)

**Estimated Monthly bill: $14,293.97**


## Q&A and feedbacks


