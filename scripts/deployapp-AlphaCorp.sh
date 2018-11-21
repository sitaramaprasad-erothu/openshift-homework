#!/usr/bin/env bash

echo "Deploy App to Alpha Corp"
cd /root/openshift-homework/container-pipelines/basic-spring-boot
ansible-galaxy install -r requirements.yml --roles-path=galaxy

ansible-playbook -i .applier/ galaxy/openshift-applier/playbooks/openshift-cluster-seed.yml 

echo "Sleep 2 min"
sleep 120
