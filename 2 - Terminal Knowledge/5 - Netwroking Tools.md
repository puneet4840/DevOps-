# Networing Tools

Networking Tools are used to troubleshoot network issues. They are also used to monitor network traffic and to test network connectivity.

Some most common networking tools are: **traceroute**, **ping**, **mtr**, **nmap**, **netstat**, **ufw**, **firewalld**, **iptables**, **nftables**, **tcpdump**, **dig**, **scp**.

<br>

## 1 - traceroute

traceroute command is used to track the path of data packets sent to destination device from your computer.

Syntax:
```
traceroute <ip or url>
```

**How traceroute works?**

When you send the data across internet, It passes thorugh multiple devices called routers before reaching to its destination. **traceroute** send data packets to destination and records the time it takes for each hop. 

**What is Hop?**

A Hop is a router that packet passes through.

Hops is the total number of router, from source to destination that a data packet passes through it.

**e.g.,**
```
traceroute www.google.com
```
Output

```
traceroute to google.com (172.217.1.174), 30 hops max, 60 byte packets
 1  10.0.0.1 (10.0.0.1)  1.123 ms  1.221 ms  1.311 ms
 2  192.168.1.1 (192.168.1.1)  2.332 ms  2.234 ms  2.426 ms
 3  172.217.1.174 (172.217.1.174)  14.274 ms  14.374 ms  14.374 ms
```

- 1,2,3, etc is the hop count(number of routers in the path).
- IP Address (e.g., 10.0.0.1): The IP address of the router at each hop.
- Time (e.g., 1.123 ms): The round-trip time it took for the packet to reach that router and return to your computer.
- "***": Indicates a timeout or a packet was dropped, meaning that hop didn’t respond within the expected time.
