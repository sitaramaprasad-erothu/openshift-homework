# Create Projects
#oc new-project beta-task-dev --display-name="Beta-Tasks - Dev"
#oc new-project beta-task-test --display-name="Beta-Tasks - TEST"
#oc new-project beta-task-prod --display-name="Beta-Tasks - Prod"
#oc new-project beta-cicd --display-name="Beta-CI/CD"



oc adm new-project alpha-task-dev --node-selector='client=alpha'
oc adm new-project alpha-task-test --node-selector='client=alpha'
oc adm new-project alpha-task-prod --node-selector='client=alpha'
oc adm new-project alpha-cicd-dev --node-selector='client=alpha'

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

oc login -u amy -p r3dh4t1!

oc project alpha-cicd-dev

oc new-app jenkins-persistent
# Deploy Demo
oc new-app -n alpha-cicd-dev -f cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline
