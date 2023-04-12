# LNX-03 Working with text (CLI)

What is CLI?

Learned how to use these different commands:

- “>>” operator is used for utilizing the command’s output to a file, including the output to the file’s current contents.
- “>” operator is used to redirect the command’s output to a single file and replace the file’s current content.
- man grep
- man sudo
- man cat

## Key terminology

- [ ] standard input (stdin) is the keyboard
- [ ] standard output (stdout) is the terminal
- [ ] input redirection
- [ ] output redirection

## Benodigdheden

- [x] Your Linux machine
- [x] A text file with 2 lines of text

## Opdrachten

- [x] Use the echo command and output redirection to write a new sentence into your text file using the command line. The new sentence should contain the word ‘techgrounds’.

```
sudo echo "new sentence into your text file containing techgrounds" >> 03lnx.txt
```

[Check what I did](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-03-echo.png)

- [x] Use a command to write the contents of your text file to the terminal. Make use of a command to filter the output so that only the sentence containing ‘techgrounds’ appears.

```
cat 03lnx.txt
sudo echo "another line of text" >> 03lnx.txt
grep 'techgrounds' 03lnx.txt`

```

[Take a peek](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-03-grep.png)

- [x] Read your text file with the command used in the second step, once again filtering for the word ‘techgrounds’. This time, redirect the output to a new file called ‘techgrounds.txt’.

```
grep -o "techgrounds" 03lnx.txt > techgrounds.txt
cat techgrounds.txt
```

[Have a look](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-03-line2.png)

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1uC02n-QtDkjzmUd-23tMXtt9e9tcJRx4/edit#)
- [Using echo command](https://unix.stackexchange.com/questions/63658/redirecting-the-content-of-a-file-to-the-command-echo)
- [Grep](https://docs.oracle.com/cd/E19455-01/806-2902/6jc3b36dn/index.html)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

[Issue 1:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-03-issue1.png) I keep trying to put a txt file to my root folder, I could not understand the instructions clearly. I asked my teammates on how they understood the instructions word per word.

[Issue 2:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-03-issue2.png) I keep forgetting that I need to use sudo, and lost where to do the txt file. With often use of the terminal and keep having the same error message. My brain was able to remember that this error message is for that issue.

[Issue 3:](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-03-issue3.png) I first used cat command to write something to my txt file, but i could not understand the interface and keep typing anything and could not find the way how to exit (i dont know how i end up with find command which gave me a lot of permission denied too) until I remember I could use google to search for “how to exit cat command”. I found ctrl+d command.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Found out the difference between "grep -o "techgrounds" test.txt > techgrounds.txt" and "grep -i "techgrounds" test.txt", grep -i is used when we want to look for centain part of word that is part of a longer one:**
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-03-issue4.1.png)
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-1-includes/linux/lnx-03-issue4.png)
