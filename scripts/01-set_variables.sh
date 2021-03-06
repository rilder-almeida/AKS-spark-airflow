#!/bin/bash

# Apply with:
# source ./scripts/01-set_variables.sh

# Set UUID
UUID=$(cat /proc/sys/kernel/random/uuid) && export TF_VAR_UUID=$(echo "${UUID: -12}")

# ---------------------------------------------------------------------------------------------------------------------
# Terraform variables

# Set cluster variables
export TF_VAR_location="eastus"
export TF_VAR_cluster_name="aks-cluster"
export TF_VAR_cluster_rg_name="aks-rg"
#  az aks get-versions --location $TF_VAR_location | jq -r .orchestrators[].orchestratorVersion
export TF_VAR_kubernetes_version="1.20.9"

# Set storage variables
export TF_VAR_sa_name="sa$TF_VAR_UUID"
export TF_VAR_datalake_rg_name="datalake-rg"
export TF_VAR_datalake_name="datalake-$TF_VAR_UUID"

# Set Azure Account variables
export TF_VAR_tenant_id=$(az account show --query tenantId -o tsv)
export TF_VAR_subscription_id=$(az account show --query id -o tsv)

export SERVICE_PRINCIPAL_NAME="aks-service-principal"
export SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment --name $SERVICE_PRINCIPAL_NAME -o json)
export TF_VAR_serviceprinciple_id=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export TF_VAR_serviceprinciple_key=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

# Set ssh key variables
# [ ! -f ~/.ssh/id_rsa ] && ssh-keygen -t rsa -b 4096 -C $(az account show --query user.name -o tsv) -q -f ~/.ssh/id_rsa
ssh-keygen -t rsa -b 4096 -C $(az account show --query user.name -o tsv) -q -f ~/.ssh/id_rsa
export TF_VAR_ssh_key=$(cat ~/.ssh/id_rsa.pub)

# ---------------------------------------------------------------------------------------------------------------------
# Airflow variables

export AIRFLOW_VAR_username="rilderalmeida"
export AIRFLOW_VAR_email="airflow@airflow.com"
export AIRFLOW_VAR_firstname="rilder"
export AIRFLOW_VAR_lastname="almeida"

export AIRFLOW_VAR_git_repo="https://github.com/rilder-almeida/AKS-spark-airflow.git"

export AIRFLOW_VAR_fernet_key=$(python3 -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())")
export AIRFLOW_VAR_webserver_secret_key=$(python3 -c "import secrets; print(secrets.token_hex(16))")

# ---------------------------------------------------------------------------------------------------------------------
# Show setted variables
echo "Setted env variables:"
echo "Terraform:"
env | grep TF_VAR*
env | grep SERVICE_PRINCIPAL*
echo "Airflow:"
env | grep AIRFLOW_VAR_*