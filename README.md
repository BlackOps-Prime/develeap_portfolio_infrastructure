
# Infrastructure As Code To Deploy A Kubernetes Cluster & A Helm ArgoCD Release

This repository provides Terraform code to create a Kubernetes cluster and deploy ArgoCD in an ArgoCD namespace.
## Overview

ArgoCD is a tool for declaratively managing applications in a Kubernetes cluster. It provides a GitOps workflow for deploying applications, allowing you to manage your application configuration as code in a Git repository.

This Terraform code creates a Kubernetes cluster in a AWS, installs the necessary tools, providers and deploys ArgoCD in an ArgoCD namespace. The ArgoCD installation includes an ingress, which allows you to access the ArgoCD UI from a web browser.
## Requirements


Before you begin, you will need:

- An AWS account and the necessary credentials. `[Check AWS IAM for more details]`
- The kubectl and helm command-line tools installed on your local machine
- The terraform command-line tool installed on your local machine
## Usage

To use this Terraform code, follow these steps:

- Clone this repository to your local machine.
- Create a `terraform.tfvars` file in the root directory of the repository. This file should contain preferred variable declarations for your project. You may use the provided one too.
- Initialize the Terraform workspace by running the following command:
```bash
  terraform init
```
- Generate a plan of the cluster and it's resources
```bash
  terraform plan
```
- Create the Kubernetes cluster by running the following command:
```bash
  terraform apply
```
PS: You can use the `--auto-approve` flag to auto approve the desired outcome.

- Wait for the Kubernetes cluster and ArgoCD application to be created. This may take several minutes.

- KubeConfig is automatically updated to use the new cluster so any kubectl command should work just fine with the right permissions.


## Accessing ArgoCD

You can acccess ArgoCD by forwarding traffic from your local machine to the ArgoCD server or using a configured Ingress.

### Port Forwarding: 
- To use Port-Forwarding, run this command:
```bash
  kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Using Ingress: 
If you have configured an ingress controller for your cluster, you can access argocd over a domain. Follow these steps;
- Locate the ArgoCD `values.yml` file inside the ArgoCD directory and set your domain under `Ingress:Hosts`
-  Add an entry to your hosts file on your local machine at /etc/hosts with the external IP of the Ingress-Controller and the name of the domain you set in the ArgoCD `values.yml` file.
- Save and exit.
- Open a web browser and enter the domain and ArgoCD should greet you with a smile... 