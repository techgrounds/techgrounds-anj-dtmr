#!/bin/bash

# # Set variables for your deployment
RESOURCE_GROUP_NAME=""
DEPLOYMENT_NAME=""
LOCATION=""
TEMPLATEFILE="main.bicep"

# Login to Azure
az login

# Set the subscription
# Replace <subscription-id>
az account set --subscription <subscription-id>

# Create the resource group
# Replace RESOURCE_GROUP_NAME and LOCATION
az group create --name RESOURCE_GROUP_NAME --location LOCATION

# Deploy the template
# Replace RESOURCE_GROUP_NAME and TEMPLATEFILE
az deployment group create --resource-group RESOURCE_GROUP_NAME --template-file TEMPLATEFILE



# ---------------------- EXAMPLE ------------------------
# #!/bin/bash

# # Set variables for your deployment
# resourceGroupName="cloud_proj"
# deploymentName="my-bicep-deployment"
# location="uksouth"
# templateFile="main.bicep"

# # Login to Azure using the Azure CLI
# az login

# # Set the active Azure subscription (if needed)
# # az account set --subscription "cloud-dev-1"

# # Create the resource group
# az group create --name cloud_proj --location uksouth

# # Deploy the template
# az deployment group create --resource-group cloud_proj --template-file main.bicep
