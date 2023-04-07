# LNX-02 Linux Machine Files and Directories

This projects taught us how to play around linux environment especially on how to create a new directory, save a new file inside a directory, move between paths using absolute and relative path, use a command that shows the list of all files and directories, use "sudo" command, use vim editor and how to save and quit from it and how to use a command that can show the text inside a .txt file, difference use of "/" "." "~".

Learned how to use these different commands:

- .(a single dot) - this represents the current directory.
- ..(two dots) - this represents the parent directory.
- cd .. - moves one level up
- cd ../.. - moves two level up
- man man - for accessing the manual from the command line
- :wq! - save and quit using vim editor

## Key terminology

- [ ] sudo
- [ ] man
- [ ] cat
- [ ] man
- [ ] pwd
- [ ] ls
- [ ] ls -l
- [ ] ls -a
- [ ] ls -la
- [ ] cd
- [ ] mkdir
- [ ] touch
- [ ] vim
- [ ] cat
- [ ] relative path
- [ ] absolute path
- [ ] tilde (~)
- [ ] root directory

## Benodigdheden

- [x] Your Linux machine

## Opdrachten

- [x] Find out your current working directory.
- [x] Make a listing of all files and directories in your home directory.
- [x] Within your home directory, create a new directory named ‘techgrounds’.
- [x] Within the techgrounds directory, create a file containing some text.
- [x] Move around your directory tree using both absolute and relative paths.

## Sources list used for solving the exercise

- [Files and Directories Notes](https://docs.google.com/document/d/1crYIGPafUBIUowuLPqdSP5rAC-MMtzxP/edit#heading=h.gjdgxs)
- [Absolute and Relative Pathnames in UNIX](https://www.geeksforgeeks.org/absolute-relative-pathnames-unix/)
- [E37: No write since last change (add ! to override)](https://www.javamadesoeasy.com/)
- [E45 readonly option is set (add ! to override)](https://askubuntu.com/questions/635779/e45-readonly-option-is-set-add-to-override)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: "Within the techgrounds directory, create a file containing some text." At first I could not understand what this exercise meant, it looks like it's only one task to create file with a text like normal word documents. But actually it consist of a lot of researching. First, I did not know I needed an editor, as a beginner the command line looks like a normal document with a lot of letter but actually is more complex, flexible than that. A teammate of mine, Curt, found out that we need an editor to write a text on a file. So by googling I found out about vim editor. Vim Editor apparently works even without using the sudo command before it, like this "sudo vim test.txt" and "vim test.txt" they work both, as I discovered. One issue using editor in the command line is that there's not interface or buttons the way I'm used too. I need to google how to type, save and quit. Also importantly, I need to make sure that I indeed put a text to my .txt file using "cat" command.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Used "pwd" command to find out my current working directory:**
![pwd](https://github.com/agcdtmr/angeline-cloud-10-repo/blob/main/00_includes/linux/pwd.png)

**Used "ls" command to make a listing of all files and directories in home directory:**
![ls](https://github.com/agcdtmr/angeline-cloud-10-repo/blob/main/00_includes/linux/ls.png)

**Used "mkdir" command to create a new directory named ‘techgrounds’:**
![mkdir](https://github.com/agcdtmr/angeline-cloud-10-repo/blob/main/00_includes/linux/mkdir.png)

**Used "vim" editor to create a file containing some text:**
![txt](https://github.com/agcdtmr/angeline-cloud-10-repo/blob/main/00_includes/linux/txt.png)

**Moved around my directory tree using both absolute and relative paths:**
![path](https://github.com/agcdtmr/angeline-cloud-10-repo/blob/main/00_includes/linux/path.png)
