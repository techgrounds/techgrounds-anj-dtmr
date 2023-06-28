# Getting Started

This file:

- Describe the prerequisites for using the Bicep project (e.g., required tools, permissions, dependencies).
- Provide instructions for setting up the development environment (installing Bicep CLI, configuring Azure credentials, etc.).
- Explain how to clone or download the project repository.

## Prerequisites for using this Bicep project

- [ ] Azure Subscription: You need an active Azure subscription to provision and manage resources using Bicep. If you don't have an Azure subscription, you can create a free account on the Azure portal. In this case if you are a Techgrounds student, your learning coach will provide help and details (like email) upon creating your azure account with an azure subscription under the academy.

- [ ] Azure CLI: The Azure CLI is often used in conjunction with Bicep for managing Azure resources. It's a cross-platform command-line tool that provides a set of commands for interacting with Azure services. Install the Azure CLI if you haven't already. Bicep relies on Azure CLI for authenticating and executing deployment commands. Follow this [instructions](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).

- [ ] Azure Subscription Permissions: Ensure that you have sufficient permissions in your Azure subscription to deploy resources. You need at least the Contributor role or a custom role with similar permissions to create and manage resources. Contact your Azure subscription owner (Your Techgrounds learning coach) or administrator if you need to request or modify permissions.

- [ ] Azure Resource Manager (ARM) Templates: Bicep is based on Azure Resource Manager (ARM) templates, which are JSON files used to define and deploy Azure resources. While not mandatory, having a basic understanding of ARM templates can be helpful when working with Bicep.

- [ ] [Learn modules for Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/learn-bicep): As a trainee having a basic understanding of Bicep templates can be helpful when you would want to deploy this project to your environment. Here's the official [Bicep documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

- [ ] Text Editor or Integrated Development Environment (IDE): Choose a text editor or IDE that suits your preferences for editing Bicep files. Popular choices include Visual Studio Code (with the Bicep extension installed), Visual Studio, or any other text editor with syntax highlighting and Bicep language support.

Optional but not needed in this project:

- [ ] Azure Service Principal (optional): In certain scenarios, you might need to create an Azure Service Principal to authenticate and authorize access to your Azure resources. This is commonly used when integrating Bicep deployments into automated pipelines or when deploying resources to separate Azure tenants or subscriptions.
- [ ] Bicep CLI (optional): Install the Bicep CLI, which is the command-line tool used to compile and deploy Bicep files. The CLI is available for different operating systems (Windows, macOS, Linux) and can be downloaded from the official Bicep GitHub repository or installed through package managers like Homebrew (macOS) or Chocolatey (Windows).

## Instructions for setting up the environment for this project

To set up your development environment for working with Bicep, follow these instructions:

1. **Install Visual Studio Code**: Visual Studio Code (VS Code) is a popular code editor with excellent Bicep support. Download and install the latest version of VS Code from the official website: [https://code.visualstudio.com](https://code.visualstudio.com).

2. **Install the Bicep extension from VSCode**: Launch VS Code and open the Extensions view by clicking on the square icon on the left sidebar or pressing `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (macOS). Search for "Bicep" in the Extensions view, click on the "Bicep" extension by "Microsoft", and click the "Install" button.

3. **Install the Bicep CLI**: The Bicep CLI allows you to compile and deploy Bicep files. Open your preferred command-line interface (e.g., PowerShell, Command Prompt, or Terminal) and run the following command to install the Bicep CLI:

   ```bash
   curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-{OS}.azcli && chmod +x ./bicep
   ```

   Replace `{OS}` with `windows`, `macos`, or `linux` based on your operating system. This command downloads the Bicep CLI binary and makes it executable.

4. **Add the Bicep CLI to the system path**: To use the Bicep CLI globally, add it to your system's executable path. You can either move the `bicep` binary to a directory already in the path (e.g., `/usr/local/bin` on macOS/Linux) or add the directory containing the `bicep` binary to the path environment variable.

5. **Verify the Bicep installation**: Open a new command-line interface and run the following command to ensure that the Bicep CLI is successfully installed:

   ```bash
   bicep --version
   ```

   You should see the version number of the Bicep CLI printed on the console.

6. **Install Azure CLI (optional)**: If you haven't already installed the Azure CLI, you can do so by following the instructions provided by Microsoft in their documentation: [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

7. **Azure Account and Authentication**: Ensure that you have an Azure account and the necessary credentials to authenticate with Azure services. If you don't have an Azure account, you can create a free account on the Azure portal. Use the Azure CLI or Azure Portal to authenticate and set up your Azure credentials.

   - **Azure CLI**: Run the following command and follow the prompts to authenticate with Azure:

     ```bash
     az login
     ```

   - **Azure Portal**: Sign in to the Azure Portal ([https://portal.azure.com](https://portal.azure.com)) and navigate to the Azure Active Directory section to manage your account and access keys.

Once you've completed these steps, your development environment is set up for working with this Bicep project. Refer to the Bicep documentation and Azure documentation for more details on using Bicep and deploying resources to Azure.

Here's the official documentation how to [Install Bicep tools](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)

## How to clone or download the project repository

1. Access the Bicep project repository: Go to the [GitHub website](https://github.com/) and log in to your account. Navigate to the Bicep project. Here's the [repository](https://github.com/techgrounds/techgrounds-anj-dtmr). The project root folder is 000_cloud_project/v1.0.

2. Choose a cloning method:

- If you want to clone the repository using a [Git](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
- If you want to clone the repository using a [GitHub Desktop](https://docs.github.com/en/desktop/contributing-and-collaborating-using-github-desktop/adding-and-cloning-repositories/cloning-a-repository-from-github-to-github-desktop)
- If you want to download the repository as a ZIP file without using Git, click on the "Code" button on the repository page, and then select "Download ZIP". This option allows you to download the repository as a compressed ZIP file without the version control capabilities of Git.

3. Access the downloaded repository:

- If you downloaded the repository as a ZIP file, locate the downloaded file on your local machine and extract its contents to a directory of your choice.
- If you cloned the repository using Git/GitHub Desktop, the repository will be cloned to a directory with the same name as the repository. Navigate to that directory in your command-line interface or file explorer to access the repository files.

Now you have successfully cloned or downloaded the Bicep project repository. You can open the project in your preferred code editor, such as Visual Studio Code, and start playing around with the Bicep files in the repository.

Go back to the main [README.md]() for the next steps on documentation or go to [Deployment Process]() to start deploying Azure resources.
