#!/bin/bash

# Apply with:
# source ./scripts/03-get_credentials.sh

az aks get-credentials --resource-group $TF_VAR_rg_name --name $TF_VAR_cluster_name --overwrite-existing