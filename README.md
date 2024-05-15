## Prerequisites

- terraform >= v1.0

## Run stuff

VPC

```bash
terraform -chdir=01_vpc init
terraform -chdir=01_vpc apply
```

EKS

Might have to be applied 2-3 times until it reaches `No changes. Your infrastructure matches the configuration.`

```bash
terraform -chdir=02_eks init

# Environment variables prefixed with TF_VAR_ are auto-passed to terraform as tf-vars
export TF_VAR_vpc_subnet_ids=$(terraform -chdir=01_vpc output -json vpc_private_subnet_ids | jq -c) 
export TF_VAR_vpc_id=$(terraform -chdir=01_vpc output -raw vpc_id)
terraform -chdir=02_eks apply
```
