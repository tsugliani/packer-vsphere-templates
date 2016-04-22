# Settings to ensure that ESXi cloning goes smooth, thanks @lamw ! see:
# http://www.virtuallyghetto.com/2013/12/how-to-properly-clone-nested-esxi-vm.html
esxcli system settings advanced set -o /Net/FollowHardwareMac -i 1
sed -i '/\/system\/uuid/d' /etc/vmware/esx.conf

# Ensure changes are persistent
/sbin/auto-backup.sh
