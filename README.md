## Prerequisites

- terraform >= v1.0
- aws-cli
- kubectl
- helm

## Run stuff

### 1. VPC

```bash
terraform -chdir=01_vpc init
terraform -chdir=01_vpc apply
```

### 2. EKS

Might have to be applied 2-3 times until it reaches `No changes. Your infrastructure matches the configuration.`

```bash
terraform -chdir=02_eks init

# Environment variables prefixed with TF_VAR_ are auto-passed to terraform as tf-vars
export TF_VAR_vpc_subnet_ids=$(terraform -chdir=01_vpc output -json vpc_private_subnet_ids | jq -c) 
export TF_VAR_vpc_id=$(terraform -chdir=01_vpc output -raw vpc_id)
terraform -chdir=02_eks apply
```

#### 2.1. Connect to Cluster

Once set-up, you can use the kubeconfig file to interact with the EKS cluster

```bash
export VAR_REGION=$(terraform -chdir=02_eks output -raw region)
export VAR_CLUSTER_NAME=$(terraform -chdir=02_eks output -raw cluster_name)
aws eks --region $VAR_REGION update-kubeconfig --name $VAR_CLUSTER_NAME
```

### 3. Controllers & Operators

```bash
terraform -chdir=03_controllers init

# Environment variables prefixed with TF_VAR_ are auto-passed to terraform as tf-vars
export TF_VAR_cluster_name=$(terraform -chdir=02_eks output -raw cluster_name)
export TF_VAR_oidc_url=$(terraform -chdir=02_eks output -raw oidc_url)
export TF_VAR_oidc_arn=$(terraform -chdir=02_eks output -raw oidc_arn)
terraform -chdir=03_controllers apply
```
