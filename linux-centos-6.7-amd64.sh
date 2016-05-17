#!/bin/sh

PACKER_LOG=1 packer build \
       -var 'packer_remote_host=192.168.0.251' \
       -var 'packer_remote_datastore=NFS_DATASTORE' \
       -var 'packer_remote_network=VM Network' \
       -var 'packer_remote_username=root' \
       -var 'packer_remote_password=VMware1!' \
       linux-centos-6.7-amd64.json
