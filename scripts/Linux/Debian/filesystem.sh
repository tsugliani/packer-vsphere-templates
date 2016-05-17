#
# Enable filesystem options
# - ACL's
# - discard flag (might make VM disks more compact)
#
sed --in-place -e 's/\(.*swap.*sw\)/\1,discard/' /etc/fstab
sed --in-place -e 's/\(.*ext[34].*defaults\)/\1,acl,discard/' /etc/fstab
