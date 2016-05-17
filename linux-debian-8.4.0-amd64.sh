#!/bin/sh

packer build \
       -var 'packer_remote_host=192.168.0.251' \
       -var 'packer_remote_datastore=NFS_DATASTORE' \
       -var 'packer_remote_network=VM Network' \
       -var 'packer_remote_username=root' \
       -var 'packer_remote_password=VMware1!' \
       linux-debian-8.4.0-amd64.json
