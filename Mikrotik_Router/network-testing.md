# Network Validation & Security Tests

This section describes a set of tests to validate correct network isolation, controlled access, and security rules.

---

## 1. Inter-LAN Isolation Test

### Objective
Confirm that the local networks (LANs) cannot communicate with each other.

### Action
- Connect one device to **ether3 (LAN1)**
- Connect another device to **ether4 (LAN2)**

### Test
From the PC in **LAN1**:
- Ping the **LAN2 gateway**: 192.168.2.1
- Ping the **specific IP address** of the PC in **LAN2**

### Expected Result
- The ping **must fail** (Request timed out)

### WinBox Verification
- Go to **IP → Firewall → Filter**
- Locate the **TOTAL LAN ISOLATION** rule
- Verify that the **packet counter increases** when attempting the ping

---

## 2. Server Access Test (WAN → LAN1)

### Objective
Verify that the server is visible **only through authorized ports**.

### Action
- Use a device connected to the **WAN network** (192.168.0.x range)
- On server, open a service that cannot be reachable for WAN (RDP, VNC for example)

### Tests

- Ping
    ping SERVER_IP
    (or MikroTik WAN IP if using DST-NAT)
    Result: Success

- Web Service
    Open in browser:
    http://SERVER_IP
    Result: Success

- SSH Access
    ssh user@SERVER_IP
    Result: Success

- Unauthorized Port
    Attempt to connect to a non-authorized port (e.g. RDP – port 3389)
    Result: Failure

### WinBox Verification
- Check that the **SSH and HTTP Server Access** rule counters increase

---

## 3. Management & Security Test (Input Chain)

### Objective
Ensure that **no external user** can access the router's management interfaces.

### Action (From WAN)
- Use a device in the **WAN network** (192.168.0.x)
- Attempt to access:
  - WinBox
  - WebFig
  - IP: 192.168.0.6

### Expected Result
- Connection refused or timeout

### Action (From LAN)
- Attempt the same access from a PC connected to **any LAN**

### Expected Result
- Access granted

---

## 4. Local WAN Network Blocking Test

### Objective
Prevent LAN users from accessing or "snooping" devices on the **ISP router network**.

### Action
- From a PC connected to **any LAN**

### Tests

- Ping ISP Router
    ping 192.168.0.1
    ping 192.168.0.7
    Result: Failure
    (Blocked by the Block access to Local WAN Network rule)

- Internet Connectivity Test
    ping 8.8.8.8
    or browse to:
    https://www.google.com
    Result: Success (normal internet access)
