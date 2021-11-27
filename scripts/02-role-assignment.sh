#!/bin/bash

# Apply with:
# bash ./scripts/02-role-assignment.sh

az role assignment create --assignee $TF_VAR_serviceprinciple_id --scope "/subscriptions/$TF_VAR_subscription_id" --role Contributor