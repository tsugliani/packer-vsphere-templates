#!/bin/bash -eux

rm -f /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules
rm -rf /dev/.udev/ /var/lib/dhcp/* /var/lib/dhcp3/*
echo "pre-up sleep 2" >> /etc/network/interfaces
