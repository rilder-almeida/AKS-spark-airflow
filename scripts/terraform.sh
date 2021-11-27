#!/bin/bash

# Apply with:
# bash ./scripts/terraform.sh

clear 

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
    cd terraform
    terraform init 
}

terraform_format_plan(){
    cd terraform
    terraform fmt -list=true -check=true -diff=true -recursive=true
    terraform plan 
}

terraform_apply(){
    cd terraform
    terraform apply 
}

terraform_destroy(){
    cd terraform
    terraform destroy 
}

menu(){
    echo -ne "
    Terraform Menu
    $(ColorGreen '1)') Terraform Init
    $(ColorGreen '2)') Terraform Format & Plan
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