# VMware [ESXi](https://www.vmware.com/products/esxi-and-esx/overview) [Packer](http://packer.io) templates
This stuff is based on a mix of the following friends work:
- https://github.com/frapposelli/esxi-packer-templates by  [@frapposelli](https://twitter.com/fabiorapposelli)
- https://github.com/sdorsett/packer-templates by  [@sdorsett](https://twitter.com/standorsett)

The original challenge was to be able to reproduce the ESXi Appliances provided by William Lam on his blog [virtuallyGhetto](http://www.virtuallyghetto.com/2015/12/deploying-nested-esxi-is-even-easier-now-with-the-esxi-virtual-appliance.html)

That said, I intend to provide some custom Linux and Windows templates as well.

## Prerequisites

* [Packer](http://packer.io) > 0.8 (PS: My packer releases are available [HERE](https://github.com/tsugliani/packer/releases))
  * [PR 3321](https://github.com/mitchellh/packer/pull/3321])
  * [Misc Personal Fix](https://github.com/tsugliani/packer/commit/9839a009ce6835f6bedcfa31935ad38110400468)

* VMware vSphere ESXi >= 5.5 (tested on 6.0 U2)
* Firewall rules entries for VNC: [vnc_config_5_1.sh](https://gist.githubusercontent.com/jasonberanek/4670943/raw/0749993b9043b581cd41c8f8b9886f93153f9b3f/vnc_config_5_1.sh) (This works on 6.0 U2)


## Build artifacts

This packer template requires to set some variables to work in your env:
Check the ```vmware-esxi-appliance-6.0U2.sh``` convenience builder script.

  * ```iso_file```: which iso file your are leveraging (tested so far only with VMware ESXi 6.0 U2)
  * ```iso_sha1sum```: the sha1sum corresponding to the ```iso_file```

  * ```packer_remote_host```: IP/DNS of you VMware ESXi host used for building the template
  * ```packer_remote_datastore```: Datastore to leverage (Note: VSAN will not work as mkdir doesn't work on it - https://kb.vmware.com/kb/2119776)
  * ```packer_remote_network```: Network on which the VM will be attached (remember it needs to be accessible from your packer builder network)
  * ```packer_remote_username```: Username credentials for the VMware ESXi host leveraged for the build
  * ```packer_remote_password```: Password credentials for the VMware ESXi host leveraged for the build


Sample usage in ```vmware-esxi-appliance-6.0U2.sh```
```
packer build \
       -var 'iso_file=iso/VMware-VMvisor-Installer-6.0.0.update02-3620759.x86_64.iso' \
       -var 'iso_sha1sum=5a93f457980d18f7061c8b550c509682070cadc7' \
       -var 'packer_remote_host=192.168.0.251' \
       -var 'packer_remote_datastore=NFS_DATASTORE' \
       -var 'packer_remote_network=VM Network' \
       -var 'packer_remote_username=root' \
       -var 'packer_remote_password=VMware1!' \
       vmware-esxi-appliance-6.0U2.json
```

Note: All provided packer templates use *VMware1!* as the root/administrator password.

## Legal

Copyright © 2016 VMware, Inc.  All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the “License”); you may not
use this file except in compliance with the License.  You may obtain a copy of
the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an “AS IS” BASIS, without warranties or
conditions of any kind, EITHER EXPRESS OR IMPLIED.  See the License for the
specific language governing permissions and limitations under the License.
