# Asymmetric encryption

## Key terminology

- [ ] Asymmetric encryption
- [ ] encryption key
- [ ] decrypt
- [ ] public key
- [ ] private key

## Benodigdheden

- [x] The Slack channel your share with your entire cohort
- [x] A peer
- [x] A key pair generator like https://travistidwell.com/jsencrypt/demo/

## Opdrachten

- [x] Generate a key pair.

Public key:

MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCfQR1FJnvzV85vEUn0l/gXXRUXei+WQdXC9j8zbtNwb+w1CFVGo8yPuYftnvHeOIBgGrtj24wu0rKnWX58NndBDkfa91UEjoqsx7Wn5Eivv6C991FkUuX3iLSJ4WKDCU4uEPDpuSbLJYlg9EoyHi8XOYfSfSt0rtwFXvJdfHUrLQIDAQAB

Private key = RSA_Private_Key (Saved my private rsa key to a .env file, then told my .gitignore file to ignore it)

- [x] Send an asymmetrically encrypted message to one of your peers via the public Slack channel. They should be able to decrypt the message using a key. The recipient should be able to read the message, but it should remain a secret to everyone else. You are not allowed to use any private messages or other communication channels besides the public Slack channel.

1st Message:
eFPFGKw1dXwPx7KPK1SaczNdUVUNWocqvPCUgR7Ph3NU0VJTYNH/Zu9Aaf1UEn1jViPTzlBTDRi0zJEbueeBTaKNCy4j5LwgSbVQRsr5AeY0VO4AT9B6zJWKJi44bLBb8xXIndxvcBG0f8vfGLymbKr/7pM2Z8IoPLSLM/Exm5A=

![Message](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-05-result1.png)

- [x] Analyse the difference between this method and symmetric encryption.

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1ngTMmDk8hX61yQQGFieqFLswh6UdoEGO)
- [RSA](https://www.devglan.com/online-tools/rsa-encryption-decryption)
- [decription](https://www.javainuse.com/aesgenerator)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: I think without my teammates discussion about the task, I can't do this one in a very smooth way. I'm not sure if that helps me or if that way of answering the task is helpful for me. But one thing is for sure, it lessen my struggles :D

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Played around my "secret" message using the public and private key:**
![result](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/00_includes/week-3-includes/sec-05-result.png)
