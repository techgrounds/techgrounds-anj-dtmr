# LNX-04 Users and groups

## Key terminology

- [ ] Virtual Machine (VM)
- [ ] Root is allowed to do anything and is a special user. Some actions require specific permissions like root permissions.
- [ ] sudo - To gain temporary root permissions, you can type ‘sudo’ in front of a command, but that only works if you’re allowed to do that.

## Benodigdheden

- [x] Your Linux machine

## Opdrachten

- [x] Create a new user in your VM
![Create New User](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-04-adduser.png)
- [x] The new user should be part of an admin group
![admin group](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-04-allcomnds.png)
- [x] The new user should have a password
![password](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-04-passwd.png)
- [x] The new user should be able to use sudo
![sudo](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-04-sudogrp.png)

`usermod -aG sudo username`

- [x] Locate the files that store [users](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-04-users1.png), [passwords](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-04-verify.png), and [groups](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-04-grp.png). See if you can find your newly created user’s data in there.

Password:
`cd /etc/shadow`

Groups:
`less /etc/group`

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1S-vkO8Flmrr0km4ptEnub0BmGb00pZKz/edit#)
- [Add a new user account with admin access on Linux](https://www.cyberciti.biz/faq/add-new-user-account-with-admin-access-on-linux/)
- [Admin List](https://superuser.com/questions/456762/list-admins-on-linux)
- [Password Location](https://www.cyberciti.biz/faq/where-are-the-passwords-of-the-users-located-in-linux/#:~:text=The%20encrypted%20passwords%20and%20other,in%20%2Fetc%2Fpasswd%20file.)
- [Sudoer?](https://unix.stackexchange.com/questions/50785/how-do-i-find-out-if-i-am-sudoer#:~:text=To%20know%20whether%20a%20particular,access%20for%20that%20particular%20user.&text=If%20the%20user%20don't,to%20run%20sudo%20on%20localhost.)
- [Group Location](https://manpages.ubuntu.com/manpages/trusty/man5/group.5.html)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: I do understand that creating a new user in the Virtual Machine, is also like creating a new user from the computer. What I just can't imagine before I have this project is that where should I make it? In my user? When I asked my teammates how they made it, it became more clearer what root user is and what our user is.

Issue 2: At first I got a warming that my user is a bad name, so I look what those reserved keywords and find a better new username to use.

[Issue 3:](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/chatgpt-terminal-history.jpg) Friday, around 3 in the afternoon, my device gave up and lost all the history of my terminal from week one, the worst part is I did not save screenshots from Exercises 4 to 7. I first focus on Cron Jobs because I need other people's expertise on that. Then Friday night I continued and ask the best friend of every programmer on what steps to do and which command I can use to find the history of all the commands I used in the command line.

```
cat ~/.bash_history
```

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Created a new user:**
![Users](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/chatgpt-terminal-history.jpg)
