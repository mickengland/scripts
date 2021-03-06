#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -d  "/mnt/swap1" ]
then
  echo "swap1 already exists... exiting."
	exit
else

# Setup swap space
 dd if=/dev/zero of=/mnt/swap1 bs=1024 count=4194304
 chmod 600 /mnt/swap1
 mkswap /mnt/swap1
 swapon /mnt/swap1
 sysctl vm.swappiness=60

# Modify /etc/fstab
	echo '/mnt/swap1 none swap sw 0 0' >> /etc/fstab

# Enable swappineess
sed -i 's/vm.swappiness = 0/vm.swappiness = 60/' /etc/sysctl.conf

# Check if data dir exists
	mkdir /data
	chown hudson.hudson /data
fi
