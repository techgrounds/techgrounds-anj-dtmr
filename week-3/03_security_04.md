# Symmetrical Encryption

## Key terminology

- [ ] cryptography
- [ ] symmetrical encryption
- [ ] data at rest
- [ ] data in motion
- [ ] ciphers
- [ ] Caesar cipher
- [ ] Vigenère cipher
- [ ] Playfair cipher
- [ ] Rail Fence cipher
- [ ] Advanced Encryption Standard (AES)
- [ ] RSA cipher
- [ ] Elliptic Curve Cryptography (ECC) cipher

## Benodigdheden

- [x] The Slack channel your share with your entire cohort
- [x] A peer

## Opdrachten

- [x] Find one more historic cipher besides the Caesar cipher. Find two digital ciphers that are being used today.

- [x] Send a symmetrically encrypted message to one of your peers via the public Slack channel. They should be able to decrypt the message using a key you share with them. Try to think of a way to share this encryption key without revealing it to everyone. You are not allowed to use any private messages or other communication channels besides the public Slack channel.

Here's the step by step process how I completed the 2nd task:

1. Watch a lot of videos about basics of cryptography and symmetrical encryption.

2. Choose a symmetric encryption algorithm (like Advanced Encryption Standard (AES)) to encrypt a message. In this task I used [Blowfish](http://sladex.org/blowfish.js/) to generate a random encryption key to encrypt the message.

cipher: 4f6+LZ88hvDyiDK7BKj8qFV1ESwdBsgtSIxJm8tmMtTai934J0Q+ww==
key: decipher
clue: This is not the end. PNG steganography.

3. I generated an AI image using [bruzu](https://bruzu.com/demos/ai-image-generator-from-text). Then I used a [website](https://incoherency.co.uk/image-steganography/#unhide) to hide my final message. My peers need to unhide the photo using [image steganography](https://incoherency.co.uk/image-steganography/), to finally solve the hidden message.

- [x] Analyse the shortcomings of symmetric encryption for sending messages.

Symmetric Encryption seems more complicated for the people who are not techie. The user of SE need to securely share the encryption key. The messages passed between the users creates web traffic, hence, the lack of forward secrecy. The risk of a these key leading to the compromise of all messages encrypted with that key.

## Sources list used for solving the exercise

- [Notes](https://docs.google.com/document/d/1kr8jHxB2h0V1FQlj9B0YxTeSRYdq_yKb/edit#)
- [7 Cryptography Concepts EVERY Developer Should Know](https://www.youtube.com/watch?v=NuyzuNBFWxQ)
- [Cryptography: Crash Course Computer Science](https://www.youtube.com/watch?v=jhXCTbFnK8o&pp=ygUtdHdvIGRpZ2l0YWwgY2lwaGVycyB0aGF0IGFyZSBiZWluZyB1c2VkIHRvZGF5)
- [Generator](https://www.devglan.com/online-tools/rsa-encryption-decryption)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- By doing this task, do we need to hide the plain text message "inside" a photo?

Issue 2: By watching a lot of video about Encryption, I began to conclude that I needed to code my own algorithm. I did not know that I can use a random key generator tool available online. I come to that information when one of my team mates had questions and gave some tips on how they did the tasks. From there I could smoothly do the task.

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Task done! Made a fun game too**
![cipher](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-04-result.png)
