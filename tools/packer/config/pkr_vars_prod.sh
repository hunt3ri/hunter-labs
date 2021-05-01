#!/usr/bin/env bash
# Initialise all TF_VARS environment variables for prod environment

printf "Setting global packer vars for prod environment\n\n" && sleep 0.5
export PKR_VAR_org_name="hunter-labs" && printf "PKR_VAR_org_name: `echo $PKR_VAR_org_name`\n" && sleep 0.5
export PKR_VAR_profile="hunter_ops_prod" && printf "PKR_VAR_profile: `echo $PKR_VAR_profile`\n" && sleep 0.5
export PKR_VAR_region="us-east-1" && printf "PKR_VAR_region: `echo $PKR_VAR_region`\n" && sleep 0.5
