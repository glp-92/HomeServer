# Must set raspberry PI IP to static on home router
sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from local-ip-range/24 to any port 22 proto tcp
sudo ufw allow from local-ip-range/24 to any port 53 proto tcp
sudo ufw allow from local-ip-range/24 to any port 53 proto udp
sudo ufw allow from local-ip-range/24 to any port 80 proto tcp
sudo ufw allow from local-ip-range/24 to any port 3000 proto tcp # first config
sudo ufw enable
cd
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v

