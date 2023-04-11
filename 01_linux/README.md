# LNX-01 Setting up SSH-connection to the virtual machine using Linux machine

<!-- What is Linux? -->

## Key terminology

- [ ] Operating system or OS
- [ ] graphical user interface (GUI)
- [ ] command line interface (CLI)
- [ ] virtual machine (VM)
- [ ] hypervisor
- [ ] type 1 hypervisor
- [ ] Ubuntu

## Benodigdheden

- [x] The email from your Learning Coach about the VM you'll use
* SSH Client
* Username
* Keyfile .pem
* Hostname IP Address
* Port number
- [x] If you’re using a Windows machine: OpenSSH or If you’re using a MacOS or Linux machine: Access ssh using your terminal

## Opdrachten

- [x] Make an SSH-connection to your virtual machine. SSH requires the key file to have specific permissions, so you might need to change those.
- [x] When the connection is successful, type whoami in the terminal. This command should show your username.

**Here's the detailed steps I did using a mac OS Ventura 13.0.1:**

1. I download the .pem file from the learning coach and saved it to the .ssh folder. You may access this hidden folder using command+shift+.

Issue #1: I actually first saved it to downloads but I had permissions issue and when I try to see the permission using 'ls -la' command I get: "total 0 ls: .: Operation not permitted". If you don't have this issue, continue to the next step.

2. Open the terminal and make sure that you are at the right directory, which was for me is "/root/.ssh". To go to the right directory use the commands:

```
cd pathname
```

or cd+space then drag the .ssh folder to the terminal, then press Enter.

3. Modify, copy and paste this line of code to your terminal

```
ssh -i containerName username@servername -p sshportnumber
```

Issue #2: I received a warning:

```
WARNING: UNPROTECTED PRIVATE KEY FILE!"
Permissions 0644 for 'containerName.pem' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "containerName.pem": bad permissions
username@servername: Permission denied (publickey).
```

I solved it using `chmod 600 containerName.pem`

Paste again "ssh -i containerName username@servername -p sshportnumber".
If everything is fine you may receive a message like this:

```
The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

4. If the connection is successful, type "whoami" in the terminal. This command should show your username

## Sources list used for solving the exercise

- [Linux Notes](https://docs.google.com/document/d/1QRNuKlcg6Ek-baVAafFjWQOzzGDlSE6Q/edit#)
- [Article to solve the permission issue](https://superuser.com/questions/692538/why-am-i-getting-permission-denied-publickey-after-chmod-600)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: I was confuse on the ssh key that was already saved in my computer and the ssh key (the .pem file) given by our learning coach. I asked my teammates to show how they did it and how they understand it. Everyone from the team use windows OS but they patiently helped me to find a solution for this while I share my screen. Using our googling beginner skills, we were able to find existing issues online and tried different code like using chmod 400 command to change permission, or change the placement of -i inside the line or think if the command line is case sensitive. But at the end the real issue was, I was calling the right command in the wrong directory and the file does not have the correct permissions. But with the help of their presence I was able to use the "rubber ducky" principle and run through the code from the beginning and repeat the process. We were all cheering at the end, because of that teamwork! This is a big win for the team.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Successfully set up SSH-connection to the virtual machine using Linux machine:**
![whoami](https://github.com/agcdtmr/angeline-cloud-10-repo/blob/main/00_includes/linux/whoami.png)
