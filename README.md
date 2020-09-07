# rsa_encrypt
RSA encrypt/decrypt tool

Helps you to encrypt messages using someone else's public SSH RSA key and decrypting messages using your private SSH RSA key.

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

# Examples

## Import your private key

```
$ rsaenc -P -i ~/.ssh/id_rsa
```

## Import someone else's public key from file

```
$ rsaenc -I -i /tmp/prince_arthur.pub
```

```
$ rsaenc -L
prince_arthur.pem
```

## Import someone else's public key from string

```
$ rsaenc -I -a "prince_arthur_tmp" -s "ssh-rsa AAAAB3NzaC1yc2EAAAABABBAB...MeV7o"
```

```
$ rsaenc -L
prince_arthur.pem
prince_arthur_tmp.pem
```

## Encrypt a message

```
$ rsaenc -e -s "ssh root password: VHo&EdY%thjEGq6C" -r prince_arthur_tmp.pem
JMzmWrqqsWynxVGSEmmb48ele3u2jAzjgwNcbGZmjr/CFl2SRO4RvS10jx6JnNUsqjKqYDo20T5GEX+t/Dw0RDQFmTmP9yEuXyD6b1j70PIDM4mpTpOfPtVUoMejDHgVLxpoypCJ8DN9oxNQmnPWxotWjgZFmi33hdNqRODlVoMjWlwQixYQCcAVsnO+LI0K/4H0OxG5cO5vCMkqGnflSVmSg8vUpfI2eqffg35pL4XesgxPO/RoiZKtOB3ke0dX79A95kzSkm/RY1JG4Pch72Xb8yXpbNz/KSnzPr++ODYe+nV+ap3vg0UR2wSkXo6f3Px37LctFk2XTp4aPbq4ig==
```

## Decrypt a message

```
$ rsaenc -d -s "JMzmWrqvPhcBMDy1qcYvUTW/sIemgjmJHSQgGZmjr/CFl2SRO4RvS10jx6JnNUsqjKqYDo20T5GEX+t/Dw0RDQFmTmP9yEuXyD6b1j70PIDM4mpTpOfPtVUoMejDHgVLxpoypCJ8DN9oxNQmnPWxotWjgZFmi33hdNqRODlVoMjWlwQixYQCcAVsnO+LI0K/4H0kg8GNaviwryrhkVK2eqffg35pL4XesgxPO/RoiZKtOB3ke0dX79A95kzSkm/RY1JG4Pch72Xb8yXpbNz/KSnzPr++ODYe+nV+ap3vg0UR2wSkXo6f3PNb/93Ct2br4="
ssh root password: VHo&EdY%thjEGq6C
```

# Usage

```
Usage: rsaenc [-h] [-v] [-f] [-e|-d|-E|-I|-P] [-i filename] [-s payload] [-a alias]

Actions:
    -e|--encrypt	         Encrypt payload
    -d|--decrypt	         Decrypt payload
    -E|--export-pubkey	     Export your public key in a PEM format
    -I|--import-pubkey	     Import public key of a recipient
    -P|--import-privkey	     Import private key for decryption

Options:
    -i|--input-filename	     Input file for a selected action
    -s|--input-string	     Input payload as a string
    -a|--import-alias	     Alias for imported payload

Auxiliary:
    -f|--force          	 Force selected action
    -v|--verbose        	 Enable debug output
    -h|--help           	 Enable debug output

```
