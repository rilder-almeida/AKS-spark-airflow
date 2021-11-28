#

## Env Variables

### Set Aks custom variables

### Set Airflow custom variables

## AKS

### Apply Terraform

<code>
bash apply_terraform.sh
</code>

    - Terraform Init
    - Terraform Format & Validate & Plan
    - Terraform Apply

## K8s

### Set namespaces

<code>
kubectl create namespace argocd && \
kubectl create namespace airflow && \
kubectl create namespace processing
</code>

## ArgoCD

### Install ArgoCD

<code>
kubectl apply -n argocd -f <https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml>
</code>

### Get secret to login

<code>
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
</code>

### Port Forwarding to connect the application

user: admin

<code>
kubectl port-forward svc/argocd-server -n argocd 8080:443
</code>


## Airflow

### Install Airflow

<code>
helm repo add apache-airflow https://airflow.apache.org && \
helm install airflow apache-airflow/airflow --namespace airflow
</code>

### Config Airflow

#### Manual Configs

<code>
helm show values apache-airflow/airflow > airflow/airflow-values.yaml
</code>

#### Quick Configs

<code>
envsubst < ./kubernetes/airflow/airflow-values_template.yaml > ./kubernetes/airflow/airflow-values.yaml
</code>

#### Apply Configs

<code>
helm install airflow apache-airflow/airflow -f airflow/airflow-values.yaml -n airflow
</code>

### Get Airflow dashboard link

<code>
kubectl get svc -n airflow
</code>

### Change user pass

Security > List users > Show record > Reset password