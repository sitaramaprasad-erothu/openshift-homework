# Create Projects

oc login -u system:admin

oc adm new-project alpha-cicd-dev --node-selector='client=alpha'
oc adm new-project alpha-task-dev --node-selector='client=alpha'
oc adm new-project alpha-task-test --node-selector='client=alpha'
oc adm new-project alpha-task-prod --node-selector='client=alpha'


# Grant Jenkins Access to Projects

oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-dev
sleep 10
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-test
sleep 10
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-prod
sleep 10

oc adm policy add-role-to-group admin alpha-corp -n alpha-task-dev
oc adm policy add-role-to-group admin alpha-corp -n alpha-task-test
oc adm policy add-role-to-group admin alpha-corp -n alpha-task-prod
oc adm policy add-role-to-group admin alpha-corp -n alpha-cicd-dev

oc login -u andrew -p r3dh4t1!

#oc new-app jenkins-persistent --param ENABLE_OAUTH=true --param MEMORY_LIMIT=2Gi --param VOLUME_CAPACITY=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true -n alpha-cicd-dev

oc new-app jenkins-persistent -n alpha-cicd-dev
# Deploy Demo
oc new-app -n alpha-task-build -f /root/openshift-homework/yaml/alpha-corp-cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline
