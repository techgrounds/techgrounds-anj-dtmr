# Cron jobs

What is Cron jobs?

Learned how to use these different commands:

## Key terminology

- [ ] crontab

## Benodigdheden

- [x] Your Linux machine

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

Execute to check if the bash script is right
```
sudo bash datetime.sh
```

[Check what I did]()

- [x] Register the script in your crontab so that it runs every minute.

[Take a peek]()

- [x] Create a script that writes available disk space to a log file in ‘/var/logs’. Use a cron job so that it runs weekly.

[Have a look]()

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1AkYSIMAVUV80uiGOafPnvR7k05jMlWtA/edit)
- [Beginners Cron jobs](https://ostechnix.com/a-beginners-guide-to-cron-jobs/)
- [Bash current time](https://tecadmin.net/get-current-date-and-time-in-bash/)
- [Cron job Editor](https://crontab.guru/every-week)
- [Shell script to watch the disk space](https://www.cyberciti.biz/tips/shell-script-to-watch-the-disk-space.html)
-

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

1.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Label]()
