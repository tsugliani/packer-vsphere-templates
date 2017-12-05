#!/bin/sh

PACKER_LOG=1 packer build \
       -var 'packer_remote_host=172.20.252.251' \
       -var 'packer_remote_datastore=LVB' \
       -var 'packer_remote_network=VM Network' \
       -var 'packer_remote_username=administrator@vsphere.local' \
       -var 'packer_remote_password=Chloe022!!2' \
       linux-centos-7.4-amd64.json
