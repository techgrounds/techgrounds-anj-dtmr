#!/bin/bash

# Login to Azure
az login

# Set the subscription
az account set --subscription 'Cloud Student 1'

# Create the resource group
az group create --name RGcloud_project --location westeurope

# Deploy the template
az deployment group create --resource-group RGcloud_project --template-file main.bicep




# #!/bin/bash

# # Set variables for your deployment
# resourceGroupName="my-resource-group"
# deploymentName="my-bicep-deployment"
# location="westus"
# templateFile="main.bicep"

# # Login to Azure using the Azure CLI
# az login

# # Set the active Azure subscription (if needed)
# # az account set --subscription "<subscription-id>"

# # Create a resource group (if needed)
# # az group create --name "$resourceGroupName" --location "$location"

# # Validate the deployment
# az deployment group validate \
#   --resource-group $resourceGroupName \
#   --name $deploymentName \
#   --template-file $templateFile \
#   --parameters $parameterFile

# # Build the Bicep file and generate the ARM template
# bicep build "$templateFile"

# # Deploy the ARM template using Azure CLI
# az deployment group create \
#   --name "$deploymentName" \
#   --resource-group "$resourceGroupName" \
#   --template-file "${templateFile%.*}.json" \
#   --parameters "@${templateFile%.*}.parameters.json"
