## Prerequisites

- terraform >= v1.0

## Run stuff

VPC

```bash
terraform -chdir=vpc init
terraform -chdir=vpc apply
```

EKS

```bash
terraform -chdir=eks-cluster init

# Environment variables prefixed with TF_VAR_ are auto-passed to terraform as tf-vars
export TF_VAR_vpc_subnet_ids=$(terraform -chdir=vpc output -json vpc_private_subnet_ids | jq -c) 
export TF_VAR_vpc_id=$(terraform -chdir=vpc output -raw vpc_id)
terraform -chdir=eks-cluster apply
```
