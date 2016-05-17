#!/bin/sh

packer build \
       -var 'iso_file=iso/VMware-VMvisor-Installer-6.0.0.update02-3620759.x86_64.iso' \
       -var 'iso_sha1sum=5a93f457980d18f7061c8b550c509682070cadc7' \
       -var 'packer_remote_host=192.168.0.251' \
       -var 'packer_remote_datastore=NFS_DATASTORE' \
       -var 'packer_remote_network=VM Network' \
       -var 'packer_remote_username=root' \
       -var 'packer_remote_password=VMware1!' \
       vmware-esxi-appliance-6.0U2.json
