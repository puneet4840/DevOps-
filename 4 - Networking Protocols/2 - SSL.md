# SSL (Secure Sockets Layer)

SSL ka full form hai **Secure Sockets Layer**.

SSL ek security protocol hai jo client aur server ke beech mein encrypted data transfer karta hai.

SSL ek security protocol hai jo client jaise (browser) aur server jaise (website) ke beech mein encrypted link banaata hai. Matlab jab bhi koi sensitive info (jaise card number, password) website par daalte ho, SSL ensure karta hai ki wo data safe tareeke se, encryption ke saath, client aur server ke beech transfer ho.

SSL (Secure Sockets Layer) ek security protocol hai jo client aur server ke beech hone wali communication ko encrypt (i.e. secure) karta hai. Matlab client aur server ke beech mein data ko encrypt karke bhejta hai.

<br>
<br>

### SSL kyu use karte hain?

Jab hum apne laptop mein browser se koi website access karte hain to humara browser jis server pe website host hai us server ko request bhejta hai matlab browser-server ko data bhej rha hai.

Client se server par aur server se client par data bhejne ke liye (matlab client-server communication ke liye) protocol ka use hota hai. HTTP (HyperText Transfer Protocol) hoti hai jo client se server par web data (web page, images, etc) bhejti hai. 

Jab aapka browser (client) kisi website (server) se connect hota hai, to normally jo data jaata hai wo plain text hota hai. Ye HTTP protocol ke through data jata hai. HTTP protocol mein koi bhi security nahi hoti hai, data plain text mein server tak pahunchta hai.

Suppose tum banking website par login kar rhe ho apne username aur password ka use karke. Agar banking website HTTP protocol pe chal rhi hai to username aur password plain text mein server tak jayenge, ese mein agar koi bhi attacker, hacker ya snooper data ko beech mein se hi dekhna chahe to wo username aur password sniff kar sakta hai, aur bank account ko hack kar sakta hai. Matlab data chura sakta hai.

To ye data hack se bachne ke liye SSL ka use kiya jata hai. Koi hacker data ko hack na karle isliye SSL ka use kiya jata hai.

SS data ko encrypt karta hai, jisse wo data kuch meaningless random characters ban jaata hai aur attacker usse samajh nahi sakta. Encrypted data client se server aur server se client par transfer karta hai.

<br>

**SSL ka Purpose**:

SSL ka main kaam 3 cheezon pe based hai, matlab ye 3 kaam karta hai:
- Encryption:
  - Data ko encrypt yani (meaningless random characters) bana dena taaki koi attacker samajh na sake.

- Authentication:
  - Client ye verify kare ki jisse wo baat kar raha hai wo original server hi hai, koi fake nahi (jaise phishing site).
 
- Integrity:
  - Ye ensure karna ki data transfer ke dauran modify nahi hua.

<br>

**Real-life example samjho**:

Imagine karo tum bank ke website pe jaake apna password aur account number daal rahe ho.

Agar website ke paas SSL nahi hai, to:
- Tumhara browser → "password123" → Network → Server ko bhejta hai.

Ye data plain text main travel karega. Agar koi hacker beech main sniff kare to usko password123 seedha mil jaayega.

Lekin agar website SSL-enabled hai (HTTPS), to ye data encrypt hoke kuch aisa ban jaata hai:
- Tumhara browser → "x@#a9vC1%8" (encrypted gibberish) → Network → Server ko bhejta hai.

Ab agar koi hacker packet capture bhi kare (Wireshark ya tcpdump se), to usse sirf encrypted data dikhega, original password nahi.
 
<br>
<br>

### SSL vs TLS

Aaj ke time pe SSL technically old ho chuka hai, aur uska modern version TLS (Transport Layer Security) use hota hai.

Phir bhi log “SSL” bolte hain, but real meaning hai TLS 1.2 or 1.3 — ye backward compatible versions hain.

| Term            | Full Form                | Status     | Typical Use               |
| --------------- | ------------------------ | ---------- | ------------------------- |
| SSL 1.0/2.0/3.0 | Secure Sockets Layer     | Deprecated | Old                       |
| TLS 1.0/1.1     | Transport Layer Security | Deprecated | Old                       |
| TLS 1.2/1.3     | Transport Layer Security | Active     | Modern secure connections |

So jab bhi koi bolta hai “SSL certificate”, wo actually TLS certificate hota hai.

<br>
<br>

### Encryption kya hota hai

Humne uper ye padha ki SSL data ko encrypt karta hai, lekin ye encryption hai kya samjhte hain.

Encryption ek process hai jisme plain text ko secret code mein convert kiya jata hai.

Encryption ek aisi security process hai jisme kisi readable data (plain text) ko ek secret coded format (cipher text) mein convert kar dete hain taaki koi unauthorized person ya hacker use samajh na sake.

Encryption ek aisa process hai jisme data ko ek readable format (plain text) se unreadable format (cipher text) main convert kiya jaata hai, taaki koi unauthorized person usse samajh na sake.

<br>
<br>

### Encryption Kaise Kaam Karta Hai?

Encryption mein do main cheezein hoti hain:
- Plaintext: Yeh wo original data hota hai jo tum bhejna chahte ho, jaise “MeraPass123” ya credit card number.
- Ciphertext: Yeh wo encrypted data hota hai jo plaintext ko secret code mein convert karne ke baad banta hai, jaise “Xyz789!@#”.

Encryption ke liye ek key ka use hota hai, jo ek tarah ka password ya formula hota hai. Is key ke through data ko encrypt (code mein badla jata hai) aur decrypt (wapas original form mein laaya jata hai) kiya jata hai.

- **User Data** — e.g. “Hello Puneet”.
- **Algorithm Choose Kiya** — e.g. AES.
- **Key Generate Hui** — e.g. ```9F1A2C3E5B...```.
- **Algorithm ne Key use karke Data Encrypt Kiya**.
- **Output**: Ciphertext — e.g. ```Yt@#12uA!98```.

Ab agar kisi ne ye ciphertext pakad liya, to bina key ke usse kuch nahi milne wala.

<br>
<br>

### Types of Encryption:

Encryption two types ka hota hai:
- Symmetric Encryption.
- Asymmetric Encryption.

<br>

**Key kya hota hai?**:

Key ek string hoti hai ya numbers ka group hota hai, jo encryption mein use hoti hai.

<br>

**Symmetric Encryption**:

Key se data ko encrypt aur decrypt kiya jata hai.

Symmetric Encryption mein ek hi key se data ko encrypt karte hain aur decrypt bhi karte hai. Yahan sender and receiver dono ke paas ek hi secret key hoti hai.

Isme encryption aur decryption dono ke liye ek hi key use hoti hai.

Example of Keys:
- AES.
- DES.
- 3DES.
- Blowfish.
- ChaCha20.

Example:
```
Plaintext:  Hello Puneet
Key:        12345
Encrypted:  XyZ@#T!1%
```

Ab agar tumhare paas ye hi key (12345) hai, to tum ise decrypt karke asli message dekh sakte ho.

<br>

**Pros**:
- Fast performance.
- Low CPU usage.
- Perfect for encrypting large data (files, backups, etc.)

**Cons**:
- Key management difficult hota hai (key dono parties ko securely share karni padti hai).
- Agar key leak ho gayi, pura system compromised ho jaata hai.

<br>

**Real-World Examples**:
- ZIP file password protection.
- Disk encryption (BitLocker, LUKS).
- Database encryption (AES-256).
- SSL/TLS me “Session key” symmetric hoti hai (for speed).

<br>
<br>

**Asymmetric Encryption**:

Key se data ko encrypt aur decrypt kiya jata hai.

Asymmetric Encryption mein do alga-alag keys hoti hain data ko encrypt aur decrypt karti hain.

- Public Key → Data ```encrypt``` karne ke liye.
- Private Key → Data ```decrypt``` karne ke liye.

Ye dono mathematically linked hoti hain. Public key ko share kiya hata hai lekin private key ko share nahi kiya jata.

Example of Keys:
- RSA.
- ECC.

Example:
```
Public Key (shared):  P1
Private Key (secret): P2
```
Client data encrypt karega Public Key se:
```
Plaintext → [Public Key] → Ciphertext
```
Server data decrypt karega Private Key se:
```
Ciphertext → [Private Key] → Plaintext
```

<br>

**Real-World Examples**:
- SSL/TLS certificate encryption.
- SSH key-based login.
- Email encryption (PGP, GPG).

<br>

**Pros**:
- Secure key sharing (no need to exchange secret key).
- Provides authentication and non-repudiation.

**Cons**:
- Slower than symmetric encryption.
- CPU intensive (especially for large data).

<br>
<br>

**Difference Between Symmetric and Asymmetric Encryption**:
| Feature     | Symmetric            | Asymmetric                   |
| ----------- | -------------------- | ---------------------------- |
| Keys Used   | 1 (same)             | 2 (public + private)         |
| Speed       | Fast                 | Slow                         |
| Use Case    | Bulk data encryption | Key exchange, authentication |
| Example     | AES, DES             | RSA, ECC                     |
| Key Sharing | Must share securely  | No need to share private key |

<br>
<br>

## SSL Kaise Kaam Karta hai?
