# rsa_encrypt
RSA encrypt/decrypt tool

Helps you to encrypt data using someone else's public SSH RSA key and decrypting messages using your private SSH RSA key.

# Releases

rsaenc — [Download](https://github.com/reinvented-stuff/rsa_encrypt/releases/latest/download/rsaenc)

# Installation

There are several options of how to install the software.

## Install on RHEL/CentOS 8

Not available yet

## Install on RHEL/CentOS 7

Yum repository URL: [https://yum.reinvented-stuff.com/rhel/7/](https://yum.reinvented-stuff.com/rhel/7/)  
Yum configuration: [reinvented-stuff.repo](https://yum.reinvented-stuff.com/rhel/7/reinvented-stuff.repo)  
GPG Public Key: [RPM-GPG-KEY-RNVSTFF-7](https://yum.reinvented-stuff.com/rhel/7/RPM-GPG-KEY-RNVSTFF-7)  

### Add Reinvented Stuff's Yum repository

In order to use our repository, you can use `yum-config-manager` tool to fetch .repo file from our server and include it to the local Yum configuration. The repository will become available right away.

Alternatively you can manually download and copy `reinvented-stuff.repo` file into `/etc/yum.repos.d` on your server.

<details>
    <summary>Adding Reinvented Stuff Yum repository</summary>

```
$ sudo yum-config-manager --add-repo https://yum.reinvented-stuff.com/rhel/7/reinvented-stuff.repo
Loaded plugins: fastestmirror
adding repo from: https://yum.reinvented-stuff.com/rhel/7/reinvented-stuff.repo
grabbing file https://yum.reinvented-stuff.com/rhel/7/reinvented-stuff.repo to /etc/yum.repos.d/reinvented-stuff.repo
repo saved to /etc/yum.repos.d/reinvented-stuff.repo
```

</details>

### Install package using yum


<details>
    <summary>Installing package</summary>

```
$ sudo yum install rsaenc
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.nodesdirect.com
 * epel: reflector.westga.edu
 * extras: mirror.team-cymru.com
 * updates: mirror.ash.fastserv.com
Resolving Dependencies
--> Running transaction check
---> Package rsaenc.x86_64 0:1.0.7-1 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=======================================================================================
 Package          Arch             Version            Repository                  Size
=======================================================================================
Installing:
 rsaenc           x86_64           1.0.7-1            reinvented-stuff            13 k

Transaction Summary
=======================================================================================
Install  1 Package

Total download size: 13 k
Installed size: 23 k
Is this ok [y/d/N]: y
Downloading packages:
rsaenc-1.0.7-1.x86_64.rpm                                       |  13 kB  00:00:00     
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : rsaenc-1.0.7-1.x86_64                                               1/1 
  Verifying  : rsaenc-1.0.7-1.x86_64                                               1/1 

Installed:
  rsaenc.x86_64 0:1.0.7-1                                                              

Complete!
```
</details>

## Install on Debian/Ubuntu

Apt repository URL: [https://deb.reinvented-stuff.com/](https://deb.reinvented-stuff.com/)  
Apt configuration: [reinvented-stuff.list](https://deb.reinvented-stuff.com/reinvented-stuff.list)  
GPG Public Key: [RPMDEB-GPG-KEY-RNVSTFF](https://deb.reinvented-stuff.com/DEB-GPG-KEY-RNVSTFF)  

### Add our apt repository to your system

```bash
$ curl -fsS "https://deb.reinvented-stuff.com/reinvented-stuff.list" -o - | sudo tee "/etc/apt/sources.list.d/reinvented-stuff.list"
```

### Import our GPG Key so apt could verify the packages authenticity
```bash
$ curl -fsS "https://deb.reinvented-stuff.com/DEB-GPG-KEY-RNVSTFF" | sudo apt-key add -
```

### Install rsaenc

```bash
sudo apt update
sudo apt install rsaenc
```

## MacOS/OS X/Darwin/FreeBSD

Download the latest version of the script:
```
$ cd ~
$ curl -OLv "https://github.com/reinvented-stuff/rsa_encrypt/releases/latest/download/rsaenc"
```

Make the script executable:
```
$ chmod a+x rsaenc
```

Move it to $PATH location (optional):
```
$ sudo mv rsaenc /usr/bin/rsaenc
```

Start using rsaenc:
```
$ rsaenc -h
```
or without optional step:
```
$ ~/rsaenc
```

# Generate RSA keypair

## Linux/FreeBSD/MacOS/OS X/Darwin

Check if you already have an RSA private key:
```
$ ls ~/.ssh/id_rsa && echo "Found" || echo "Not found"
```

If no private keys found, or you'd like to generate a new one:
```
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/username/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/username/.ssh/id_rsa.
Your public key has been saved in /home/username/.ssh/id_rsa.
The key fingerprint is:
SHA256:SpeHKhgE8jvpHcKJykcEepi7THTk9WSjAodqOdTS9bY username@laptop.local
The key's randomart image is:
+---[RSA 2048]----+
|oo+o.o +         |
|oO*o. * .        |
|*.*= . +         |
|oXo+. . .o       |
|+.X.. .ES .      |
|=o.* o + .       |
|ooo.o o          |
|  .  .           |
|                 |
+----[SHA256]-----+
```

Now you can import your private key using rsaenc tool.

# Examples

## Import your private key

In order to be able to decrypt messages, you need to import your ssh-rsa private key. It will be duplicated into the Private Key Storage and converted into PEM format.

```
$ rsaenc -P -i ~/.ssh/id_rsa
```

## Import someone else's public key from file

You can add recipient's ssh-rsa public key so you could use short descriptive name on the encrypting stage. For both, files and strings you can set an alias, so you could pick a better name for further usage.

Here is an example of how to import an ssh-rsa key from a file:
```
$ rsaenc -I -i /tmp/prince_arthur.pub
```

List currently available public keys:
```
$ rsaenc -L
PUBLIC KEYS:
1   prince_arthur.pem

PRIVATE KEYS:
1   id_rsa.pem

DEFAULT: id_rsa.pem
```

## Import someone else's public key from string

There are situations when people send their public keys to you in plaintext over a messenger or email rather than as an attached file. You in this case you can use `-s "ssh-rsa key content"` parameter.

That's how you can import a plaintext ssh-rsa key:
```
$ rsaenc -I -a "prince_arthur_tmp" -s "ssh-rsa AAAAB3NzaC1yc2EAAAABABBAB...MeV7o"
```

List currently available public keys:
```
$ rsaenc -L
PUBLIC KEYS:
1   prince_arthur.pem
2   prince_arthur_tmp.pem

PRIVATE KEYS:
1   id_rsa.pem

DEFAULT: id_rsa.pem
```

## Remove a key from key storage

You might want to remove some public or private keys from the internal key storage. 

Remove a public key:
```
$ rsaenc -R -b id_rsa_2048.pub.pem
Successfully removed public key: id_rsa_2048.pub.pem
```

Remove a private key:
```
$ rsaenc -R -k id_rsa_1024.pem
Delete 'id_rsa_1024.pem' (y/n)? y
Successfully removed private key: id_rsa_1024.pem
```

Remove a private key, auto confirmation:
```
$ rsaenc -R -f -k id_rsa_1024.pem
Successfully removed private key: id_rsa_1024.pem
```

## Encrypt a message

Message encryption works in the same manner as public key import. Pick what is best for you and either encrypt a file contents, or a plaintext string.

Encrypt a file using recipient's RSA Key:
```
$ echo -n "ssh root password: VHo&EdY%thjEGq6C" > ~/root_password.txt
$ rsaenc -e -i ~/root_password.txt -r prince_arthur_tmp.pem
JMzmWrqqsWynxVGSEmmb48ele3u2jAzjgwNcbGZmjr/CFl2SRO4RvS10jx6JnNUsqjKqYDo20T5GEX+t/Dw0RDQFmTmP9yEuXyD6b1j70PIDM4mpTpOfPtVUoMejDHgVLxpoypCJ8DN9oxNQmnPWxotWjgZFmi33hdNqRODlVoMjWlwQixYQCcAVsnO+LI0K/4H0OxG5cO5vCMkqGnflSVmSg8vUpfI2eqffg35pL4XesgxPO/RoiZKtOB3ke0dX79A95kzSkm/RY1JG4Pch72Xb8yXpbNz/KSnzPr++ODYe+nV+ap3vg0UR2wSkXo6f3Px37LctFk2XTp4aPbq4ig==
```

Encrypt a plaintext message:
```
$ rsaenc -e -s "ssh root password: VHo&EdY%thjEGq6C" -r prince_arthur_tmp.pem
JMzmWrqqsWynxVGSEmmb48ele3u2jAzjgwNcbGZmjr/CFl2SRO4RvS10jx6JnNUsqjKqYDo20T5GEX+t/Dw0RDQFmTmP9yEuXyD6b1j70PIDM4mpTpOfPtVUoMejDHgVLxpoypCJ8DN9oxNQmnPWxotWjgZFmi33hdNqRODlVoMjWlwQixYQCcAVsnO+LI0K/4H0OxG5cO5vCMkqGnflSVmSg8vUpfI2eqffg35pL4XesgxPO/RoiZKtOB3ke0dX79A95kzSkm/RY1JG4Pch72Xb8yXpbNz/KSnzPr++ODYe+nV+ap3vg0UR2wSkXo6f3Px37LctFk2XTp4aPbq4ig==
```

## Decrypt a message

Decrypt a plaintext message:
```
$ rsaenc -d -s "JMzmWrqvPhcBMDy1qcYvUTW/sIemgjmJHSQgGZmjr/CFl2SRO4RvS10jx6JnNUsqjKqYDo20T5GEX+t/Dw0RDQFmTmP9yEuXyD6b1j70PIDM4mpTpOfPtVUoMejDHgVLxpoypCJ8DN9oxNQmnPWxotWjgZFmi33hdNqRODlVoMjWlwQixYQCcAVsnO+LI0K/4H0kg8GNaviwryrhkVK2eqffg35pL4XesgxPO/RoiZKtOB3ke0dX79A95kzSkm/RY1JG4Pch72Xb8yXpbNz/KSnzPr++ODYe+nV+ap3vg0UR2wSkXo6f3PNb/93Ct2br4="
ssh root password: VHo&EdY%thjEGq6C
```

Decrypt a file:
```
$ rsaenc -d -i root_password.txt.enc
ssh root password: VHo&EdY%thjEGq6C
```

Decrypt with a certain private key:
```
$ rsaenc -L 
PUBLIC KEYS:
1   id_rsa_1024.pem
2   id_rsa_1599502578.pem
3   id_rsa_2048.pem
4   id_rsa_4096.pem
5   localhost.pem
6   laptop.pem

PRIVATE KEYS:
1   id_rsa.pem
2   id_rsa_1024.pem
3   id_rsa_2048.pem
4   id_rsa_4096.pem

DEFAULT: id_rsa_1024.pem
```

```
$ rsaenc -d -i root_password.txt.enc -k id_rsa_4096.pem
ssh root password: VHo&EdY%thjEGq6C
```


## Default private key

You can choose your default private key in order to save time on puching in a decryption command. If you have a primary private key you use most of the time, use `-D -k your_private_key.pem` parameters to manipulate default private key.

The first imported private key will be set as default.

First start:
```
$ ./rsaenc -L
PUBLIC KEYS:

PRIVATE KEYS:

DEFAULT: 
```

Imported the first private key:
```
$ ./rsaenc -P -i id_rsa_1024
Your identification has been saved with the new passphrase.
Saved as '/home/username/.local/rsaenc/private/id_rsa_1024.pem'
```

After the first import:
```
$ ./rsaenc -L
PUBLIC KEYS:

PRIVATE KEYS:
1   id_rsa_1024.pem

DEFAULT: id_rsa_1024.pem
```

# Maximum message length

Message length limit depends on your private key. There are some research results:

```
$ ./rsaenc -e -s "${CONTENT_OF_117_CHARS}" -r id_rsa_1024.pem
ok

$ ./rsaenc -e -s "${CONTENT_OF_118_CHARS}" -r id_rsa_1024.pem
fail
```

```
bash-3.2$ ./rsaenc -e -s "${CONTENT_OF_245_CHARS}" -r id_rsa_2048.pem
ok

bash-3.2$ ./rsaenc -e -s "${CONTENT_OF_246_CHARS}" -r id_rsa_2048.pem
fail
```

```
bash-3.2$ ./rsaenc -e -s "${CONTENT_OF_501_CHARS}" -r id_rsa_4096.pem
ok

bash-3.2$ ./rsaenc -e -s "${CONTENT_OF_502_CHARS}" -r id_rsa_4096.pem
fail
```

# Usage

```
Usage: rsaenc [-h] [-v] [-f] [-e|-d|-E|-I|-P|-L|-D|-R] [-r keyname] [-b keyname] [-k keyname] [-i filename] [-s payload] [-a alias]

Actions:
    -e|--encrypt           Encrypt payload
    -d|--decrypt           Decrypt payload
    -E|--export-pubkey     Export your public key in a PEM format
    -I|--import-pubkey     Import public key of a recipient
    -P|--import-privkey    Import private key for decryption
    -L|--list-keystorage   List imported keys
    -D|--set-default       Choose default private key to use
    -R|--remove-key        Remove a key

Options:
    -i|--input-filename    Input file for a selected action
    -s|--input-string      Input payload as a string
    -a|--key-alias         Alias of/for current key
    -k|--private-key       Private key to use
    -b|--public-key        Public key to use
    -r|--recipient         Recipient's public key name

Auxiliary:
    -f|--force             Force selected action
    -v|--verbose           Enable debug output
    -h|--help              Show help

```

# Quick start

## On the very start

Nothing is imported on the first start. You'll need to import someone else's RSA Public Key to encrypt messages for them and/or your RSA Private Key so you could decrypt data sent to you by someone else.

```
$ ./rsaenc -L
PUBLIC KEYS:

PRIVATE KEYS:

DEFAULT: 
```

## Start encrypting for someone else

1. Import recipient's public key
2. Veryfy imported key
3. Encrypt data
4. Pass encrypted blob to the recipient

## Start receiving encrypted data

1. Import your private key
2. Verify imported key
3. Export your public key
4. Pass your public key to the sender
5. Decrypt encrypted data received from the sender
