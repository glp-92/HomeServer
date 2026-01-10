# Home Server Setup

Guides on how to setup multiple services on private

First of all, is recommended a minimal system hardening, [check this guide](./ServerHardening.md)

## Setup

### Configure Mikrotik hardware firewall

In this repository is provided a minimal configuration of a Mikrotik Firewall in order to setup multiple LANS trying to isolate resources. Check the docs [here](./Mikrotik_Router/Readme.md)

### Configure Multiple LANs on same Ubuntu Server

When multiple LANs on a server, and different networks running on each `eth` port, must decide which one will gain access to internet. To make this run `sudo nano /etc/netplan/50-cloud-init.yaml`

```yaml
network:
    version: 2
    ethernets:
        enp3s0:
            dhcp4: true
        enp1s0:
            dhcp4: true
```

```bash
sudo netplan generate
sudo netplan apply
```

## Services

### Adguard

In home network, an Adguard server was installed on a raspberry pi in order to resolve some local dns requests as `http://homeserver.local.com`. Adguard gives the user some control over websites visited by users and some bloquing filters in order to reduce noise on home network. Local IP of Adguard server was setted as primary DNS on ISP router configuration. [Check docs to install Adguard here](./Adguard_DNS_Raspberry/Readme.md)

### Nginx

Entrypoint to home server. Maps paths to applications. As it is supposed that no external users will have access to the server, some security measurements were not taken into account. However it is still recommended a minimal hardening (ssl with https only, rate limiting, payload limits...)

### Immich Image Server

[Inmich](https://immich.app/) is an Open Source solution for content sharing as images and videos. Self hosted, allows multiple users creation and manage their access to the server. It uses by default a Postgres and Valkey databases to handle relationships and caching

Available on [IOS](https://apps.apple.com/us/app/immich/id1613945652) and [Android](https://play.google.com/store/apps/details?id=app.alextran.immich&hl=en)

## Run Services

```bash
docker compose up -d
```
