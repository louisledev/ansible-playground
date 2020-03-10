#!/bin/bash

PLAYBOOK=playbook.yaml
if ! [[ -f $PLAYBOOK ]]; then 
	echo Playbook $PLAYBOOK does not exist
	exit 1
fi

if [[ -z $TARGET_HOST ]]; then
	echo target host is not defined. Please run 
	echo export TARGET_HOST=1.2.3.4
	exit 1
fi

# Creating temporary inventory file tmp_inventory.yml
INV_FILE=$PWD/tmp_inventory.yaml
if [[ -f $INV_FILE ]]; then
	echo temporary inventory file already exists:
	echo $INV_FILE
	echo exiting to prevent accidentally overwriting the file
	exit 1
fi

echo creating temporary inventory file
echo $TARGET_HOST > $INV_FILE
echo "[all:vars]" >> $INV_FILE
echo "docker_insecure_registries[]=\"192.168.100.26:5000\"" >> $INV_FILE


# running playbook
echo executing: ansible-playbook -i $INV_FILE $PLAYBOOK
ansible-playbook -i $INV_FILE $PLAYBOOK 
rc=$?

# removing temporary inventory file
echo removing temporary inventory file
# rm $INV_FILE
 
exit $rc