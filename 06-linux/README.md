# LNX-06 Processes

Coincidentally this week, I was reading the book, The Untold Women Who Made The Internet. In that book I got to meet, [Stacy Horn](https://en.wikipedia.org/wiki/Stacy_Horn), the woman behind East Coast Hang-Out. [Echo](https://www.echonyc.com/about/). An online community that was started in New York City in 1990. Echo was, what we would call today a social network. It is accessed via telnet, this requires opening Terminal, a command-line application that serves as a kind of text-based window into the operating system, and summoning Echo with a typed command: `$ ssh claire@echonyc.com`

Sharing this because it helped me understand the use history of Telnet and how this processes actually is contributed by women.

Learned how to use these different commands:

- ps aux | grep telnetd
- ps aux | grep PID_number

## Key terminology

- [ ] Telnet
- [ ] Daemons
- [ ] Services
- [ ] Programs
- [ ] PID (Process ID) number
- [ ] xinetd
- [ ] inetd

## Benodigdheden

- [x] Your Linux machine

## Opdrachten

- [x] Install and Start the telnet daemon.
```
sudo apt-get install telnetd -y
sudo systemctl start xinetd
```

[Check what I did](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-06-install.png)

- [x] Find out the PID of the telnet daemon. Find out how much memory telnetd is using.
`systemctl status xinetd`

[Take a peek](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-06-status.png)

- [x] Stop or kill the telnetd process. 
`sudo systemctl stop xinetd`

[Have a look]()

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/19gN8lENHUxxWiQXbmuq9WybZ0iT9RjGe/edit#)
- [Daemon](<https://en.wikipedia.org/wiki/Daemon_(computing)>)
- [Daemon commands](https://linuxhint.com/stop_start_restart_services_debian/)
- [Telnet vs SSH Explained](https://www.youtube.com/watch?v=tZop-zjYkrU)
- [Install Telnet Server](https://www.atlantic.net/vps-hosting/how-to-install-and-use-telnet-on-debian-11/)
- [IBM Telnet Daemon](https://www.ibm.com/docs/en/zos-basic-skills?topic=zos-telnet-daemon)
- [How to tell if inetd and xinetd](https://www.cyberciti.biz/faq/how-to-tell-if-your-linux-server-uses-xinetd-or-inetd-sever/#:~:text=A.,such%20as%20ftp%20or%20telnet.)
- [XINETD - Extended Internet Daemon](https://goyalankit.com/blog/xinetd)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: I was trying to install telnet with Homebrew
Issue 2: Inetd masked
Issue 3: [Service](https://kerneltalks.com/howto/how-to-restart-inetd-service-in-linux/)
[Issue 4:](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/chatgpt-terminal-history.jpg) Friday, around 3 in the afternoon, my device gave up and lost all the history of my terminal from week one, the worst part is I did not save screenshots from Exercises 4 to 7. I first focus on Cron Jobs because I need other people's expertise on that. Then Friday night I continued and ask the best friend of every programmer on what steps to do and which command I can use to find the history of all the commands I used in the command line.

```
cat ~/.bash_history
```

Issue 5: lock-frontend permission denied
Issue 6: cannot find a way to kill

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Label]()
