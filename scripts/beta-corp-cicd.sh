# Create Projects

oc login -u system:admin

oc new-project beta-task-dev
oc new-project beta-task-test
oc new-project beta-task-prod
oc new-project beta-cicd-dev

oc label namespace beta-cicd-dev client=beta
oc annotate namespace beta-cicd-dev openshift.io/node-selector='client=beta'
oc label namespace beta-task-dev client=beta
oc annotate namespace beta-task-dev openshift.io/node-selector='client=beta'
oc label namespace beta-task-test client=beta
oc annotate namespace beta-task-test openshift.io/node-selector='client=beta'
oc label namespace beta-task-prod client=beta
oc annotate namespace beta-task-prod openshift.io/node-selector='client=beta'

oc delete limitrange project-request-custom-default-limits -n beta-cicd-dev

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
