# Network detection

What is Computer Security? Computer security focuses on protecting computer systems from unauthorized access and use. For our own personal computer security, this can include steps like installing antivirus software, using a password generator and protecting the data we share online.

Computer Ethics refers to the ethical implementation and use of computing resources. This includes avoiding infringement of copyrights and trademarks, unauthorized distribution of digital content and the behavior and approach of a human operator, workplace ethics and compliance with the ethical standards that surround computer use.

Why is computer security so important? Because understanding the basics of computer security can help you avoid headaches and keep your data safe from others. Having your identity stolen or your accounts compromised can involve hours lost with account recovery — as well as significant financial losses.

What is Network detection?

The Nmap or Network Mapper is an open-source tool that is used for network discovery and security auditing. It is useful for many systems and network administrators for tasks like network inventory, managing service upgrade schedules, and monitoring host or service uptime. It uses raw IP packets in novel ways to determine what hosts are available on the network, what services those hosts are offering, what OS they are running. Nmap is designed to scan systems rapidly but comes with the drawback that it works fine only against single hosts.

Output from Nmap is a list of scanned targets:

- port number and protocol
- service name
- and state: open, filtered, closed, or unfiltered

Open means that an application on the target machine is listening for connections/packets on that port.

Filtered means that a firewall, filter, or other network obstacle is blocking the port so that Nmap cannot tell whether it is open or closed.

Closed ports have no application listening on them, though they could open up at any time.

## Key terminology

- [x] nMap

## Benodigdheden

- [x] Your Linux machine
- [x] Wireshark

## Opdrachten

- [x] Scan the network of your Linux machine using nmap. What do you find?

- [x] Open Wireshark in Windows/MacOS Machine. Analyse what happens when you open an internet browser. (Tip: you will find that Zoom is constantly sending packets over the network. You can either turn off Zoom for a minute, or look for the packets sent by the browser between the packets sent by Zoom.)

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1ngTMmDk8hX61yQQGFieqFLswh6UdoEGO)
- [Computer Security](https://bootcamp.berkeley.edu/blog/what-is-computer-security/#:~:text=But%20what%20is%20computer%20security,security%20and%20computer%20safety%20practices.)
- [How to use the nmap command: 2-Minute Linux Tips](https://www.youtube.com/watch?v=H2vpIyStRU0)
- [How to scan for IP addresses on your network with Linux](https://www.techrepublic.com/article/how-to-scan-for-ip-addresses-on-your-network-with-linux/)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

[Issue 1:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-issue1.png) From this command nmap -v -sn 192.168.0.0/16 10.0.0.0/8 I received a infinite looking text the only way to stop it was to terminate the command line.

Issue 2: Ask better questions

- What is a raw IP packets? How does it differ from IP or packets?

Issue 3: The only documentary I could find and understand about nMap was the one's how to install it. I tried the man nmap command and found out it also works with nmap. By reading the documentary + the resources about I learned how to use these different commands, I made sure I to update my Linux machine first:

```
sudo apt-get update
sudo apt install nmap
nmap --version
man nmap
sudo nmap --iflist
nmap -A -T4 scanme.nmap.org
sudo nmap -sT -O 10.171.154.221/22
```

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Because I could not find an easy read documentation about the different nmap commands, I ask ChatGPT the explanation:**
![nmap](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-chatgpt.png)

**Played around these commands**
![nmap](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-iflist.png)

![nmap](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-nmap.png)

![nmap](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-scan.png)

![nmap](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-sn.png)

![nmap](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-sp.png)

![nmap](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-st-o-a.png)

![nmap](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-st-o.png)

**Monitored wireshark**
![zoom & wireshark](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-01-wireshark.png)





