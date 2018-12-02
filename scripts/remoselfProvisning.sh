#!/usr/bin/env bash

#Removing Self Provisning from Users

oc login -u system:admin

oc patch clusterrolebinding.rbac self-provisioners -p '{"subjects": null}'