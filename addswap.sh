#!/bin/bash
if [ -d  "/mnt/swap1" ]
 echo "swap1 already exists... exiting."
else

# Setup swap space
 dd if=/dev/zero of=/mnt/swap1 bs=1024 count=4194304
 chmod 600 /mnt/swap1
 mkswap /mnt/swap1
 swapon /mnt/swap1
 sysctl vm.swappiness=60

# Modify /etc/fstab
	cat '/mnt/swap1 none swap sw 0 0' >> /etc/fstab

# Enable swappineess
sed -i 's/vm.swappiness = 0/vm.swappiness = 60/' /etc/sysctl.conf

fi

# Check if data dir exists
if [ ! -d "/data" ]
	mkdir /data
	chown hudson.hudson /data
fi
