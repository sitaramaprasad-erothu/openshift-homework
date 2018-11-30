#!/usr/bin/env bash

#Run the uninstall playbook
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml

#Remove leftover content
ansible all -a "rm -rf /etc/origin/*"

#Remove leftover content
ansible all -a "rm -rf /root/.ansible/tmp/*"

#Remove leftover content
ansible all -a "rm -rf /home/ec2-user/.ansible/*"

#Remove leftover content
ansible all -a "rm -rf /root/tmp/*"

#Remove leftover content
ansible all -a "rm -rf /root/.ansible/tmp/*"

#Remove leftover content
ansible all -a "rm -rf /tmp/*"

#Remove any data from the NFS Server
ansible nfs -a "rm -rf /srv/nfs/*"

rm -rf /root/.ansible/tmp/*
rm -rf /root/tmp/*
rm -rf /home/ec2-user/.ansible/*
rm -rf /root/.ansible/tmp/*
rm -rf /etc/origin/*
rm -rf /tmp/*
