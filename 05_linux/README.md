# LNX-05 File permissions

There are three types of entities that can have different permissions: the owner of the file, a group, and everyone else. Root does not need permissions to read, write or execute a file.

Why permissions is important?

## Key terminology

- [ ] drwxrwxrwx

## Benodigdheden

- [x] Your Linux machine

## Opdrachten

- [x] Create a text file. Make a long listing to view the file’s permissions. Who is the file’s owner and group? What kind of permissions does the file have?
      ![Txt file](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-05-create.png)

- [x] Make the file executable by adding the execute permission (x).
      ![Execute](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-05-execute.png)

- [x] Remove the read and write permissions (rw) from the file for the group and everyone else, but not for the owner. Can you still read it?
      ![chmod](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-05-chmod.png)

- [x] Change the owner of the file to a different user. If everything went well, you shouldn’t be able to read the file unless you assume root privileges with ‘sudo’.
      ![chown](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-05-owner.png)
      ![chown](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-05-owner1.png)

- [x] Change the group ownership of the file to a different group.
      ![chgrp](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-05-grp.png)
      ![chgrp](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/linux/lnx-05-grp1.png)

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1vJfWbHumTxh779zwRnrRlq8Ytzm4_PXn/edit#)
- [Linux permissions for users, groups, and others](https://www.redhat.com/sysadmin/manage-permissions)
- [Chmod command](https://www.freecodecamp.org/news/linux-chmod-chown-change-file-permissions/)
- [Chown command](https://www.ibm.com/docs/en/aix/7.2?topic=c-chown-command)
- [Chgrp command](https://www.geeksforgeeks.org/chgrp-command-in-linux-with-examples/)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Luckily I have basic experience with permissions, I run through this task smoothly. But of course I still need to remind myself of all the commands by reading the above resources above.

[Issue 2:](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/chatgpt-terminal-history.jpg) Friday, around 3 in the afternoon, my device gave up and lost all the history of my terminal from week one, the worst part is I did not save screenshots from Exercises 4 to 7. I first focus on Cron Jobs because I need other people's expertise on that. Then Friday night I continued and ask the best friend of every programmer on what steps to do and which command I can use to find the history of all the commands I used in the command line.

```
cat ~/.bash_history
```

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Label]()
