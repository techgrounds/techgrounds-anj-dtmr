# IP adressen

IP stands for Internet Protocol, which is a set of rules for the format of data that devices transfer over the internet. IP addresses let computers and devices communicate with one another over the internet. Without them, no one would know who’s saying what, or to whom.

What is IP Addressing? Is a unique address assigned to every device that uses internet protocol on a network and helps identify those devices from one another. Analogy: This address, much like a house address, so when the post office needs to deliver a package to our house it knows where house number, street, and city it will lead the deliver personel, like IP Address it tells other devices where to send data or where is received from.

How many IP address are there in one device? 256
But how many usable does one device have, where are the ? 253

Sample of reserved IP Address:

- 192.168.1.0 or The Network Address
- 192.168.1.1 or The Default Gateway (YOUR ROUTER)
- 192.168.1.255 or The Broadcast Address

What are the difference between External (Public) and Local (Internal) IP address

**External (Public) IP Address**
Our Internet Service Provider (ISP) assigns the ip address to our device, when that device connect to Internet. So when we use any browser to check a website, that web browser send our IP Address along so that that website knows who is requesting, and if we are permitted to see that website, it sends back the information to the correct IP Address that our device is using.

Every website also has an IP address of its own, though you never need to know them. When you type in the domain name, such as "www.google.com", a Domain Name Server (DNS) looks up the IP address for you, which is the real location of the website. In this way, domain names are like human-friendly names pointing to machine-friendly IP addresses.

Public IP Addresses are publicly registered and every devices SHOULD have IPv4 public address if it wants to be connected to the internet.

**Local (Internal or Private) IP Address**

In 1992 the whole world run out of IP Addresses. The engineers then developed Private Address and NAT to solve this problem.

When our device is connected to the router with default settings, that router will automatically assign a local/internal/private IP address to your device. This local/internal/private IP address is hidden from the outside world and used only inside your private network (LAN or Local Area Network).

Private IP Addresses are NOT publicly registered and because of this the device with only private ip addresses cannot directly access the internet.

So when we turn on our computer first and it is the only device connected to our network, it will probably be assigned the local IP address 192.168.1.2. Then if we turn on our laptop and connect to the network it will probably be assigned the local IP address 192.168.1.3. And so on and so forth (the IP address 192.168.1.1 is generally reserved for the router itself, as stated above).

We can assign devices specific IP addresses in the router control panel, so that a device will always receive the same local IP address when it connects. This is called a static local IP address.

There are two types of IP Address: Static and Dynamic
When a device is assigned an IP address, it is either static or dynamic. Static simply means that the given address does not change. A dynamic IP, on the other hand, changes periodically. DHCP servers usually assign these addresses because the IPv4 standard cannot provide for all the devices that exist.

**What is NAT**
Network Address Translation is a service use in routers to translate a set of IP Address to another set of IP address. It helps preserve the limited amount (only 4.3M) of iPv4 public IP addresses.

For example, when our devices at home needs to access the internet thru our router. Network Address Translation converts our private IP addresses into public IP address. And it also translates the public IP address into private IP address. Because if a device outside our LAN would like to communicate or transfer data to the devices within our LAN, it needs to have a private IP address

**What is IPv4?**

An IPv4 address (Internet Protocol version 4) are addresses are 32-bit integers that can be expressed in hexadecimal notation. The more common format, known as dotted quad or dotted decimal, is x.x.x.x, where each x can be any value between 0 and 255. For example, 192.0. 2.146 is a valid IPv4 address.

**What is IPv6?**

It's a new set of IP addresses that won't need a NAT or private address, because it is able to produce 340 undecillion IP addresses

**The differences between IPv4 and IPv6**
![Label]()

## Key terminology

- [x] IP adressen
- [x] IPv4 en IPv6
- [x] Public en Private IPs
- [x] NAT
- [x] Statische en dynamische adressen

## Benodigdheden

- [x] Je laptop
- [x] Je mobiel
- [x] Admin toegangsgegevens voor je router

## Opdrachten

- [x] Ontdek wat je publieke IP adres is van je laptop en mobiel op wifi.
      Zijn de adressen hetzelfde of niet? Leg uit waarom.
      ![Label]()

- [x] Ontdek wat je privé IP adres is van je laptop en mobiel op wifi.
      Zijn de adressen hetzelfde of niet? Leg uit waarom.
      ![Label]()

- [x] Verander het privé IP adres van je mobiel naar dat van je laptop. Wat gebeurt er dan?
      ![Label]()

- [x] Probeer het privé IP adres van je mobiel te veranderen naar een adres buiten je netwerk. Wat gebeurt er dan? Tip: vergeet niet je instellingen weer terug te zetten wanneer je klaar bent met de opdracht.
      ![Label]()

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1AmVU1y8qaYjyz-SMJ2NM0YXoQ703eJor/edit#)
- [Use this to check your IP Address](https://www.avast.com/what-is-my-ip#mac)
- [What's The Difference Between External And Local IP Addresses?](https://www.h3xed.com/web-and-internet/whats-the-difference-between-external-and-local-ip-addresses#:~:text=An%20external%20or%20public%20IP,and%20devices%20connected%20to%20it.)
- [IPv4 vs. IPv6: What’s the Difference?](https://www.avast.com/c-ipv4-vs-ipv6-addresses)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: I did the tasks very smoothly. Understanding the logic and history behind the making of IP Addresses numbers and the key terminilogies and connect them with each other to understand the whole concept was the challenge. Again, googling, researching, reading, watching short videos, taking enough pause and discussing it back to my teammate really helps.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Label]()
