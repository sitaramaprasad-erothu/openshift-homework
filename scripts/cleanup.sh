#!/usr/bin/env bash

oc login -u system:admin
oc delete projects alpha-task-build alpha-task-dev alpha-task-prod alpha-task-test
rm -f /root/openshift-homework/scripts/cicd.sh
cd /root/openshift-homework
git pull origin master
chmod +x scripts/cicd.sh
./scripts/cicd.sh
