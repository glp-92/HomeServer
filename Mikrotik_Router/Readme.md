# Mikrotik Local Router 

It is recommended if company ISP router does not provide LAN isolation use a Firewall to enable these features and ensure network segmentation for home devices, IoT, stream services...

In this configuration [Microtik E50UG](https://mikrotik.com/product/hex_2024) provides these features in an affordable way

## First time connection

The recommendable way to setup initial connection to the router in order to configure it is to connect ISP Router to eth1 and connect eth2 to computer that will perform setup. Use [Winbox Software](https://mikrotik.com/download/winbox) to have full access to all features. First time login it will have a default configuration as bridge. Go to `system` -> `reset configuration` -> check `no default configuration` to have the router config cleared

## Minimal setup

Basic configuration is provided [here](./basic-config.rsc). To add it to the router copy its content, go to `terminal` on Winbox and paste it so a basic configuration will be applied. Keep in mind that if router is into another IP must change these params as DNS servers used on local network (if used AdGuard as DNS server include it).

With this configuration, `eth1` works as input for `WAN`, `eth2` for a Microtik Management Lan, `eth3-5` for another Lans. However, firewall rules must be applied if order to isolate these networks

## Minimal firewall setup

Minimal firewall setup is provided [here](./firewall-config.rsc) to isolate networks from themselves so they cannot access devices on another Lan.

Note that `192.168.1.253` is now reachable from WAN network in order to use `http` and `ssh` to access Immich server and more. A route must be configured on ISP Router in order to make it reachable

- Add routing rule: `destination 192.168.1.0 / mask 255.255.255.0 / gateway <Mikrotik router ip on WAN>`

However, to ensure network was well configured. It is reccomendable to run a [battery test](./network-testing.md) in order to ensure LAN isolating