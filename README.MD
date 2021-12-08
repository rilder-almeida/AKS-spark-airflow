# [in development]

## Env Variables

    nano ./scripts/01-set_variables.sh

### Set Aks custom variables

- TF_VAR_location
- TF_VAR_cluster_name
- TF_VAR_cluster_rg_name
- TF_VAR_datalake_rg_name

### Set Airflow custom variables

- AIRFLOW_VAR_username
- AIRFLOW_VAR_email
- AIRFLOW_VAR_firstname
- AIRFLOW_VAR_lastname
- AIRFLOW_VAR_git_repo

## AKS

### Apply Terraform

    source ./scripts/01-set_variables.sh && \
    bash ./scripts/02-role-assignment.sh && \
    bash ./scripts/apply_terraform.sh

- Terraform Init
- Terraform Format & Validate & Plan
- Terraform Apply

## K8s

### Set namespaces

    kubectl create namespace argocd && \
    kubectl create namespace airflow && \
    kubectl create namespace processing

## ArgoCD

### Install ArgoCD

    kubectl apply -n argocd -f <https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml>

### Get secret to login

    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

### Port Forwarding to connect to ArgoCD

user: admin

    kubectl port-forward svc/argocd-server -n argocd 8080:443

## Airflow

### Get Airflow helm repo

    helm repo add apache-airflow https://airflow.apache.org

### Config Airflow

#### Manual Configs

    helm show values apache-airflow/airflow > airflow/airflow-values.yaml

#### Quick Configs

    envsubst < ./kubernetes/airflow/airflow-values_template.yaml > ./kubernetes/airflow/airflow-values.yaml

### Install Airflow

    helm install airflow apache-airflow/airflow -f ./kubernetes/airflow/airflow-values.yaml -n airflow

### Get Airflow service

    kubectl get svc -n airflow

### Port Forwarding to connect to Airflow

    kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow

- user: admin
- password: admin

### Change admin password

Security > List users > Show record > Reset password

### Set Azure connection

Admin > Connections > Add a new connection

    echo -e "Azure Client ID: $TF_VAR_serviceprinciple_id\nAzure Secret: $TF_VAR_serviceprinciple_key\nAzure Tenant ID: $TF_VAR_tenant_id\nAzure Subscription ID: $TF_VAR_subscription_id"
