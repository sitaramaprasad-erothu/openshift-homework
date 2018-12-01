# Create Projects

oc login -u system:admin

oc adm new-project beta-task-dev --node-selector='client=beta'
oc create -f /root/openshift-homework/yaml/env-projectlimit.yaml
oc adm new-project beta-task-test --node-selector='client=beta'
oc create -f /root/openshift-homework/yaml/env-projectlimit.yaml
oc adm new-project beta-task-prod --node-selector='client=beta'
oc create -f /root/openshift-homework/yaml/env-projectlimit.yaml
oc adm new-project beta-cicd-dev --node-selector='client=beta'
oc create -f /root/openshift-homework/yaml/cicd-projectlimit.yaml

#oc create -f /root/openshift-homework/yaml/projectlimit.yaml -n beta-task-dev
#oc create -f /root/openshift-homework/yaml/projectlimit.yaml -n beta-task-test
#oc create -f /root/openshift-homework/yaml/projectlimit.yaml -n beta-task-prod
#oc create -f /root/openshift-homework/yaml/projectlimit.yaml -n beta-cicd-dev


# Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccounts:beta-cicd-dev -n beta-task-dev
sleep 10
oc policy add-role-to-group edit system:serviceaccounts:beta-cicd-dev -n beta-task-test
sleep 10
oc policy add-role-to-group edit system:serviceaccounts:beta-cicd-dev -n beta-task-prod
sleep 10

oc adm policy add-role-to-group admin beta-corp -n beta-task-dev
oc adm policy add-role-to-group admin beta-corp -n beta-task-test
oc adm policy add-role-to-group admin beta-corp -n beta-task-prod
oc adm policy add-role-to-group admin beta-corp -n beta-cicd-dev

oc login -u brian -p r3dh4t1!

oc project beta-cicd-dev

oc new-app jenkins-persistent
# Deploy Demo
oc new-app -n beta-cicd-dev -f /root/openshift-homework/yaml/beta-corp-cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline
