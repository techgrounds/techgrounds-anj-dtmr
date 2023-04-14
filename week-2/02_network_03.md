# Protocols

What is Wireshark and why is it used? Wireshark is another open-source software used to analyze the captured packets from the connected network of your current device.

Packet in networking is a smale-scale segment of a bigger message or data. These packets are then divided when sent into a computer network such as internet then recombined by the device that receives the message or data, following the protocols.

A network protocol are set of rules or agreement how connected devices communicate across all the possible network to exchange information or data easily and safely.

## Benodigdheden

- [x] Wireshark

## Opdrachten

- [x] Identify several other protocols and their associated OSI layer. Name at least one for each layer.

Remember when we said that OSI and TCP/IP made the transfering of the data easier between networks? It comes of course with set of rules, The protocols.

| OSI          | LAYER | Protocols                                                                                |
| ------------ | ----- | ---------------------------------------------------------------------------------------- |
| APPLICATION  | 7     | HTTP, SMTP, DHCP, FTP, Telnet, SNMP and SMPP                                             |
| Presentation | 6     | XDR, TLS, SSL and MIME                                                                   |
| Session      | 5     | PPTP, SAP, L2TP and NetBIOS                                                              |
| TRANSPORT    | 4     | Transmission Control Protocol (TCP), UDP, SPX, DCCP and SCTP                             |
| NETWORK      | 3     | Internet Protocol (IPv4), Internet Protocol (IPv6), IPX, AppleTalk, ICMP, IPSec and IGMP |
| DATA LINK    | 2     | ARP, CSLIP, HDLC, IEEE.802.3, PPP, X-25, SLIP, ATM, SDLS and PLIP                        |
| PHYSICAL     | 1     | Bluetooth, PON, OTN, DSL, IEEE.802.11, IEEE.802.3, L431 and TIA 449                      |

- [x] Figure out who determines what protocols we use and what is needed to introduce your own protocol.

* Protocols are developed by industry-wide organizations. The ARPA (Advanced Research Project Agency) part of the US Defense program was the first organization to introduce the concept of a standardized protocol. The Internet Engineering Task Force (IETF) and the Internet Society that oversees the IETF oversee the Internet protocols, and the Internet Consortium for Assigned Names and Numbers (ICANN) controls the DNS hierarchy and the allocation of IP addresses

- [x] Look into wireshark and install this program. Try and capture a bit of your own network data. Search for a protocol you know and try to understand how it functions.

**TCP and UDP, are responsible for transporting internet packets.**
![TCP](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-03-tcp.png)

**Transport Layer Security (TLS) is a cryptographic protocol designed to provide communications security over a computer network.**
![TLS](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-03-tls.png)

**UDP utilises a ‘fire and forget’ strategy, whereas TCP utilises a ‘Three-way handshake’. TCP is therefore more reliable, but UDP is significantly faster.**
![UDP](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-03-udp.png)

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1GaGwkxfNT111mAfbfSYxYx1cGNx9vpuk/edit#)
- [Wireshark User’s Guide](https://www.wireshark.org/docs/wsug_html/#ChIntroWhatIs)
- [Installing Wireshark under macOS](https://www.wireshark.org/docs/wsug_html_chunked/ChBuildInstallOSXInstall.html)
- [Wireshark User Interface](https://www.wireshark.org/docs/wsug_html_chunked/ChapterUsing.html)
- [Start Wireshark from the command line](https://www.wireshark.org/docs/wsug_html_chunked/ChCustCommandLine.html)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

[Issue 1](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-03-issue1.png): When I was installing wireshark on mac it did not come to my mind to read the installation guide first. I had a problem with my local device permissions. All I needed actually was to read the documentary and follow it. If I did that I would find out that I need to install another package called chmodBPF. At the end I asked the guidance of my teammates because everything about the interface of wireshark, seems overwhelming and unfamiliar.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Successfully installed wireshark:**
![wireshark](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-2-includes/ntw-03-wireshark.png)
