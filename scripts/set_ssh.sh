#!/bin/bash

# Run with:
# bash set_ssh.sh

# Set ssh key variables
ssh-keygen -t rsa -b 4096 -C $(az account show --query user.name -o tsv) -q -f  ~/.ssh/id_rsa
export TF_VAR_ssh_key=$(cat ~/.ssh/id_rsa.pub)