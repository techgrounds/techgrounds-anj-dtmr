# LNX-08 Cron jobs

<!-- What is Cron jobs?

Learned how to use these different commands: -->

## Key terminology

- [ ] crontab

## Benodigdheden

- [x] Your Linux machine

Note: Make sure your cron is started and the path of your script file is added to the PATH variable

## Opdrachten

- [x] Create a Bash script that writes the current date and time to a file in your home directory.

```
touch datetime.sh

vi datetime.sh

#!/usr/bin/bash

datetime=$(date)

echo $datetime >> /home/datetime.txt
```

Note: Make sure to give permission to your bash file to execute

```
sudo chmod u+x datetime.sh
```

or

```
sudo chmod 664 datetime.sh
```

Execute to check if the bash script is right.

```
sudo bash datetime.sh
```

Then check the changes on datetime.txt

[Check what I did](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-08-cron-date1.png)

- [x] Register the script in your crontab so that it runs every minute.

```
sudo crontab -e

***** sudo bash $home/techgrounds/scripts/datetime.sh
```

**Important Note:** There is a difference between "crontab -e" and "sudo crontab -e".

[Take a peek](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-08-cron-date2.png)

- [x] Create a script that writes available disk space to a log file in ‘/var/logs’. Use a cron job so that it runs weekly.

```
touch diskspace.sh

vi diskspace.sh

#!/bin/bash

df -H >> /var/log/disk_space.log

```

Note: Make sure to give permission to your bash file to execute

```
sudo chmod u+x disk_space.log
```

or

```
sudo chmod 664 disk_space.log
```

Execute to check if the bash script is right.

```
sudo bash disk_space.log
```

Then check the changes on disk_space.log

To access the log file in ‘/var/logs’

```
cd /var/log
```

[Have a look](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-08-cron-disk2.png)

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1AkYSIMAVUV80uiGOafPnvR7k05jMlWtA/edit)
- [Beginners Cron jobs](https://ostechnix.com/a-beginners-guide-to-cron-jobs/)
- [Bash current time](https://tecadmin.net/get-current-date-and-time-in-bash/)
- [Cron job Editor](https://crontab.guru/every-week)
- [Shell script to watch the disk space](https://www.cyberciti.biz/tips/shell-script-to-watch-the-disk-space.html)
- [linux difference between "sudo crontab -e" and just "crontab -e"](https://stackoverflow.com/questions/43237488/linux-difference-between-sudo-crontab-e-and-just-crontab-e#:~:text=Yes%2C%20indeed%20they%20are%20different,user%20who%20is%20logged%20in.)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Struggling on when to use bash with sudo when creating a new file

[Issue 2:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-08-issue2.png) I don't know what /var/log means but it looks like a path to me, so I was trying to find a way to get into the file.

Issue 3: Cron jobs is something I only once heard, again, I don't know where or how to begin because this is another new concept. But from researching on google, I come to a beginner understanding on what Cron Jobs is and saw the pattern on how to execute it, which is detailed documented above. The biggest issue I had is when my scripts on crontab is not working, and I don't know how to debug it. So I approached Roan and we called for an hour to compare how he did his with mine, without a success
I approached the learning coach and together with other colleagues we found out that there is a difference between using "crontab -e" and "sudo crontab -e"

[Issue 4:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/chatgpt-terminal-history.jpg) Friday, around 3 in the afternoon, my device gave up and lost all the history of my terminal from week one, the worst part is I did not save screenshots from Exercises 4 to 7. I first focus on issue 3 because I need other people's expertise on that. Then Friday night I continued and ask the best friend of every programmer on what steps to do and which command I can use to find the history of all the commands I used in the command line.

```
cat ~/.bash_history
```

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Understood how Cron jobs work**
![Crontab](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-08-cron-disk1.png)
