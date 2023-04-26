# Azure Global Infrastructure

Data Center

- Physical facility
- Hosting for group of networked servers
- Own power, cooling & networking infrastructure

Region

- a data centers that are connected with each other with high proof internet connectivity
- Geographical area on the planet
- One but usually more datacenters connected with low-latency network (<2 milliseconds)
- Location for your services
- Some services are available only in certain regions
- Some services are global services, as such are not assigned/deployed in specific region
- Special government regions (US DoD Central, US Gov Virginia, etc.)
- Special partnered regions (China East, China North)

Availability Zone

- Regional feature
- Grouping of physically separate facilities
- Designed to protect from data center failures
- If zone goes down others continue working
- Two service categories: Zonal services (Virtual Machines, Disks, etc.), Zone-redundant services (SQL, Storage, etc.)
- Not all regions are supported
- Supported region has three or more zones
- A zone is one or more data centers

Region Pair

- Each region is paired with another region making it a region pair
- Region pairs are static and cannot be chosen
- Each pair resides within the same geography
- Exception is Brazil South
- Physical isolation with at least 300 miles distance (when possible)
- Some services have platform-provided replication
- Planned updates across the pairs
- Data residency maintained for disaster recovery

Geographies

- Discrete market
- Typically contains two or more regions
- Ensures data residency, sovereignty, resiliency, and compliance requirements are met
- Fault tolerant to protect from region wide failures
- Broken up into areas: Americas, Europe, Asia Pacific, Middle East and Africa
- Each region belongs only to one Geography

An Azure Region is like a city and its surrounding area where Microsoft has placed servers to offer their Azure cloud services. Just like different cities have different languages, culture, and food, Azure regions have different geographic locations, local laws, availability of resources, and connectivity to other regions.

An Azure Availability Zone is like a neighborhood in a city, where Azure servers are located in different physical locations within the same region to increase availability. This means that if there is an issue in one location, the other locations can take over without interruption.

An Azure Region Pair is like a twin city, where two Azure regions are located close to each other and connected to synchronize data. This ensures that if there is a major outage in one region, the other region can take over and keep the data up to date.

Azure regions decision guide:

- Available services - because it varies per region what available services are offered.
- Capacity - because each region has a maximum capacity.
- Constraints - because each region has different local laws
- Sovereignty - becuase some of Azure Regions are not managed directly by Microsoft

We might choose one region over another based on factors such as the distance to users, availability of resources, and local laws. For example, if you have users in Europe, it makes sense to choose the North Europe region instead of a region in Asia. However, if your business relies on certain Azure services that are only available in a particular region, you should choose that region, even if it is farther away.

## Key terminology

- [ ] Virtualisation
- [ ] Data centers
- [ ] Azure Subscriptions
- [ ] Azure Virtual Machines

## Bestudeer

- [x] Wat is een Azure Region?
- [x] Wat is een Azure Availability Zone?
- [x] Wat is een Azure Region Pair?
- [x] Waarom zou je een regio boven een andere verkiezen?

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1OtQ_wYxGEuVkk2XZKPJAU1GY6BQS7u8k)
- [Flashcard](https://quizlet.com/708120472/global-infrastructure-flash-cards/)
- [Azure Global Infrastructure](https://www.youtube.com/watch?v=gMiBvBM6Oj0)
- [Azure Global Infrastructure Cheat Sheet](https://tutorialsdojo.com/azure-global-infrastructure/)
- [Geographies, Regions & Availability Zones](https://www.youtube.com/watch?v=C-nNw1mGwzE)
- [Practice Test](https://marczak.io/az-900/episode-07/practice-test/)
- [Azure Global Infrastructure Script](https://marczak.io/az-900/episode-07/cheat-sheet/)
- [Latency Test](https://www.azurespeed.com/Azure/Latency)
- [Azure regions decision guide](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/migrate/azure-best-practices/multiple-regions)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [x] why Region pairs are static and cannot be chosen? Azure Region pairs are pre-defined and cannot be chosen because they are strategically designed to provide geographic redundancy and high availability for critical business applications and data. Microsoft has carefully selected and paired the regions based on their proximity and connectivity, and they have designed their infrastructure to ensure synchronous replication of data between the paired regions.

By having a pre-defined and static region pair, Microsoft can ensure that the paired regions are always up-to-date with each other and that they can handle failover and disaster recovery scenarios without data loss. This means that customers can rely on the region pairs to provide high availability and disaster recovery capabilities for their critical applications and data.

While customers cannot choose their region pairs, they can choose to replicate their data and applications to other regions using Azure Site Recovery or other Azure replication services. This provides additional flexibility and redundancy for their applications and data, but it comes with additional costs and complexity.
