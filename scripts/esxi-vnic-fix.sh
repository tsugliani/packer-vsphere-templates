#!/bin/sh

# When an ESX VM is cloned, vnic0 gets a new mac from the vmx's
# ethernet0.generatedAddress, but vmk0's mac is persisted in /etc/vmware/esx.conf
# vagrant uses ethernet0.generatedAddress to lookup the VM ip in
# vmnet-dhcpd-vmnet8.leases, reconfigure here if needed.

os_ver=$(uname -r | sed -rn 's/.*([0-9])\.[0-9].*\.[0-9].*/\1/p')

if [ "$os_ver" -lt 6 ] ; then
  vnic0_mac=$(esxcli --formatter csv network nic list | grep vmnic0 | awk -F, '{print $5}')
  vmk0_mac=$(esxcli --formatter csv network ip interface list | grep vmk0 | awk -F, '{print $2}')
else
  vnic0_mac=$(esxcli --formatter csv network nic list | grep vmnic0 | awk -F, '{print $7}')
  vmk0_mac=$(esxcli --formatter csv network ip interface list | grep vmk0 | awk -F, '{print $2}')
fi

if [ "$vnic0_mac" != "$vmk0_mac" ] ; then
  esxcli network ip interface remove -i vmk0

  esxcli network ip interface add -i vmk0 -M $vnic0_mac -p "Management Network"

  esxcli network ip interface ipv4 set -i vmk0 -t dhcp
fi
