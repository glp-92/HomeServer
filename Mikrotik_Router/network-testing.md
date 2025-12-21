1. Inter-LAN Isolation Test
   
Objective: Confirm that the local networks (LANs) cannot communicate with each other.

Action: Connect one device to ether3 (Lan1) and another to ether4 (Lan2).

Test: From the PC in Lan1, ping the Lan2 gateway (192.168.2.1) and the specific IP address of the PC in Lan2.

Expected Result: The ping must fail (Request timed out).

WinBox Verification: Go to IP > Firewall > Filter, locate the "TOTAL LAN ISOLATION" rule, and observe if the packet counter increases when you attempt the ping.

1. Server Access Test (WAN -> Lan1)
   
Objective: Verify that the server is visible only through authorized ports.

Action: Use a device connected to the WAN network (the 192.168.0.x range).

Tests:

Ping: Ping the server's IP (or the MikroTik's WAN IP if using DST-NAT). Result: Success.

Web Service: Try to open the web interface (http://SERVER_IP). Result: Success.

SSH: Try to connect via SSH (ssh user@SERVER_IP). Result: Success.

Unauthorized Port: Try to connect via a non-authorized port (e.g., RDP port 3389). Result: Failure.

WinBox Verification: The "SSH and HTTP Server Access" rule counters should increase.

1. Management & Security Test (Input Chain)
   
Objective: Ensure that no external user can access the router's management interfaces.

Action: From the WAN network (192.168.0.x).

Test: Attempt to log into the MikroTik via WinBox or WebFig using the IP 192.168.0.6.

Expected Result: Connection refused or Time out.

Action: Attempt the same from a PC connected to any of the LANs.

Expected Result: Access granted.

1. Local WAN Network Blocking Test
   
Objective: Prevent LAN users from "snooping" or accessing devices on the primary ISP router's network.

Action: From a PC connected to any LAN.

Test: Ping the ISP router's IP (192.168.0.7 or 192.168.0.1).

Expected Result: Failure (Blocked by the "Block access to Local WAN Network" rule).

Internet Test: Ping 8.8.8.8 or browse to google.com.

Expected Result: Success (Normal internet navigation).