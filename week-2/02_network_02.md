# Network Devices

There is no network without network devices. But what are the network devices in the present and how these are used, let's find out together below.

## Key terminology

- [x] Network Devices are hardware devices that link computers, printers, faxes, and other electronic devices to the network:

* router - used for routing traffic from one network to another and help transmit packets to their destinations by charting a path through the sea of interconnected networking devices using different network topologies
* switch - keeps limited information on routing nodes in the internal network and provides links to systems such as hubs or routers. A switch is a multiport device that improves network efficiency. Switches: These are devices that connect multiple devices on the same network. They operate at the second level of the OSI model (Layer 2) and use MAC addresses to direct data to the correct destination device.
* repeater - A repeater is an electronic device that amplifies the signal it receives. You can think of repeater as a device which receives a signal and retransmits it at a higher level or higher power so that the signal can cover longer distances, more than 100 meters for standard LAN cables. Repeaters work on the Physical layer.
* access point - usually means a wireless device. An AP operates on the second OSI layer, the data link layer, and can either act as a bridge that connects a standard wireless network to wireless devices or as a router that transmits data to another access point. Wireless connectivity points (WAPs) are a device used to generate a wireless LAN (WLAN) transmitter and receiver.
* gateway - The connection between networking technologies, such as OSI and Transmission Control Protocol / Internet Protocols, such as TCP / IP, is supported by the gateway.

- [x] Overview (from chatGPT) of how some common network devices relate to the OSI model:

1. Network Interface Cards (NICs): These are the hardware components that connect your computer to the network. They work at the lowest level of the OSI model (Layer 1) and are responsible for sending and receiving data signals over the network.

2. Switches: These are devices that connect multiple devices on the same network. They operate at the second level of the OSI model (Layer 2) and use MAC addresses to direct data to the correct destination device.

3. Routers: These devices connect multiple networks together. They operate at the third level of the OSI model (Layer 3) and use IP addresses to direct data between different networks.

4. Firewalls: These devices protect networks from unauthorized access and attacks. They operate at the highest level of the OSI model (Layer 7) and use a variety of security measures to ensure data is transmitted securely.

## Benodigdheden

- [x] Je eigen netwerk
- [x] Admin toegangsgegevens voor je router
- [x] NOOT: Als je geen admin-toegang hebt, bijvoorbeeld omdat je in een appartementencomplex met gedeelde wifi woont, neem dan via Zoom het scherm over van een teamgenoot, en doe zo de opdracht.

## Opdrachten

- [x] Common network devices and their functions

* VPNs: VPNs (Virtual Private Networks) allow users to access a private network over a public network (such as the internet). They encrypt data to ensure that it is transmitted securely and prevent unauthorized access to the network.
* Firewalls: These devices protect networks from unauthorized access and attacks. They operate at the highest level of the OSI model (Layer 7) and use a variety of security measures to ensure data is transmitted securely.
* Please see the rest under Key Terminologies above

- [x] De meeste routers hebben een overzicht van alle verbonden apparaten, vind deze lijst. Welke andere informatie heeft de router over aangesloten apparatuur?

![admin](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-admin.png)
![details](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-details.png)

- [x] Waar staat je DHCP server op jouw netwerk? Wat zijn de configuraties hiervan?

![DHCP server](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-admin-dhcp.png)

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1IRvNMnJSg5ebsCTXRuGbcu19WShd8HqR/edit#)
- [How to Find Your Router’s IP Address](https://www.security.org/vpn/find-router-ip-address/#:~:text=On%20Mac%20With%20Terminal%20App,to%20the%20word%20%E2%80%9CDefault.%E2%80%9D)
- [How to access router admin from command line](https://www.computerhope.com/issues/ch001062.htm)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: I could not understand what this exercises wanted me to do. It was overwhelming, plus I could not seem to understand the Dutch words from the instructions. I skipped this part for a day and did the next exercise. I noticed that when I successfully installed wireshark and understood more what networking is and what the purposes of different networking devices are. I begin to understand what everyone is talking about. For example, that they needed to reset their router, install a cisco packet tracer or even the simplest thing what the word protocol means.

[Issue 2](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-issue1.png): Because I don't know the username and password of my router admin. I search google on how I can "access router admin from command line".

I found about about the ipconfig command, but I could not understand why I kept on getting error until I tried "man ipconfig".
![ipconfig error](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-issue2.png)
![ipconfig error](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-issue3.png)

Learned to use these commands:

- ipconfig getiflist
- ipconfig getpacket en0
  ![getpacket](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-getpacket.png)
- ipconfig getsummary en0
  ![dhcp](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-dhcp.png)
- arp -a
  ![arp](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-arp.png)
- netstat -nr|grep default
  ![](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-netstat.png)

* sudo ipconfig set en0 BOOTP && sudo ipconfig set en0 DHCP
* ipconfig getsummary en0:

```
DHCP : <dictionary> {
LeaseExpirationTime : 04/12/2023 15:38:25
LeaseStartTime : 04/11/2023 15:38:25
server_identifier (ip): 192.168.1.1
lease_time (uint32): 0x15180
subnet_mask (ip): 255.255.255.0
router (ip_mult): {192.168.1.1}
}
```

Issue 3: Ask better questions. Are the Internet Gateway and Internet the same? No, the Internet Gateway and the Internet are not the same things.

The Internet Gateway is a device or a set of devices that connects a local network to the Internet, allowing the devices on that network to access the Internet. It acts as a bridge between the local network and the wider Internet.

The Internet, on the other hand, is a global network of interconnected computer networks that communicate with each other using a common protocol, the Internet Protocol (IP). It is a vast network that allows people and devices all over the world to connect and communicate with each other, access information, and exchange data.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**I did not gave up, even though I was persuade on the informations I get from the command line to answer the exercises above, I once again ask google the question below. I tried a lot of combinations until FINALLY I was able to get in. I found out how unsafe our router is and changed the username and password directly:**

How do I find my ZyXEL router username and password?
First, you will need to log in via IP Address. To do this, open any browser and navigate to 192.168. 1.1. The default username is admin and the default password is 1234.

![Result](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-02-result.png)
