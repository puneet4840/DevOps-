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
- "* * *": Indicates a timeout or a packet was dropped, meaning that hop didn’t respond within the expected time.

<br>

## ping

ping stands for **P**acket **I**nternet **G**roper.

Ping command is used to test the connectivity between your computer and another device on the internet. It checks if the other device is recheable from your computer and measure the time taken by data to reach to another device.

Syntax:
```
ping <ip address OR domain name>
```

e.g.,

- **To check google is reachable, you would use:**
```
ping www.google.com
```

Output:

When you run ping, the output looks like this,
```
PING google.com (172.217.164.110) 56(84) bytes of data.
64 bytes from sea15s04-in-f14.1e100.net (172.217.164.110): icmp_seq=1 ttl=55 time=17.5 ms
64 bytes from sea15s04-in-f14.1e100.net (172.217.164.110): icmp_seq=2 ttl=55 time=17.8 ms
64 bytes from sea15s04-in-f14.1e100.net (172.217.164.110): icmp_seq=3 ttl=55 time=17.2 ms
--- google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 17.236/17.535/17.835/0.245 ms
```

- 64 bytes from...: Shows that a reply was received, including the size of the packet.
- icmp_seq=1: The sequence number of the packet, which increments with each packet sent.
- ttl=55: Time to live, which indicates the maximum number of hops the packet can make before being discarded. Means number of routers over the path.
- time=17.5 ms: The round-trip time it took for the packet to reach the destination and return.
- 3 packets transmitted, 3 received, 0% packet loss: Shows the number of packets sent and received, along with the percentage of packet loss.
- rtt min/avg/max/mdev = 17.236/17.535/17.835/0.245 ms: The minimum, average, maximum, and standard deviation of the round-trip times.

**Common options**

- ping -c 4 google.com: Specify the number of packets to send, it is 4.
- ping -i 2 google.com: Set the interval time sending each packet(in seconds).

<br>
<br>

## mtr

mtr stands for My Traceroute.

mtr command combines the functionality of **traceroute** and **ping** at one place. It provides real-time information about networking connectivity between your device and another device on the internet.

Syntax:
```
mtr <ip addres OR domain name>
```

e.g.,

To run mtr against google, you would use:
```
mtr www.google.com
```

Output:
```
Start: Wed Aug 11 08:21:32 2024
HOST: my-machine                 Loss%   Snt   Last   Avg  Best  Wrst StDev
  1. router.local                 0.0%    10    1.2   1.4   1.1   1.7   0.2
  2. 10.0.0.1                     0.0%    10    3.4   3.3   3.1   3.6   0.1
  3. 192.168.1.1                  0.0%    10    9.2   8.9   8.7   9.5   0.2
  4. 72.14.234.20                 0.0%    10   14.3  14.1  13.9  14.7   0.3
  5. google.com                   0.0%    10   22.5  22.4  22.0  23.0   0.3
```

- HOST: The hostname or IP address of each hop.
- Loss%: The percentage of packets lost at each hop.
- Snt: The number of packets sent to each hop.
- Last: The round-trip time (in milliseconds) of the last packet sent.
- Avg: The average round-trip time for packets sent to that hop.
- Best: The shortest round-trip time recorded.
- Wrst: The longest round-trip time recorded.
- StDev: The standard deviation of the round-trip times, indicating how much they vary.
```


<br>
<br>


