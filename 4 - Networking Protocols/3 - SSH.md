# SSH

SSH stands for **Secure Shell**.

SSH is a netwroking protocol which allows two computer to securely connect with each other. It encrypts all the traffic between client and server to prevent from attacks.

SSH ek remote login protocol hai jo tumhare local system ko remote server se securely connect karne ke liye use hota hai. Matlab tum SSH ke through remote servers par connect karte ho aur remote server ko use kar sakte ho.

Matlab agar tumhare paas ek remote Linux server hai (for example — AWS EC2 instance, DigitalOcean droplet, ya koi cloud VM), to tum apne local computer se us server par SSH ke through connect hoke us par command chala sakte ho.

Ye ek cryptographic protocol hai jo ek client-server architecture par based hai:
- SSH Client: User ki machine (tumhara computer).
- SSH Server: Remote machine (jahan connect karna hai).

Dono ke beech connection fully encrypted hota hai, taaki koi attacker data intercept karke password ya command na dekh sake.

Lekin sabse important baat yeh hai —
- SSH ek secure channel banata hai between client aur server ke beech, jisme saara data encrypted hota hai.

Isliye tumhare username, password, ya koi command data plain text mein nahi jata — sab kuch encrypt hokar jata hai.

<br>

**Real Example**:

Tumhare paas ek Linux server hai cloud mein:
```
IP: 52.66.91.100
Username: ubuntu
```

Tum apne local machine se command likhte ho:
```
ssh ubuntu@52.66.91.100
```

Aur tumhara local system ka terminal ab remote server ke shell se connect ho jaata hai. Ab tum ```ls```, ```cat```, ```sudo```, ```apt``` install jaise commands remotely run kar sakte ho.

<br>
<br>

### Pehle Ke Time Par — Telnet Problem

SSH ke aane se pehle log Telnet protocol use karte the remote systems connect karne ke liye.

**Problem kya thi Telnet mein**:
- Telnet mein koi encryption nahi tha.
- Username aur password plain text mein network par transmit hota tha.
- Koi bhi attacker agar packets sniff kare (via tools like Wireshark), to easily password dekh sakta tha.
- Isse MITM (Man-in-the-Middle Attack) ka risk hota tha.

To is problem ko solve karne ke liye aaya — SSH.

<br>
<br>

### SSH Ka Full Form aur Origin

SSH = Secure Shell

Iska invention Tatu Ylönen ne 1995 mein kiya tha, ek Finnish researcher ne — jab usne dekha ki Telnet insecure hai.

Aaj ke time par OpenSSH sabse popular implementation hai (jo Linux systems mein by default aata hai).

<br>
<br>

### SSH Ke Major Components

SSH ke andar kuch major components hote hain:

| Component                    | Description                                                                         |
| ---------------------------- | ----------------------------------------------------------------------------------- |
| **SSH Client**               | Tumhare local system par installed hota hai, jo connection initiate karta hai.      |
| **SSH Server (sshd)**        | Remote machine par chal raha process, jo incoming SSH connections accept karta hai. |
| **Encryption Layer**         | Data ko encrypt aur decrypt karta hai secure communication ke liye.                 |
| **Authentication Mechanism** | Verify karta hai ki client valid hai ya nahi (password ya key ke through).          |

<br>
<br>

### How SSH Works Step by Step

Chalo ab step by step samjhte hain ki SSH connection establish hone ka process kya hota hai.

**Step 1: Connection Initiation**:

Jab tum SSH se connect karte ho, jaise:
```
ssh ubuntu@192.168.1.10
```
- Yahan ```ssh``` ek client hai.
- ```ubuntu``` username hai.
- ```192.168.1.10``` remote server ka IP hai.

Client (tumhara local PC) ek TCP connection open karta hai server ke port 22 par (by default SSH port 22 hota hai).

<br>

**Step 2: Server Identification aur Key Exchange**:

Jaise hi connection initiate hota hai:
- Server apni public host key bhejta hai client ko.
- Client usse verify karta hai (agar pehle kabhi connect kiya hai to ```.ssh/known_hosts``` file mein stored hota hai).
- Ab dono (client aur server) Diffie-Hellman (ya ECDH) use karke ek shared secret key generate karte hain. Is key ko session key bolte hain, ye dono ke paas same hoti hai, iski key se data encrypt aur decrypt hoga.
- Is point par dono ke paas ek same secret session key hoti hai jisse data encrypt/decrypt hota hai.

Ab communication ke liye ek symmetric encryption algorithm select hota hai (like AES, ChaCha20, Blowfish etc.). Symmetric encryption ka matlab — dono taraf same key use hoti hai encryption aur decryption ke liye.

<br>

**Step 3: Authentication Phase**:

Ye step hota hai jaha tumko apna password dalna hota hai verification ke liye ki client authorized user hai ya nahi.

Authentication ke 2 common method hote hain:
- 1. Password-Based Authentication
  2. Public Key Authentication (More Secure).

<br>

**1 - Password-Based Authentication**:

Client server ko username aur password bhejta hai (lekin encrypted channel ke through).

Example:
```
ssh ubuntu@192.168.1.10
```

Aur jab prompt aaye:
```
ubuntu@192.168.1.10's password:
```

Tum password daal kar login kar jaate ho.

<br>

**2 - Public Key Authentication (More Secure)**:

Yeh sabse recommended method hai.

Process:

1 - Tum apne local system par ek key pair generate karte ho:
```
ssh-keygen
```

Ye command do file banata hai:
- ```id_rsa``` (Private key).
- ```id_rsa.pub``` (Public key).

2 - Tum ```id_rsa.pub``` ko server par copy karte ho:
```
ssh-copy-id ubuntu@192.168.1.10
```
Ya manually add kar sakte ho ```/home/ubuntu/.ssh/authorized_keys``` file mein.


3 - Jab tum SSH connect karte ho:
- Client apni private key se ek digital signature banata hai.
- Server apni authorized_keys mein se client ke public key ko use karke verify karta hai.
- Agar match hota hai → login successful without password.

Ye method secure hoti hai kyunki private key kabhi transmit nahi hoti, sirf signature jaata hai.

<br>
<br>

### SSH Commands Example

| Command                                      | Description                 |
| -------------------------------------------- | --------------------------- |
| `ssh user@host`                              | Remote login                |
| `scp file.txt user@host:/path`               | Secure file copy            |
| `sftp user@host`                             | Secure file transfer        |
| `ssh -i key.pem user@host`                   | Use custom key              |
| `ssh -p 2222 user@host`                      | Connect on custom port      |
| `ssh -L 8080:localhost:80 user@host`         | Port forwarding             |
| `ssh -N -f -L 5901:localhost:5901 user@host` | Create tunnel without shell |

<br>
<br>

### Port Forwarding

**Pehle Samajho — Port Forwarding ka basic matlab kya hai?**:

Soch lo tumhare paas ek remote Linux server hai (for example AWS EC2), aur us server ke andar ek MySQL database chal raha hai on port 3306, lekin wo MySQL port internet pe open nahi hai (security ke liye).

Ab tum apne local laptop se directly MySQL se connect nahi kar sakte, kyunki firewall ya security group ne 3306 port block kiya hua hai.

Ab aise mein tum use karte ho — SSH Port Forwarding.

Yani tum SSH ke secure tunnel ke through apne laptop ke ek local port ko remote server ke ek port se jod dete ho.

<br>

**SSH Port Forwarding (a.k.a. Tunneling)**:

Port forwarding ka matlab hota hai:
- “Ek port se doosre port tak secure data forwarding karna via SSH tunnel.”

SSH tunnel ek encrypted pipe ki tarah kaam karta hai jisme data safe rehta hai, aur beech mein koi sniff nahi kar sakta.

<br>

**Port Forwading ke 3 Types hote hain**:

| Type                        | Direction              | Common Usage                                               |
| --------------------------- | ---------------------- | ---------------------------------------------------------- |
| 1️⃣ Local Port Forwarding   | Local → Remote         | Remote services ko local system pe access karna            |
| 2️⃣ Remote Port Forwarding  | Remote → Local         | Local service ko remote system pe access karna             |
| 3️⃣ Dynamic Port Forwarding | Flexible (SOCKS proxy) | Internet traffic ko SSH ke through route karna (VPN jaise) |

<br>

**1 - Local Port Forwarding (Most Common)**:

Tumhare local port ka data remote server ke kisi port tak securely bhejna. Matlab Remote services ko local system pe access karna.

Example:

Soch lo tumhare remote server par MySQL chal raha hai on port 3306, aur tum apne laptop se usse connect karna chahte ho.

Command:
```
ssh -L 3336:localhost:3306 ubuntu@192.168.1.10
```
Breakdown:
| Part                  | Meaning                              |
| --------------------- | ------------------------------------ |
| `-L`                  | Local port forwarding                |
| `3336`                | Tumhare laptop ka local port         |
| `localhost:3306`      | Remote server ke andar MySQL ka port |
| `ubuntu@192.168.1.10` | Remote SSH server login details      |

Ab kya hota hai:
- Tumhare local laptop ka port 3336 ek tunnel banata hai remote server ke port 3306 tak.
- Jab tum apne laptop se connect karte ho ```localhost:3336``` par, SSH wo data tunnel ke andar se remote server ke MySQL tak bhej deta hai.

To ab tum MySQL client mein likh sakte ho:
```
mysql -h 127.0.0.1 -P 3336 -u root -p
```
Aur ye actually remote MySQL se connect ho jaayega — securely!

Security benefit:
- MySQL port (3306) world ke liye open nahi hai.
- Sirf SSH tunnel ke through access hota hai.
- Saara data encrypt hota hai.

<br>

**2 - Remote Port Forwarding**

Local service ko remote system pe access karna.

Remote server ke port ko local machine ke port ke saath link karna. Matlab remote system tumhare local machine tak securely access kar sake.

Example:

Soch lo tumhare local laptop pe ek web app chal rahi hai on port 3000, aur tum chahte ho remote server se wo access ho sake.

Command:
```
ssh -R 9090:localhost:3000 ubuntu@192.168.1.10
```

Breakdown:
| Part                  | Meaning                              |
| --------------------- | ------------------------------------ |
| `-R`                  | Remote port forwarding               |
| `9090`                | Remote server pe open hone wala port |
| `localhost:3000`      | Tumhare local system ka port         |
| `ubuntu@192.168.1.10` | Remote SSH server details            |

Ab remote server pe koi bhi user agar localhost:9090 access karega, to wo tumhare local machine ke 3000 port tak tunnel ke through jaayega.

Matlab remote server tumhare local web app ko dekh sakta hai.

Security benefit:
- Tumhare local web app directly internet pe expose nahi hoti.
- Sirf SSH tunnel ke andar se access hoti hai.

