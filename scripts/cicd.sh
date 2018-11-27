# Create Projects

oc login -u system:admin
oc new-project alpha-task-dev --display-name="Alpha-Tasks-Dev"
oc new-project alpha-task-test --display-name="Alpha-Tasks-TEST"
oc new-project alpha-task-prod --display-name="Alpha-Tasks-Prod"
oc new-project cicd --display-name="Alpha-Tasks-Build"

## Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccount:cicd -n alpha-task-dev
oc policy add-role-to-group edit system:serviceaccount:cicd -n alpha-task-test
oc policy add-role-to-group edit system:serviceaccount:cicd -n alpha-task-prod
oc policy add-role-to-group edit system:serviceaccount:cicd -n cicd


oc policy add-role-to-group admin alpha-corp -n alpha-task-dev
oc policy add-role-to-group admin alpha-corp -n alpha-task-test
oc policy add-role-to-group admin alpha-corp -n alpha-task-prod
oc policy add-role-to-group admin alpha-corp -n cicd

oc adm pod-network join-projects --to=cicd alpha-task-dev alpha-task-test alpha-task-prod >/dev/null 2>&1

# oc login -u amy -p r3dh4t1!

oc project alpha-task-build

oc new-app jenkins-persistent -n cicd
#oc new-app jenkins-ephemeral -n alpha-task-build

# Deploy Demo
oc new-app -n cicd -f /root/openshift-homework/yaml/cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 298
oc start-build tasks-pipeline