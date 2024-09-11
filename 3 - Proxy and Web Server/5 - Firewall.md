# Firewall

### What is Firewall?

A Firewall is a security system that monitors and control incomming and outgoing network traffic based on security rules. It is used to protect devices and systems from unauthorized access, attacks and threats.

A firewall is a traffic controller of your network.

<br>

### How Firewall works?

Firewall inspect the data packets(the unit of data that are sent over a network) that travel across network and decide whether to allow or block them based on a set of rules. 

These rules are based on criteria such as:

- **IP Address**: Allow or block traffic on specific ip addresses.
- **Port Numbers**: Allow or block traffic on specific ports (e.g., web traffic on port 80).
- **Protocols**: Control traffic based on protocols (e.g., HTTP, HTTPS, FTP, etc).
- **Packet Inspection**: Firewalls can inspect packet content and determine if it matches to a known signature.

<br>

### Firewall Filtering Technique

- **1 - Packet Filetring**: Packet Filtering Firewalls examine the header information of each data packet. The header contains Source and Destinations Ip Addresses, protocol(TCP, UDP), and port numbers. Based on predefined rules firewalls allow or block data packets.

- **2 - Statefull Inspection**: Statefull firewall go a step further by keeping track of active connections. They monitor the state of connection (such as TCP handshake) and make decision based on the current state.

 e.g.,
 
  ```If a client starts a TCP handshake (SYN request) with a server, the firewall allows the connection to be established. It then monitors the session until it is terminated.```

<br>

### Simple Example How Firewall are Used:

- **At Home**: Your Wifi router has a firewall that blocks hakers from accessing your device.

- **In Companies**: Businesses use firewalls to protect their servers, block unwanted websites, and monitor employee internet use.

- **In the Cloud**: Online services like Azure, Aws, etc uses firewalls to protects their servers form cyber attacks.
