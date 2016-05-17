#!/bin/bash

# Clean up
apt-get -y --purge remove linux-headers-$(uname -r) build-essential
apt-get -y --purge autoremove
apt-get -y purge $(dpkg --list | grep '^rc' | awk '{print $2}')
apt-get -y purge $(dpkg --list | egrep 'linux-image-[0-9]' | awk '{print $3,$2}' | sort -nr | tail -n +2 | grep -v $(uname -r) | awk '{ print $2}')
apt-get -y clean

find /var/lib/apt/lists \! -name lock -type f -delete

# delete linux source
dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge

# delete development packages
dpkg --list | awk '{ print $2 }' | grep -- '-dev$' | xargs apt-get -y purge

# delete X11 libraries
apt-get -y purge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6

# remove unused stuff
apt-get -y autoremove

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

echo "Zeroing / partition..."
# Whiteout root
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
count=$((count -= 1))
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

echo "Zeroing /boot partition..."
# Whiteout /boot
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
count=$((count -= 1))
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;

echo "Zeroing /swap partition..."
# Whiteout swap
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
mkswap $swappart;
swapon $swappart;


echo "Cleaning bash history..."
# Remove history file
unset HISTFILE
rm -f ~/.bash_history /home/vagrant/.bash_history

# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync && sync
