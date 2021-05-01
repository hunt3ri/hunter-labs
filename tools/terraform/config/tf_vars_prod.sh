#!/usr/bin/env bash
# Initialise all TF_VARS environment variables for prod environment

printf "Setting tfinit as terraform init alias\n\n"
alias tfinit="terraform init --backend-config=/tools/terraform/config/backend_prod.config"
# Env var can be accessed by scripts requiring to run terraform init
export TFINIT="terraform init --backend-config=/tools/terraform/config/backend_prod.config"

printf "Setting global terraform vars for PROD environment\n\n" && sleep 0.5
export TF_VAR_bucket="hunter-ops-tfstate" && printf "TF_VAR_bucket: `echo $TF_VAR_bucket`\n" && sleep 0.5
export TF_VAR_environment="prod" && printf "TF_VAR_environment: `echo $TF_VAR_environment`\n" && sleep 0.5
export TF_VAR_profile="hunter_ops_prod" && printf "TF_VAR_profile: `echo $TF_VAR_profile`\n" && sleep 0.5
export TF_VAR_region="us-east-1" && printf "TF_VAR_region: `echo $TF_VAR_region`\n" && sleep 0.5
export TF_VAR_aws_account="222866594907" && printf "TF_VAR_region: `echo $TF_VAR_aws_account`\n" && sleep 0.5
export TF_VAR_org_name="hunter-labs" && printf "TF_VAR_org_name: `echo $TF_VAR_org_name`\n" && sleep 0.5
