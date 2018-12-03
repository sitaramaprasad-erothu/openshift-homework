# Create Projects

oc login -u system:admin

oc new-project alpha-task-dev
oc new-project alpha-task-test
oc new-project alpha-task-prod
oc new-project alpha-cicd-dev

oc label namespace alpha-cicd-dev client=alpha
oc annotate namespace alpha-cicd-dev openshift.io/node-selector='client=alpha'
oc label namespace alpha-task-dev client=alpha
oc annotate namespace alpha-task-dev openshift.io/node-selector='client=alpha'
oc label namespace alpha-task-test client=alpha
oc annotate namespace alpha-task-test openshift.io/node-selector='client=alpha'
oc label namespace alpha-task-prod client=alpha
oc annotate namespace alpha-task-prod openshift.io/node-selector='client=alpha'

oc delete limitrange project-request-custom-default-limits -n alpha-cicd-dev

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

oc new-app jenkins-persistent -n alpha-cicd-dev
# Deploy Demo
oc new-app -n alpha-cicd-dev -f /root/openshift-homework/yaml/alpha-corp-cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline
