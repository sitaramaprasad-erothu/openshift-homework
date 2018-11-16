#!/usr/bin/env bash

#Create Smoke Test Project
oc new-project smoke-test
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
curl http://nodejs-mongo-persistent-smoke-test.apps.$GUID.example.opentlc.com
#Delete the Smoke Test Project
oc delete project smoke-test

