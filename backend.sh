#!/bin/bash

RESOURCE_GROUP_NAME=tfbackend-rg
STORAGE_ACCOUNT_NAME=state$RANDOM # State(RandomNumber)
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# We can manually create the storage account and container in azure, But I used this script to do so