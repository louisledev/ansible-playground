#!/bin/bash


export KUBECONFIG=$PWD/cluster.config
export K8S_AUTH_KUBECONFIG=$KUBECONFIG

if [ -z "${MASTER_HOSTS}" ]; then
	echo MASTER_HOSTS is not defined
	exit 1
fi

PLAYBOOK=playbook.yaml
if ! [[ -f $PLAYBOOK ]]; then 
	echo Playbook $PLAYBOOK does not exist
	exit 1
fi

export INVENTORY_FILE=$PWD/tmp_inventory.ini

OLD_IFS=$IFS
IFS=','
MASTER_LIST=($MASTER_HOSTS)
IFS=$OLD_IFS

echo "creating temporary inventory file ($INVENTORY_FILE)"
echo "# auto-generated inventory file" > $INVENTORY_FILE
for i in "${!MASTER_LIST[@]}"; do
        echo "master${i} ansible_host=${MASTER_LIST[i]}  ansible_connection=ssh ansible_ssh_user=ai4rad ansible_ssh_pass=Philips! ansible_become_pass=Philips!" >> $INVENTORY_FILE    
done

echo "" >> $INVENTORY_FILE

echo "[masters]" >> $INVENTORY_FILE
for i in "${!MASTER_LIST[@]}"; do
    echo "master${i}" >> $INVENTORY_FILE
done


# running playbook
echo executing: ansible-playbook -i inventory.ini $PLAYBOOK
ansible-playbook -i $INVENTORY_FILE -e global_kubeconfig_path=$KUBECONFIG $PLAYBOOK 
rc=$?

rm $INVENTORY_FILE

exit $rc
