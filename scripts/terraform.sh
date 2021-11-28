#!/bin/bash

# Run with:
# bash terraform.sh

clear
cd terraform

##
# Color  Variables
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Color Functions
##

ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}

terraform_init(){
    terraform init
    bash ../scripts/00-unset_variables.sh
    source ../scripts/01-set_variables.sh
    bash ../scripts/02-role-assignment.sh

}

terraform_format_plan(){
    terraform fmt -check=true -recursive=true
    terraform validate
    terraform plan 
}

terraform_apply(){
    terraform apply
    source ../scripts/03-get_credentials.sh
    az group delete --resource-group NetworkWatcherRG --yes --no-wait
    kubectl get svc
}

terraform_destroy(){
    ( terraform destroy && az group delete --resource-group NetworkWatcherRG --yes --no-wait ) || bash ../scripts/delete_all_infra.sh
    bash ../scripts/00-unset_variables.sh
}

menu(){
    echo -ne "
    Terraform Menu
    $(ColorGreen '1)') Terraform Init
    $(ColorGreen '2)') Terraform Format & Validate & Plan
    $(ColorGreen '3)') Terraform Apply
    $(ColorGreen '4)') Terraform Destroy
    $(ColorGreen '0)') Exit
    $(ColorBlue 'Choose an option:') "
            read a
            case $a in
                1) terraform_init ; menu ;;
                2) terraform_format_plan ; menu ;;
                3) terraform_apply ; menu ;;
                4) terraform_destroy ; menu ;;
            0) clear; exit 0 ;;
            *) echo -e $red"Wrong option."$clear; menu ;;
            esac
}

menu
clear