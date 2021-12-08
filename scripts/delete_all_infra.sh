# az aks start --name $TF_VAR_cluster_name --resource-group $TF_VAR_cluster_rg_name
az aks stop --name $TF_VAR_cluster_name --resource-group $TF_VAR_cluster_rg_name
az aks delete --name $TF_VAR_cluster_name --resource-group $TF_VAR_cluster_rg_name --yes --no-wait
az group delete --resource-group $TF_VAR_cluster_rg_name --yes --no-wait
az group delete --resource-group MC_${TF_VAR_cluster_rg_name}_${TF_VAR_cluster_name}_${TF_VAR_location} --yes --no-wait

az storage account delete --name $TF_VAR_sa_name 
az group delete --resource-group $TF_VAR_datalake_rg_name --yes --no-wait