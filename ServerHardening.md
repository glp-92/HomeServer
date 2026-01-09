# Setup

1. Update system and install basic utilities
```bash
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install net-tools -y
sudo apt install sysstat -y
sudo apt install openssh-server -y
```

# Server Hardening

2. Automatic upgrades
```bash
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

3. Create non root user and add to sudo group
```bash
sudo adduser username
sudo usermod -aG  sudo username
sudo su - username
```

4. SSH
  - Generate a pair public/private key to add to the server => `ssh-keygen -t ed25519 -f ~/.ssh/id_user` => Accept all => Placed on `/home/usr/.ssh/id_user.pub`
  - Paste content on server
```bash
cd /home/username/.ssh
sudo nano authorized_keys
cat ~/.ssh/id_rsa.pub | ssh user@ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```
  - Need to edit these lines on /etc/ssh/sshd_config
```bash 
port xxx # change default port
PermitRootLogin No 
AddressFamily inet # only Ipv4
PasswordAuthentication no # only certs
PermitEmptyPasswords no # only certs
X11Forwarding no # disallow desktop forwarding
AllowTcpForwarding no
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 0
PermitUserEnvironment no ## CAUTION: only "yes" when loading .env variables to create de init.sql file. Better fill fields with own db params
```
  - `sudo systemctl restart ssh`
  - If not working and user is prompted for password [check this](https://unix.stackexchange.com/questions/727492/passwordauthentication-no-but-i-can-still-login-by-password)

5. Fail2Ban utility => intrusion prevention system that monitors log files and ban suspicious IP addresses by using `iptables`. 
- [Tutorial](https://www.digitalocean.com/community/tutorials/how-to-protect-ssh-with-fail2ban-on-ubuntu-20-04)
- [Tutorial 2](https://medium.com/@bnay14/installing-and-configuring-fail2ban-to-secure-ssh-1e4e56324b19)
- [Tutorial 3](https://mytcpip.com/fail2ban-ssh/)
```bash
sudo apt install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.conf
```
Edit ssh section
```bash
[sshd]
enabled = true
port = xxx # Changed on sshd_config
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600
```
`sudo systemctl restart fail2ban`

6. UFW firewall. Default installed on `Ubuntu Server`. Abstraction of `iptables`
```bash
sudo ufw status # see installed
sudo ufw disable # disable first so rules can maintain session
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow xxx/tcp # ssh defined port
sudo ufw allow http # port 80
sudo ufw allow https # port 443
sudo ufw enable
sudo ufw status verbose
```

To delete existing rule

```bash
sudo ufw status numbered
sudo ufw delete 5 # example
```

7. Docker & Docker Compose [install](https://docs.docker.com/engine/install/)

```bash
sudo systemctl enable docker
sudo usermod -aG docker user # not need sudo docker ps...
```

8. Disable auto suspend for server
```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```
**To reenable it**
```bash
sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

9. Create a different user not sudo for critical services that could be vulnerable (a media server for ex)
```bash
sudo groupadd -r -g 1001 media
sudo useradd -u 1001 -g 1001 media
```

10. (Optional) Create a home non-accesible by other users on other groups
```bash
sudo mkdir /home/media
sudo chown -R media:media /home/media (user:group)
sudo chmod 750 /home/media (read, write, exec by user; read, exec by group, none others)
```

11. (Optional) Install btop to improved system monitor
```bash
sudo apt install btop
```
