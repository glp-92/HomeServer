# Home Server Setup

Guides on how to setup multiple services on private / public network

First of all, is recommended a minimal system hardening, [check this guide](./ServerHardening.md)

## Multiple LANs

When multiple LANs on a server, and different networks running on each eth port, must decide which one will gain access to internet. To make this run `sudo nano /etc/netplan/50-cloud-init.yaml`

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
