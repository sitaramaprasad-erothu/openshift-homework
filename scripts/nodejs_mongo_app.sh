#!/usr/bin/env bash

#Create Smoke Test Project
oc login -u system:admin
oc new-project smoke-test
#oc label namespace nodejs-common-test client=common
#oc annotate namespace smoke-test openshift.io/node-selector='client=common'
#oc adm policy add-role-to-group admin common -n smoke-test
#oc login -u user1 -p r3dh4t1!
#Add the NodeJS Mongo Application
oc new-app nodejs-mongo-persistent
#Check the status of the pods
oc get pods
#Sleep for 2 minutes
sleep 120
#Check the status of the pods again
oc get pods
#Check the Persistent Volume Claim for the Application
oc get pvc
#Check the Service Routes for the Application
oc get route
#Open URL to verify
curl `oc get route | grep example.opentlc.com | awk '{ print $2 }'`


