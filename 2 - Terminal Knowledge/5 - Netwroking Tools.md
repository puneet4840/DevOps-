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

- Specify the number of packets to send, it is 4.
```
ping -c 4 google.com
```

- Set the interval time sending each packet(in seconds).
```
ping -i 2 google.com:
```

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

<br>
<br>

## netstat

netstat stands for Network Statistics

netstat is a command-line utility which provides detail information about network connection for TCP and UDP, routing-tables, interface satistics, etc. 

Syntax:
```
netstat <option>
```

**Commonly used options**

- **netstat -a**: Shows all active connections and listening ports.
- **netstat -t**: Shows all TCP connections.
- **netstat -u**: Shows all udp connections.
- **netstat -l**: Shows only listening ports (ports that are open and waiting for connections).
- **netstat -n**: Displays address and port numbers in numerical form.

e.g., **Check how many connections on port 22.**

```
netstat -putan | grep :22
```

e.g., **When you run netstat.**

```
netstat
```

Output
```
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 192.168.1.10:22         192.168.1.1:56392       ESTABLISHED 1257/sshd
tcp        0      0 192.168.1.10:80         192.168.1.2:48236       TIME_WAIT   -
```

- Proto: The protocol used (e.g., TCP, UDP).
- Recv-Q: The receive queue, showing the number of bytes waiting to be received.
- Send-Q: The send queue, showing the number of bytes waiting to be sent.
- Local Address: The IP address and port number of the local side of the connection.
- Foreign Address: The IP address and port number of the remote side of the connection.
- State: The state of the connection (e.g., ESTABLISHED, TIME_WAIT, LISTENING).
- PID/Program name: The process ID and name of the program using the connection.

e.g., **To check connection from a particular IP.**

```
netstat -an | grep <IP>
```

<br>
<br>

## ufw

ufw stands for Uncomplicated Firewall.

ufw is a command-line utility which is used to manage the firewall on linux. 

Syntax:
```
ufw [option] <command>
```

**What is Firewall?**

Firewall is a network security system which controls the incoming and outgoing network traffic based on pre-defined security rules. It helps protect your system from unauthorized access of server.

**Basic ufw commands**

- **1 - Enable ufw**

  Before using ufw, you need to enable it.
  ```
  sudo ufw enable
  ```
  This command turns on the firewall with default rules (typically, deny all incoming and allow all outgoing traffic).

- **2 - Diables ufw**

  If you need to turn off firewall, you need to disable it.
  ```
  sudo ufw disable
  ```
  This stops the firewall from filtering any traffic.
  
- **3 - Check ufw status**
  
  To see the current status of ufw and the rules that are set:
  ```
  sudo ufw status
  ```

- **4 - Allow Traffic**
  ```
  sudo ufw allow <port_number>
  ```
  e.g., Allow traffic on port 22.
  ```
  sudo ufw allow 22
  ```

  e.g., Allow traffic for specific protocol.
  ```
  sudo ufw allow 80/tcp
  ```
  OR

  e.g. Allow traffic for specific protocol.
  ```
  sudo ufw allow http
  ```

- **5 - Deny Traffic**
  ```
  sudo ufw deny <port_number>
  ```

  e.g., To deny traffic on 22 port.
  ```
  sudo ufw deny 22
  ```

- **6 - Delete a rule**
  ```
  sudo ufw delete allow 22
  ```
  This removes the rule that allows traffic on port 22.

- **7 - Allow traffic on specific IP**
  ```
  sudo ufw allow from 192.168.1.100
  ```

- **8 - Deny traffic on specific IP**
  ```
  sudo ufw deny from 192.168.1.100
  ```
