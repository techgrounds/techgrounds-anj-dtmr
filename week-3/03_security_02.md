# Firewalls

**Firewall Types:**

- Host-based firewall
- Network-based firewall

## Key terminology

- [ ] De verschillende types firewall
- [ ] Access Control List: Permission (Allowed/Denied), IP Address, Protocol, Destination, Port
- [ ] stateful / stateless
- [ ] hardware / software
- [ ] CentOS en REHL
- [ ] firewall
- [ ] bron en bestemming van een pakket
- [ ] poortnummer
- [ ] protocol
- [ ] firewall daemon (firewalld)
- [ ] iptables
- [ ] HTTP traffic / http-verkeer
- [ ] A web server is a software program that responds to requests from web browsers and serves web pages to them over the internet or a local network. When you enter a website URL into a web browser, the browser sends a request to the web server hosting that website, and the server responds by sending back the web page that you requested. The web server is responsible for processing these requests, finding the requested web page or resource, and delivering it to the client web browser. Some examples of popular web servers include Apache, Nginx, and Microsoft IIS.

## Benodigdheden

- [x] Je Linux machine
- [x] Je unieke poortnummer voor http-verkeer

## Opdrachten

- [x] Installeer een webserver op je VM.
- [x] Bekijk de standaardpagina die met de webserver geïnstalleerd is.
- [x] Stel de firewall zo in dat je webverkeer blokkeert, maar wel ssh-verkeer toelaat.
- [x] Controleer of de firewall zijn werk doet.

Here's the step by step process how I completed these tasks:

1. Familiarized myself with the different key terminologies and how they work and relate to each other.
2. I made sure I updated/installed Apache (a web server) of my Ubuntu VM. I am certain we can use other web server aside form Apache but because Ubuntu comes with Apache pre-installed, let's not make our lives complicated.

```
sudo apt-get update
sudo apt-get install apache2
```

3. To verify if all the installations are complete. I start my web server default page. To view the default page installed with the web server, I used this combination http://servername:web_port(I got this numbers from our learning coach who provided the VM environment details).

```
sudo service apache2 start
sudo service apache2 status
apachectl configtest
```

![Apache Default Page](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-02-defaultpage.png)

4. Research about Ubuntu's built-in firewall. Check the current status of ufw.

sudo ufw default deny incoming - blocks all incoming traffic
sudo ufw default allow outgoing - allows all outgoing traffic
sudo ufw allow ssh - allows ssh
sudo ufw enable - enables the firewall with the new rules

```
sudo ufw status
sudo ufw app list
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable
sudo ufw status

```

![ufw](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-02-ufw.png)

5. Set up firewall rules to block web traffic but allow SSH traffic. Verified this by running the default page again, it should give an error. And I should still able to able to SSH into the VM.

```
sudo ufw deny Apache
sudo ufw status

```

![Deny](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-02-deny.png)
![Deny](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-02-deny2.png)

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1ngTMmDk8hX61yQQGFieqFLswh6UdoEGO)
- [What is a Firewall?](https://www.youtube.com/watch?v=kDEX1HXybrU)
- [What is a web server?](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_web_server)
- [How To Configure Firewall with UFW on Ubuntu 20.04 LTS](https://www.cyberciti.biz/faq/how-to-configure-firewall-with-ufw-on-ubuntu-20-04-lts/)
- [How To Set Up a Firewall with UFW on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ] what's the difference between sudo ufw allow ssh and sudo ufw allow 22? I accidentally used them both, what's happening in my machine then? How can I troubleshoot to know that something is working incorrectly?
- [ ] why do I need to "deny the incoming" first then "allow outgoing"? Which incoming? The packets? Why do we need to deny incoming before changing the rules?
- [ ] Why we use servername+web_port as the domain name? How do we compare it with IP address network and host portions?

Issue 2: I thought using ip addr show command that I am getting the right IP address to use for the default page, after trying out a lot of combinations from different articles. In the end I asked my team mates on what resources they have for this.

[Issue 3:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-02-issue3.png) I accidentally used both of these commands: sudo ufw allow ssh and sudo ufw allow 22. I used the command sudo ufw reset to restart all the steps I did. I was hesitant at first if I should do a reset, but I was too curious not to try. No harm was done. Gelukkig maar.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Reset and configure my webserver, ufw and rules successfully:**
![Result](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-02-reset.png)
