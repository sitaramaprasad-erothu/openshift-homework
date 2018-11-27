# Create Projects

oc login -u system:admin
oc new-project task-dev --display-name="Alpha-Tasks-Dev"
oc new-project task-test --display-name="Alpha-Tasks-TEST"
oc new-project task-prod --display-name="Alpha-Tasks-Prod"
oc new-project cicd --display-name="Alpha-Tasks-Build"

## Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccount:cicd -n task-dev
oc policy add-role-to-group edit system:serviceaccount:cicd -n task-test
oc policy add-role-to-group edit system:serviceaccount:cicd -n task-prod
oc policy add-role-to-group edit system:serviceaccount:cicd -n cicd


oc policy add-role-to-group admin alpha-corp -n task-dev
oc policy add-role-to-group admin alpha-corp -n task-test
oc policy add-role-to-group admin alpha-corp -n task-prod
oc policy add-role-to-group admin alpha-corp -n cicd

oc adm pod-network join-projects --to=cicd task-dev task-test task-prod >/dev/null 2>&1

# oc login -u amy -p r3dh4t1!

oc project cicd

oc new-app jenkins-persistent -n cicd
#oc new-app jenkins-ephemeral -n alpha-task-build

# Deploy Demo
oc new-app -n cicd -f /root/openshift-homework/yaml/cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 298
oc start-build tasks-pipeline