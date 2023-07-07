# Deployment Process

This file:

- Explain the steps required to deploy the infrastructure using Bicep.
- Include any required parameters or variables and explain how they are used.
- Provide examples or code snippets illustrating the deployment process.

For this project, I created a custom deployment script using the Azure CLI to automate the deployment of the Azure resources.

Let's start deploying the Bicep project using a bash script (`deploy.sh`), you can follow these steps:

1. Clone the [Bicep project repository](https://github.com/techgrounds/techgrounds-anj-dtmr). Read the [Getting Started](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.0/Documentation/02_getting_started.md) for prerequisites, how to set up the environment and cloning instructions.

Note: The main.bicep and deploy.sh is saved at 000_cloud_project/v1.0/bicep_files
   
2. Open a terminal or command-line interface and navigate to the Bicep project directory. 

```bash
cd 000_cloud_project/v1.0/bicep_files
```

3. Run the following command to make the `deploy.sh` script executable:

```bash
chmod +x deploy.sh
```

4. Run the `deploy.sh` script by executing the following command:

```bash
./deploy.sh
```

This will execute the script and initiate the deployment using the Azure CLI.

This [bash script](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.0/bicep_files/deploy.sh) will authenticate with Azure CLI using the `az login` command, set the desired Azure subscription using `az account set`, and then deploy the Bicep template using `az deployment group create`. Make sure you have the Azure CLI installed and logged in with appropriate permissions to perform the deployment.

4. Open the azure portal to double check all the succesfully deployed resources.
