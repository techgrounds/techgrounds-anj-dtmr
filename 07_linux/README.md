# LNX-07 Bash scripting

What is Bash scripting?

## Key terminology

- [ ] Shell
- [ ] Bash
- [ ] httpd package
- [ ] apache

## Benodigdheden

- [x] Linux machine

## Opdrachten

### Opdracht 1 - Bash:

- [x] Create a directory called ‘scripts’. Place all the scripts you make in this directory.
- [x] Add the scripts directory to the PATH variable.
- [x] Create a script that appends a line of text to a text file whenever it is executed.
- [x] Create a script that installs the httpd package, activates httpd, and enables httpd. Finally, your script should print the status of httpd in the terminal.

### Opdracht 2 - Variable:

- [x] Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file.

### Opdracht 3 - Conditions:

- [x] Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file only if the number is bigger than 5. If the number is 5 or smaller, it should append a line of text to that same text file instead.

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1GKebSLCnDdYDlrAJDjqIEq0xzcGCXdYw/edit#)
- [How to Add a Directory to PATH in Linux](https://linuxize.com/post/how-to-add-directory-to-path-in-linux/)
- [Bash Scripting Tutorial](https://www.freecodecamp.org/news/bash-scripting-tutorial-linux-shell-script-and-command-line-for-beginners/)
- [Linux append text to end of file](https://www.cyberciti.biz/faq/linux-append-text-to-end-of-file/)
- [How To Install the Apache Web Server on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-20-04)
- [Conditions in bash scripting (if statements)](https://acloudguru.com/blog/engineering/conditions-in-bash-scripting-if-statements)
- [Conditions operators](https://linuxhint.com/bash_conditional_statement/)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: I have a beginner experience with shell, variable and conditions that's why I did this task in a really smooth way. But still I need to read about the syntax especially when I was doing conditions. I was first using the < operator but apparently this is not the way it's written here because I keep getting an error message saying txt file doesn't exist. I did not able to save the screenshot of this because of issue 2. Because I was spending a lot of time with this, I ask my teammates to do a 'rubber ducky' session. And while I was running into my process again, I found the article about operators. And it was indeed the mistake I was doing.

[Issue 2:](https://github.com/techgrounds/techgrounds-agcdtmr/blob/main/00_includes/chatgpt-terminal-history.jpg) Friday, around 3 in the afternoon, my device gave up and lost all the history of my terminal from week one, the worst part is I did not save screenshots from Exercises 4 to 7. I first focus on Cron Jobs because I need other people's expertise on that. Then Friday night I continued and ask the best friend of every programmer on what steps to do and which command I can use to find the history of all the commands I used in the command line.

```
cat ~/.bash_history
```

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Label]()
