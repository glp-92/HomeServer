# Adguard DNS Server

In order to set some DNS records an basic ad bloquer, Adguard can be installed on a local server. In this repository, it is done with a `Rapberry Pi` with `Pi OS minimal` (no UI)

## Setup

Run comnands on the [script provided](./setup.sh)

## Add DNS for home server

In this example, a DNS record is added to Adguard to access Inmich server exposed through [Nginx](../Nginx_Reverse_Proxy/nginx.conf) on the network

Go to main Adguard Dashboard -> `filters`-> `DNS rewrites` -> `Add DNS rewrite` -> Domain name `homeserver.local.com` IP `192.168.1.253`

## Utilities

### Adguard status

```bash
adguard-status: sudo /opt/AdGuardHome/AdGuardHome -s start|stop|restart|status|install|uninstall
```

### Change adguard user and password

```bash
sudo nano /opt/AdGuardHome/AdGuardHome.yaml
```

Find `users` section and edit those fields. Note that password is hashed by bcrypt algorithm. [bcrypt-generator.com](https://bcrypt-generator.com) can provide these hashes, but it is highly recommended to use own script as data is not controlled on external webpages
