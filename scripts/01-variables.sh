#!/bin/bash

# Apply with:
# source ./scripts/01-variables.sh

# Set personal variables
export TF_VAR_location="westus"
export TF_VAR_cluster_name="aks-cluster"
export TF_VAR_rg_name="aks-rg"

# Set Azure Account variables
export TF_VAR_tenant_id=$(az account show --query tenantId -o tsv)
export TF_VAR_subscription_id=$(az account show --query id -o tsv)

export SERVICE_PRINCIPAL_NAME="aks-service-principal"
export SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment --name $SERVICE_PRINCIPAL_NAME -o json)
export TF_VAR_serviceprinciple_id=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export TF_VAR_serviceprinciple_key=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

# Set ssh key variables
ssh-keygen -t rsa -b 4096 -C $(az account show --query user.name -o tsv) -q -f  ~/.ssh/id_rsa
export TF_VAR_ssh_key=$(cat ~/.ssh/id_rsa.pub)