# model = E50UG
# -----------------------------------------------------------
# Interface setup with eth1 as WAN
# -----------------------------------------------------------
/interface ethernet
set [ find default-name=ether1 ] name=ether1-WAN
set [ find default-name=ether2 ] name=ether2-Manage
set [ find default-name=ether3 ] name=ether3-Lan1
set [ find default-name=ether4 ] name=ether4-Lan2
set [ find default-name=ether5 ] name=ether5-Lan3
# -----------------------------------------------------------
# Create interfaces list to manage easily multiple interfaces
# -----------------------------------------------------------
/interface list
add name=LAN
add name=WAN
# -----------------------------------------------------------
# Create ip pools for setting dhcp server ranges
# -----------------------------------------------------------
/ip pool
add name=pool-gestion ranges=192.168.99.10-192.168.99.254
add name=pool-lan1 ranges=192.168.1.10-192.168.1.254
add name=pool-lan2 ranges=192.168.2.10-192.168.2.254
add name=pool-lan3 ranges=192.168.3.10-192.168.3.254
# -----------------------------------------------------------
# Create dhcp server on every eth except WAN
# -----------------------------------------------------------
/ip dhcp-server
add address-pool=pool-gestion interface=ether2-Manage name=dhcp-manage
add address-pool=pool-lan1 interface=ether3-Lan1 name=dhcp-lan1
add address-pool=pool-lan2 interface=ether4-Lan2 name=dhcp-lan2
# Interface not running
add address-pool=pool-lan3 interface=ether5-Lan3 name=dhcp-lan3
/interface list member
add interface=ether1-WAN list=WAN
add interface=ether2-Manage list=LAN
add interface=ether3-Lan1 list=LAN
add interface=ether4-Lan2 list=LAN
add interface=ether5-Lan3 list=LAN
# -----------------------------------------------------------
# Setup IP addresses for every interface (default gateways for every lan)
# -----------------------------------------------------------
/ip address
add address=192.168.99.1/24 interface=ether2-Manage network=192.168.99.0
add address=192.168.1.1/24 interface=ether3-Lan1 network=192.168.1.0
add address=192.168.2.1/24 interface=ether4-Lan2 network=192.168.2.0
add address=192.168.3.1/24 interface=ether5-Lan3 network=192.168.3.0
add address=192.168.0.6/24 interface=ether1-WAN network=192.168.0.0
/ip dhcp-server network
add address=192.168.1.0/24 dns-server=192.168.1.1 gateway=192.168.1.1
add address=192.168.2.0/24 dns-server=192.168.2.1 gateway=192.168.2.1
add address=192.168.3.0/24 dns-server=192.168.3.1 gateway=192.168.3.1
add address=192.168.99.0/24 dns-server=192.168.99.1 gateway=192.168.99.1
# -----------------------------------------------------------
# DNS configuration with local adguard server as first one
# -----------------------------------------------------------
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,1.1.1.1
# -----------------------------------------------------------
# NAT setup to allow LANs internet access
# -----------------------------------------------------------
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
# -----------------------------------------------------------
# Add default route to ISP router for Mikrotik router (if configured as dhcp client this was not neccesary)
# -----------------------------------------------------------
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.0.1 \
    routing-table=main scope=30 suppress-hw-offload=no target-scope=10
# -----------------------------------------------------------
# Disable unused services
# -----------------------------------------------------------
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes