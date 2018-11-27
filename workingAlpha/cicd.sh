# Create Projects
#oc new-project alpha-task-dev --display-name="Alpha-Tasks-Dev"
#oc new-project alpha-task-test --display-name="Alpha-Tasks-TEST"
#oc new-project alpha-task-prod --display-name="Alpha-Tasks-Prod"
#oc new-project alpha-cicd-dev --display-name="Alpha-CICD-Task"

#oc label namespace alpha-task-dev client=alpha
#oc label namespace alpha-task-test client=alpha
#oc label namespace alpha-task-prod client=alpha
#oc label namespace alpha-cicd-dev client=alpha

oc adm new-project alpha-task-dev --node-selector='client=alpha'
oc adm new-project alpha-task-test --node-selector='client=alpha'
oc adm new-project alpha-task-prod --node-selector='client=alpha'
oc adm new-project alpha-cicd-dev --node-selector='client=alpha'

# Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-dev
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-test
oc policy add-role-to-group edit system:serviceaccounts:alpha-cicd-dev -n alpha-task-prod

# Deploy Demo
oc new-app -n alpha-cicd-dev -f cicd_template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline
