#!/usr/bin/env bash

echo "Deploy App to Alpha Corp"
ansible-playbook -i /root/openshift-homework/container-pipelines/basic-spring-boot/.applier/ galaxy/openshift-applier/playbooks/openshift-cluster-seed.yml 

echo "Sleep 2 min"
sleep 120
