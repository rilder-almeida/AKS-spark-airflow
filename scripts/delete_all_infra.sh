az aks stop --name $TF_VAR_cluster_name --resource-group $TF_VAR_rg_name --no-wait
az aks delete --name $TF_VAR_cluster_name --resource-group $TF_VAR_rg_name --yes --no-wait
az group delete --resource-group $TF_VAR_rg_name --yes --no-wait
az group delete --resource-group MC_${TF_VAR_rg_name}_${TF_VAR_cluster_name}_${TF_VAR_location} --yes --no-wait

# az storage account delete --name $TF_VAR_datalake_name