# Create Projects
oc new-project task-dev --display-name="Tasks - Dev"
oc new-project task-test --display-name="Tasks - TEST"
oc new-project task-prod --display-name="Tasks - Prod"
oc new-project cicd --display-name="CI/CD"

# Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccounts:cicd -n task-dev
oc policy add-role-to-group edit system:serviceaccounts:cicd -n task-test
oc policy add-role-to-group edit system:serviceaccounts:cicd -n task-prod

# Deploy Demo
oc new-app -n cicd -f cicd-template.yaml

# Sleep for 5 minutes and then Start Pipeline
sleep 300
oc start-build tasks-pipeline
