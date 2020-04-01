#!/bin/bash

PLAYBOOK=playbook.yaml
if ! [[ -f $PLAYBOOK ]]; then 
	echo Playbook $PLAYBOOK does not exist
	exit 1
fi

# running playbook
echo executing: ansible-playbook -i inventory.ini $PLAYBOOK
ansible-playbook -i inventory.ini $PLAYBOOK 
rc=$?
 
exit $rc
