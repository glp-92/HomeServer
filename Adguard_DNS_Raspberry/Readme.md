# Adguard DNS Server

In order to set some DNS records an basic ad bloquer, Adguard can be installed on a local server. In this repository, it is done with a `Rapberry Pi` with `Pi OS minimal` (no UI)

## Setup

Run comnands on the [script provided](./setup.sh)

## Add DNS for home server

In this example, a DNS record is added to Adguard to access Inmich server exposed through [Nginx](../Nginx_Reverse_Proxy/nginx.conf) on the network

Go to main Adguard Dashboard -> `filters`-> `DNS rewrites` -> `Add DNS rewrite` -> Domain name `homeserver.local.com` IP `192.168.1.253`
