#!/usr/bin/env bash

#Run the uninstall playbook
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml

#Remove leftover content
ansible nodes -a "rm -rf /etc/origin"

#Remove any data from the NFS Server
ansible nfs -a "rm -rf /srv/nfs/*"
