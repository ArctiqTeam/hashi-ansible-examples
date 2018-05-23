#!/bin/bash
terraform apply -auto-approve
terraform state pull > .terraform/local.tfstate
TF_STATE=.terraform/local.tfstate ansible-playbook -i $(which terraform-inventory) site.yml