# Intro
This repo contains a playbook allowing to increase a logical volume  
following an increase of the underlying (virtual) disk size.

This is largely inspired by https://www.epilis.gr/en/blog/2017/08/09/extending-root-fs-whole-farm/


# Complete procedure
Steps :
1. Remove all snapshots for the VMs in vSphere/ESXi
2. Shutdown the VMs
3. Increase the disk size
4. Execute the playbook playbook.yaml.


# How to run the playbook
Simply define the environment variable TARGET_HOST and then execute
```
./play.sh
```

