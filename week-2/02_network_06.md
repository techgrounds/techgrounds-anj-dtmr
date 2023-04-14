# Subnetting

What is subnetting? Imagine we live in a city with a large population. To make it easier to find people, the city is divided into neighborhoods, and each neighborhood has its own unique name and address. Similarly, in the world of computer networking, subnetting is like dividing a large network into smaller neighborhoods or subnets.

| Bits, Bytes, Mega, Giga, Tera (explained) |
| ----------------------------------------- | --------------- |
| 1 bit                                     | a 1 or 0 (b)    |
| 4 bits                                    | 1 nybble (?)    |
| 8 bits                                    | 1 byte (B)      |
| 1024 bytes                                | 1 Kilobyte (KB) |
| 1024 Kilobytes                            | 1 Megabyte (MB) |
| 1024 Megabytes                            | 1 Gigabyte (GB) |
| 1024 Gigabytes                            | 1 Terabyte (TB) |
| 1024 Terabytes                            | 1 Petabyte (PB) |

The power of 2's

| 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 128 | 64  | 32  | 16  | 8   | 4   | 2   | 1   |

Sample of regular IP address -> 1.1.1.1
Sample of an IP address in binary -> 00000001.00000001.00000001.00000001
How do you call 1 group of 00000001? -> octet, count them and you'll know they're 8 bits. So 00000001.00000001.00000001.00000001 is a group of 4 octes
How many 8 bits in a byte? -> 1 byte
How many bits is a regular IP addpres? -> 32 bits

**What is Subnet mask**
32-bit number that is used to divide an IP address into network and host portions Also known as a netmask or network mask. It makes the computer's work easier to determine which portion of an IP address belongs to the network and which portion belongs to the host.

Subnet mask -> 255.255.255.0

What is subnet mask in binary? 11111111.11111111.11111111.00000000

11111111.11111111.11111111. what these first 3 section called? -> Network bits

What is Network bits? -> are the part of an ip address that wont change

.00000000 what does 4th octet is telling us? -> they tell us which part of the ip address are host bits.

What is host bits? The host portion is like the house and street number, it uses all the available number of bits so that when a device wants to temporarily connect to the network, it will give it that space/number.

How many available bits .00000000 have then? 8 bits, but if we multiple that 2 to the power of 8, the total ip address available is 256 (including 0) minus the 3 reserved ip addresses. it will give us in total of 253.

But what if 253 ip addresses are not enough? What if we need more that 500 ip address?

Subnetting is the magic trick for that.

**Sample of subnetting:**
IP Address -> 192.168.32.5
Binary -> 11000000.1010100.00100000.00000101
Subnet mask -> 255.255.255.0
Binary of subnet mask -> 11111111.11111111.11111111.00000000

Subnetting -> 11111111.11111111.11111110.00000000

Remembering when we said that the 1's are unchangeable (Network bits)? Here because we borrowing bits from the subnet mask we have now 9 zeros. and 2 to the power of 9 is 512.

Subnetting is changing the subnet mask to suit our needs.

**CIDR Notation**

What is CIDR Notation? Classless Inter-Domain Routing. CIDR notation is a way of representing IP addresses and their associated subnet masks. It's a shorthand way of writing an IP address and the number of bits in the subnet mask, separated by a slash (/) character. For example, instead of writing out the full subnet mask as 255.255.255.0, we can represent it as /24, indicating that the first 24 bits of the IP address are used for the network portion of the address. CIDR notation is commonly used in networking to simplify the representation and management of IP addresses and subnets.

Example:
172.16.15.10/18 (sub 18 or 18 bits)

It means that we need to make 18 ones and 14 zeros and divide it into 4 octes with 8 bits each

1. make 18 ones and 14 zeros -> 11111111111111111100000000000000
2. 4 octes with 8 bits each -> 11111111.11111111.11000000.00000000
3. convert that binary into subnet mask address -> 255.255.192.0

## Benodigdheden

- [x] https://app.diagrams.net/
- [x] [Een subnet calculator](https://davidbombal.com/subnetting-concepts-calculator/)

## Opdrachten

- [x] Maak een netwerkarchitectuur die voldoet aan de volgende eisen:

* 1 private subnet dat alleen van binnen het LAN bereikbaar is. Dit subnet moet minimaal 15 hosts kunnen plaatsen.
* 1 private subnet dat internet toegang heeft via een NAT gateway. Dit subnet moet minimaal 30 hosts kunnen plaatsen (de 30 hosts is exclusief de NAT gateway).
* 1 public subnet met een internet gateway. Dit subnet moet minimaal 5 hosts kunnen plaatsen (de 5 hosts is exclusief de internet gateway).

Here's the step-by-step guide on how I approach this question:

1. From understand the different terminologies and concept about subnetting, I come to the conclusion that the tasks above is a whole different kind of task. Finding reliable resources with simple explanation was the challenge. Because of time shortage and not wasting any more time just researching, I decided to rely with ChatGPT on this one. The following steps are what I learned from this smart tool that I am in need to validate still in the next weeks.

2. Identify the requirements:

- The network must have 1 private subnet that is only accessible from within the LAN and can accommodate at least 15 hosts.
- The network must have 1 private subnet with internet access via a NAT gateway and can accommodate at least 30 hosts (excluding the NAT gateway).
- The network must have 1 public subnet with internet access and can accommodate at least 5 hosts (excluding the internet gateway)

3. Determine the IP address ranges for each subnet:

- Private subnet: Choose a private IP address range, such as 10.0.0.0/8, and allocate a subnet that can accommodate at least 15 hosts. In this example, we'll use 10.0.1.0/28.
- Private subnet with internet access: Allocate another subnet that can accommodate at least 30 hosts and assign a NAT gateway IP address. In this example, we'll use 10.0.2.0/27 and allocate the NAT gateway IP address as 10.0.2.1.
- Public subnet: Allocate a public IP address range that can accommodate at least 5 hosts and assign an internet gateway IP address. In this example, we'll use 203.0.113.0/29 and allocate the internet gateway IP address as 203.0.113.1.

4. Design the network topology:

- Place the private subnet and the private subnet with internet access behind a firewall or router that can block unwanted traffic.
- Connect the firewall or router to the internet gateway and place the public subnet behind it.
- Configure the NAT gateway to allow outbound traffic from the private subnet with internet access and translate the private IP addresses to the public IP address of the NAT gateway.

5. I note down all the confusions and questions I have:

- What is the purpose of configuring a firewall or router in a NAT network?
- What is the purpose of a NAT gateway in a network?
- Which subnet requires outbound traffic to be translated by the NAT gateway in a typical NAT network?
- What is the purpose of configuring an internet gateway in a NAT network?
- What is the difference between a public subnet and a private subnet in a NAT network?
- Why is it important to place a firewall or router between the private subnet and the public subnet?
- What is switch and where should I place switch? Should I place a switch in this network topology?
- Why need to convert ip address to binary for subnetting? IP addresses are represented in decimal format, but computers and networking devices communicate using binary. To properly subnet a network, we need to identify the network portion and host portion of an IP address using binary values, which requires converting the IP address to binary format. That the computer understand

[Check the whole steps here](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-06-steps.png)

- [x] Plaats de architectuur die je hebt gemaakt inclusief een korte uitleg in de Github repository die je met de learning coach hebt gedeeld.

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1Fc6F6PrLet-jgRSbJ56ezrvh9pLvoBWq/edit)
- [CIDR](https://www.youtube.com/watch?v=bgamrwBxejc)
- [Subnetting Course](https://www.youtube.com/playlist?list=PLIhvC56v63IKrRHh3gvZZBAGvsvOhwrRF)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: From understanding the different terminologies and concept about subnetting, I come to the conclusion that the tasks above is a whole different kind of task, I was tricked and confused, but that was really fun! because I see the pattern and steps why we needed to understand the theory first and all these concepts, that leads us to this new adventure. Though I spent a day or two understanding the how these subnetting is connected to what we learned about OSI and TCP/IP models, network devices, protocols, binary and hex, and IP address. I also come to conclusion that I still really don't get them :D. But see the diagram below to prove the basic understanding I had from the last days. Small wins, are big wins!

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Network Architecture Diagram](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-06-result.png)
