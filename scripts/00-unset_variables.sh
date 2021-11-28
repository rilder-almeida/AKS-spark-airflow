# Apply with:
# bash ./scripts/00-unset_variables.sh

unset TF_VAR_location
unset TF_VAR_aks_name
unset TF_VAR_cluster_name
unset TF_VAR_cluster_rg_name

unset TF_VAR_tenant_id
unset TF_VAR_subscription_id

unset TF_VAR_kubernetes_version
unset TF_VAR_UUID

unset TF_VAR_sa_name
unset TF_VAR_storage_rg_name
unset TF_VAR_datalake_name

unset TF_VAR_ssh_key

unset SERVICE_PRINCIPAL_NAME
unset SERVICE_PRINCIPAL_JSON
unset TF_VAR_serviceprinciple_id
unset TF_VAR_serviceprinciple_key

echo "Remaining variables:"
env | grep TF_VAR*
env | grep SERVICE_PRINCIPAL*