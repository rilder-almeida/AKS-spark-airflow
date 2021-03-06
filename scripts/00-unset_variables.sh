# Apply with:
# bash ./scripts/00-unset_variables.sh

# ---------------------------------------------------------------------------------------------------------------------
# Terraform variables

unset TF_VAR_location
unset TF_VAR_aks_name
unset TF_VAR_cluster_name
unset TF_VAR_cluster_rg_name
unset TF_VAR_kubernetes_version

unset TF_VAR_tenant_id
unset TF_VAR_subscription_id

unset TF_VAR_UUID

unset TF_VAR_sa_name
unset TF_VAR_datalake_rg_name
unset TF_VAR_datalake_name

unset TF_VAR_ssh_key

unset SERVICE_PRINCIPAL_NAME
unset SERVICE_PRINCIPAL_JSON
unset TF_VAR_serviceprinciple_id
unset TF_VAR_serviceprinciple_key

# ---------------------------------------------------------------------------------------------------------------------
# Airflow variables

unset AIRFLOW_VAR_fernet_key
unset AIRFLOW_VAR_webserver_secret_key

unset AIRFLOW_VAR_username
unset AIRFLOW_VAR_email
unset AIRFLOW_VAR_firstname
unset AIRFLOW_VAR_lastname
unset AIRFLOW_VAR_git_repo

# ---------------------------------------------------------------------------------------------------------------------

echo "Remaining env variables:"
echo "Terraform:"
env | grep TF_VAR*
env | grep SERVICE_PRINCIPAL*
echo "Airflow:"
env | grep AIRFLOW_VAR_*