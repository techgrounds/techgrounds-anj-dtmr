# Deployment Process

Explain the steps required to deploy the infrastructure using Bicep.
Include any required parameters or variables and explain how they are used.
Provide examples or code snippets illustrating the deployment process.

To deploy multiple Bicep files at once, you can use the Azure CLI by specifying all the Bicep files in a single deployment command. Here's an example:

1. Open a terminal or command prompt.

2. Login to your Azure account using the following command:

```shell
az login
```

3. Change to the directory containing your Bicep files or provide the full paths to the Bicep files in the deployment command.

4. Run the deployment command with all the Bicep files specified. Here's an example command that deploys `network.bicep`, `storage.bicep`, and `keyvault.bicep`:

```
az group create --name TestRGcloud_project --location westeurope

az deployment group create \
  --resource-group TestRGcloud_project \
  --template-file network.bicep storage.bicep keyvault.bicep
```

Make sure to replace `"MyResourceGroup"` with the name of your desired resource group. The above command deploys the `network.bicep`, `storage.bicep`, and `keyvault.bicep` files in one deployment operation.

By executing this command, all the specified Bicep files will be deployed in parallel or sequentially, depending on the size and complexity of the deployment.

Remember to modify the command based on your specific scenario, such as providing the correct resource group name, adjusting file paths, and including any necessary parameters or variables required by the Bicep files.

You can run this command directly in the Azure CLI or incorporate it into a script for automation or repeated deployments.

5. Monitor the deployment:
   - The deployment command will return a deployment ID. You can use this ID to monitor the deployment progress using the following command:
     ```
     az deployment sub show --name <deployment_id>
     ```
   - Replace `<deployment_id>` with the ID returned by the previous deployment command.

If you are unsure about the <deployment_id> value or you don't have the specific deployment identifier, you can list all the deployments in the current subscription using the command az deployment sub list:

```
az deployment sub list
```

This command will return a list of all deployments in the current subscription, including their respective deployment IDs. From the list, you can identify the deployment you are interested in and retrieve its details using the az deployment sub show command mentioned earlier.

That's it! Azure CLI will handle the deployment of your Azure Resource Group using the Bicep file you created. You can check the Azure portal or use Azure CLI to verify the deployed resources.

<!-- ToDo: How to deploy in group -->

<!-- az login
az account set --subscription 'Cloud Student 1'
az group create --name TestRGcloud_project --location westeurope
az deployment group create --resource-group TestRGcloud_project --template-file network.bicep keyvault.bicep storage.bicep -->
