# Passwords

## Key terminology

- [ ] Rainbow Table
- [ ] MD5 password hashes

## Benodigdheden

- [x] Your Linux machine
- [x] A peer
- [x] An online Rainbow Table like https://crackstation.net/

## Opdrachten

- [x] Find out what hashing is and why it is preferred over symmetric encryption for storing passwords.

- [x] Find out how a Rainbow Table can be used to crack hashed passwords.

- [x] Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table.

[1. 03F6D7D1D9AAE7160C05F71CE485AD31](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-07-md5.png)
[2. 03D086C9B98F90D628F2D1BD84CFA6CA](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-07-md51.png)

- [x] Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table.

![New User](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-07-new.png)

- [x] Despite the bad password, and the fact that Linux uses common hashing algorithms, you won’t get a match in the Rainbow Table. This is because the password is salted. To understand how salting works, find a peer who has the same password in /etc/shadow, and compare hashes.

![Salted Password](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-07-pass.png)

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1ngTMmDk8hX61yQQGFieqFLswh6UdoEGO)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [ ] What are some strategies for creating strong passwords, and how can I use these strategies to improve my security practices? passwords should be long and complex to make them more difficult to crack. Creating stronger passwords for my accounts and using a password manager to store them securely.
- [ ] How do hash functions work, and why are they important for storing passwords securely in a database? hash functions are used to convert passwords into a unique string of characters that cannot be reversed to reveal the original password. password hashes should be used to store passwords securely in a database, rather than storing plaintext passwords.
- [ ] What is MD5, and why is it considered vulnerable to certain types of attacks? How can I use this knowledge to choose more secure hash functions? MD5 is a widely used hash function that has been shown to be vulnerable to attacks, such as collision attacks and rainbow table attacks. I can apply this knowledge by using stronger and more secure hash functions, such as SHA-256, to hash my passwords and secure my accounts.
- [ ] What is salt, and how does it improve the security of password hashes? How can I ensure that all of my password hashes are salted properly? salt is a random value added to a password before hashing to make it more difficult to crack using a precomputed hash table or rainbow table.
- [ ] What is a rainbow table, and how can a strong salt protect against attacks that use rainbow tables? How can I ensure that my passwords are not vulnerable to these types of attacks? ainbow table is a precomputed table of password hashes that can be used to quickly crack passwords without having to compute the hashes from scratch. using a strong and unique salt for each password can make it more difficult for attackers to use rainbow tables to crack my passwords.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**This is the new user's salted password, it cannot be encrypted by a Rainbow Table:**
![Label](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-07-salt.png)
