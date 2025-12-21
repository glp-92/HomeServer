/ip firewall filter
# -----------------------------------------------------------
# 1. State maintaining
# -----------------------------------------------------------
add action=accept chain=input comment="Accept stablished connections" connection-state=established,related
add action=accept chain=forward comment="Accept stablished connections" connection-state=established,related
add action=drop chain=input comment="Drop invalid conn" connection-state=invalid
add action=drop chain=forward comment="Drop invalid conn" connection-state=invalid

# -----------------------------------------------------------
# 2. Input chain (router protection)
# -----------------------------------------------------------
add action=accept chain=input comment="Total access to manage from LAN" in-interface-list=LAN
add action=accept chain=input comment="Allow ping" protocol=icmp
add action=drop chain=input comment="Bloq remaining WAN traffic" in-interface-list=WAN

# -----------------------------------------------------------
# 3. Forward chain (traffic between networks)
# -----------------------------------------------------------

# --- WAN Inmich server access ---
add action=accept chain=forward comment="SSH HTTP access to server" \
    dst-address=192.168.1.253 dst-port=22,80 in-interface=ether1-WAN protocol=tcp
add action=accept chain=forward comment="Ping to server from WAN" \
    dst-address=192.168.1.253 in-interface=ether1-WAN protocol=icmp

# --- LANS isolation ---
add action=drop chain=forward comment="isolation between lans" \
    in-interface-list=LAN out-interface-list=LAN

# --- Out to internet & WAN sec ---
add action=drop chain=forward comment="Bloq local WAN devicess access" \
    dst-address=192.168.0.0/24 in-interface-list=LAN out-interface=ether1-WAN
# Allow remaining output to internet
add action=accept chain=forward comment="Allow internet" \
    in-interface-list=LAN out-interface-list=WAN
# Final default drop
add action=drop chain=forward