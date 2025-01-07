terraform {
  backend "azurerm" {
    resource_group_name  = "tfbackend-rg"                         # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "state27447"                    # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "demo.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}  
# key is the name of the terraform tfstate file



# *************  Incase we use githubActions to set fields during pipeline run  **************

# terraform {
#   backend "azurerm" {}   ( when we push code to GH we set these values in repo secret and run tf init and passing these 4 fields as -backend-config )
# }

# *** EG
  #  - name: Terraform Init
  #     id: init
  #     run: |
  #       terraform init \
  #         -backend-config="resource_group_name=${{ secrets.BACKEND_RESOURCE_GROUP }}" \
  #         -backend-config="storage_account_name=${{ secrets.BACKEND_STORAGE_ACCOUNT }}" \
  #         -backend-config="container_name=${{ secrets.BACKEND_CONTAINER }}" \
  #         -backend-config="key=${{ secrets.BACKEND_KEY }}"