# DNS

DNS stands for **Domain Name System.**

DNS is a service which translate Domain name of website into IP Address.

```Normally hum jab koi website access karte hain to website ka domain name browser main enter karte hain aur hit karte hai aur website open ho jate hain. But backend par DNS service work karti hai website ko access karane ke liye.```

```Hota ye hai ki Web servers ka ek IP Address hota hai jis par website chalti hai. Kisi bhi website ko easily access karne ke liye us website ko uske naam se search kiya jata hai but we know that ki internet par kisi bhi server se connect karna ho ya communicate karna ho to uske IP Address se karte hain. To website ka naam likh kar search karne par hum web server se connect kaise kar par rahe hain. Esa DNS (Domain Name System) ki help se hota hai.```

```Domain Name System website ke Website ke Domain Name ko server ki IP Address main translate karne ka kaam karta hai.```

it helps translate Domain Name (like www.example.com) into IP Address (like 192.168.1.1).

<br>

### How does DNS works?

First you type a URL into your browser so DNS check the IP Address attack to that domain name into various steps:

- **1 - Browser Checks Cache**: The browser first checks its local cache if it already knows the IP Address for that domain. If browser found the ip address then process stops here and connection is made directly.

- **2 - Operating System checks DNS Cache**: If the browser cache does not have the ip address then operating system dns cache is checked. If still there is no match,  then process continues.

- **3 - Query is send to a Recursive DNS Server**: The query is send to the recursive dns server which is maintained by your ISP. If still there is no match, then query is send to Root DNS server.

- **4 - Root DNS Server check cache**: Here Root Server does not have the exact ip address but it checks which what is the **Top-Level Domain** of your domain name. Top-Level domain is the (.com, .net, .org). Then Root DNS server sends the query to top level domain server.

- **5 - TLD server provides info of Authorative DNS server**: Now Top-Level Domain provides the information of exact **Authorative DNS Server**. New query is send to the autorative dns server.

- **6 - Authorative DNS Server provides the IP**: Here **Authorative DNS server** provides the exact IP Address of server hosting the website. Now thw information is recusively send to the browser and connection is established.

