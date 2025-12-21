# Mikrotik Local Router 

It is recommended if company ISP router does not provide LAN isolation use a Firewall to enable this features and ensure network segmentation for home devices, IoT, stream services...

In this configuration [Microtik E50UG](https://mikrotik.com/product/hex_2024) provides this features in an affordable way

## First time connection

The recommendable way to setup initial connection to the router in order to configure it is to connect ISP Router to eth1 and connect eth2 to computer that will perform setup. Use [Winbox Software](https://mikrotik.com/download/winbox) to have full access to all features. First time login it will have a default configuration as bridge. Go to `system` -> `reset configuration` -> check `no default configuration` to have the router config cleared

Basic configuration is provided [here](./basic-config.rsc). To add it to the router copy its content, go to `terminal` on Winbox and paste it so a basic configuration will be applied. Keep in mind that if router is into another ip must change these param as dns servers used on local network (if used adguard as dns server include it)