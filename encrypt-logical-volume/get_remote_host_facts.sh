#!/bin/bash


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

# running playbook
echo executing: ansible -m setup  -i $INV_FILE \
    -e "ansible_connection=ssh" \
    -e "ansible_ssh_user=$ANSIBLE_USER" \
    -e "ansible_ssh_pass=$ANSIBLE_PASS" \
    -e "ansible_become_pass=$ANSIBLE_PASS" 

ansible all -m setup -i $INV_FILE \
    -e "ansible_connection=ssh" \
    -e "ansible_ssh_user=$ANSIBLE_USER" \
    -e "ansible_ssh_pass=$ANSIBLE_PASS" \
    -e "ansible_become_pass=$ANSIBLE_PASS" 

rc=$?

# removing temporary inventory file
echo removing temporary inventory file
rm $INV_FILE
 
exit $rc
