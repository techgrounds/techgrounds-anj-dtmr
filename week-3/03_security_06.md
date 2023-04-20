# Public Key Infrastructure (PKI)

## Key terminology

- [ ] Public Key Infrastructure (PKI)
- [ ] digital certificates
- [ ] public-key encryption
- [ ] X.509 standard.

## Benodigdheden

- [x] Your Linux machine
- [x] An internet browser

## Opdrachten

- [x] Create a self-signed certificate on your VM.

![SSL Certificate]()

- [x] Analyze some certification paths of known websites (ex. techgrounds.nl / google.com/ ing.nl).

![]()

- [x] Find the list of trusted certificate roots on your system (bonus points if you also find it in your VM).

![Certs]()

Here's the step by step process how I completed the 1st task:

1. Update my virtual machine and allow Apache to open up the http and https ports using the commands below

```
sudo apt-get update
sudo apt install apache2
sudo systemctl status apache2
sudo ufw allow "Apache Full"
sudo ufw status
```

2. Install the SSL module: Run the following command to install the SSL module in Apache and installing OpenSSL is a prerequisite for enabling SSL in Apache, and sudo a2enmod ssl is a specific command that enables the SSL module in Apache.

```
sudo apt install openssl
sudo a2enmod ssl
cd /etc/ssl
ls
cd ~
sudo systemctl restart apache2
sudo systemctl status apache2
```

3. Create a certificate and private key without a pem passphrase

```
sudo openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -days 365 -nodes
```

4. Configure Apache to use the SSL certificate: Edit the Apache SSL configuration file by running the following command

```
sudo nano /etc/apache2/sites-available/default-ssl.conf
```

In this file, add the following lines:

SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

This will tell Apache to use the self-signed certificate and private key that we just created.

5. Enable the SSL virtual host: Enable the SSL virtual host and finally, restart Apache by running the following command:

```
sudo a2ensite default-ssl.conf
sudo systemctl restart apache2
```

This will restart Apache and apply the SSL configuration changes.

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1ngTMmDk8hX61yQQGFieqFLswh6UdoEGO)
- [What is Public Key Infrastructure (PKI)?](https://www.youtube.com/watch?v=0ctat6RBrFo)
- [OpenSSL command cheatsheet](https://www.freecodecamp.org/news/openssl-command-cheatsheet-b441be1e8c4a/#b723)
- [How To Create a Self-Signed SSL Certificate for Apache in Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-20-04)
- [X.509 Digital Certificate](https://www.youtube.com/watch?v=FrYLdfYj1co)
- [Private keys, public keys, and digital certificates](https://www.ibm.com/docs/en/sia?topic=osdc-private-keys-public-keys-digital-certificates-27)
- [How to Create and Install a Self-Signed SSL Certificate on Ubuntu 20.04](https://www.atlantic.net/dedicated-server-hosting/how-to-create-and-install-a-self-signed-ssl-certificate-on-ubuntu-20-04/)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions

- [x] what is the goal of a certificate? - According to chatGPT, An analogy for a self-signed certificate could be a handwritten note that you sign and give to someone you trust. The note contains sensitive information that you want to keep secure, so you put it in an envelope and seal it with your signature. When the recipient receives the note, they know it came from you because they recognize your handwriting and signature, even though it wasn't verified by a third party.

Similarly, a self-signed certificate is like a digital signature that a server uses to encrypt and authenticate its communications with clients over the internet. The server signs its own certificate using its private key, which is then used to establish an encrypted connection with clients. While the certificate isn't verified by a trusted third party, clients can still trust it if they know and recognize the server's digital signature.

Issue 2:

## Results

Brief description of the result of the exercises. An image can speak more than a thousand words.

**Description:**
![Label]()
