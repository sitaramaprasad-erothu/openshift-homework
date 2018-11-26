# Create Projects
comp=$1
oc login -u system:admin
oc new-project $comp-task-dev --display-name="Tasks - Dev"
oc new-project $comp-task-test --display-name="Tasks - TEST"
oc new-project $comp-task-prod --display-name="Tasks - Prod"
oc new-project $comp-task-build --display-name="CI/CD"

# Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccounts:task-build -n $comp-task-dev
oc policy add-role-to-group edit system:serviceaccounts:task-build -n $comp-task-test
oc policy add-role-to-group edit system:serviceaccounts:task-build -n $comp-task-prod
oc policy add-role-to-group edit system:serviceaccounts:task-build -n $comp-task-build

oc policy add-role-to-group admin alpha-corp -n $comp-task-dev
oc policy add-role-to-group admin alpha-corp -n $comp-task-test
oc policy add-role-to-group admin alpha-corp -n $comp-task-prod
oc policy add-role-to-group admin alpha-corp -n $comp-task-build

oc adm pod-network join-projects --to=$comp-task-build $comp-task-dev $comp-task-test $comp-task-prod >/dev/null 2>&1

oc login -u amy -p r3dh4t1!

oc project $comp-task-build

oc new-app jenkins-persistent -n $comp-task-build

# Deploy Demo
oc new-app -n $comp-task-build -f /root/openshift-homework/yaml/cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline