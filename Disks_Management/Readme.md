# Storage

This home server is using a DAS Station with 5 bays for HDD and SSD drives. Those drives are connected on a single USB3.0 port to the server. This repo provides some utilities to use these hardware

## Utilities

### Get disks info

```bash
sudo fdisk -l # List drives and capabilities (need sudo as permission is denied)
lsblk -o NAME,SIZE,MODEL,ROTA,TYPE # list drives, model and type of every drive
```

### Wipe disks

In order to format and mount new disks, wipe is performed to clean old data

```bash
sudo wipefs -a /dev/sdb # hdd 1TB
sudo wipefs -a /dev/sdc # hdd 1TB
sudo wipefs -a /dev/sdd # ssd 1TB
sudo wipefs -a /dev/sde # ssd 1TB
```

#### SSD Setup no RAID

Create partitions table and labels on SSDs as will not have raid

```bash
# Creating the GUID Partition Table (GPT)
sudo parted /dev/sdd mklabel gpt 
sudo parted /dev/sde mklabel gpt 
# Partition type and percent of disk used
sudo parted /dev/sdd --script mkpart primary ext4 0% 100% 
sudo parted /dev/sde --script mkpart primary ext4 0% 100%
```

Ext4 formatting

```bash
# Format on ext4 with label after -L. sdb1 => partition, entire disk is not chosen here
sudo mkfs.ext4 -L SSD1 /dev/sdd
sudo mkfs.ext4 -L SSD2 /dev/sde
lsblk -f # check
```

Create mount point

```bash
sudo mkdir -p /data/ssd1
sudo mkdir -p /data/ssd2
```

Mount

```bash
sudo nano /etc/fstab
```

And then add these lines as example

```bash
LABEL=SSD1 /data/ssd1 ext4 defaults,noatime,nofail 0 2
LABEL=SSD2 /data/ssd2 ext4 defaults,noatime,nofail 0 2
```

Run mount to check if it is correctly set

```bash
sudo mount -a
systemctl daemon-reload
df -h # check mounted, filesystem and %usage
```

#### HDD Setup Raid1

To create a redundant array of disks. As hdds employed are old, any failure will leverage on data losing so with raid1 two disks need to fail. With more disks should examine Raid5 setup to increase available storage

Create raid partition on disks

```bash
sudo parted /dev/sdb --script mklabel gpt
sudo parted /dev/sdb --script mkpart primary 0% 100%
sudo parted /dev/sdb --script set 1 raid on
sudo parted /dev/sdc --script mklabel gpt
sudo parted /dev/sdc --script mkpart primary 0% 100%
sudo parted /dev/sdc --script set 1 raid on
```

Create raid setting md0 as result device

```bash
sudo mdadm --create /dev/md0 \
  --level=1 \
  --raid-devices=2 \
  /dev/sdb1 /dev/sdc1 
cat /proc/mdstat # Check raid progress
```

Create filesystem on raid

```bash
sudo mkfs.ext4 -L RAID1HDD /dev/md0
```

Create mount point

```bash
sudo mkdir -p /data/raid1hdd
```

**SAVE MDADM config in order to regenerate raid**

```bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u
```

Mount

```bash
sudo nano /etc/fstab
```

And then add this line as example

```bash
LABEL=RAID1HDD /data/raid1hdd ext4 defaults,noatime,nofail 0 2
```

Run mount to check if it is correctly set

```bash
sudo mount -a
systemctl daemon-reload
df -h # check mounted, filesystem and %usage
```
