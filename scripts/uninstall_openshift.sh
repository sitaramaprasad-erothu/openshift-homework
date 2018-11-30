#!/usr/bin/env bash

#Run the uninstall playbook
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml

#Remove leftover content
ansible all -a "rm -rf /etc/origin/*"

#Remove leftover content
ansible all -a "rm -rf /root/.ansible/tmp/*"

#Remove leftover content
ansible all -a "rm -rf /home/ec2-user/.ansible/*"

#Remove any data from the NFS Server
ansible nfs -a "rm -rf /srv/nfs/*"

rm -rf /etc/origin
