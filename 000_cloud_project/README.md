# Infrastructure as Code (IaC) using Azure Bicep project

- [ ] [Project Description](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/proj_description_requirements.md)

- [ ] [Miro board for Project Management](https://miro.com/app/board/uXjVMTGcfGo=/?share_link_id=227067548492)

- [ ] [Setting Up my IaC using Azure Bicep Environment]()

- [ ] [Version 1.0 Assumptions and Services](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.0_assumptions_services.md)

- [ ] [A working CDK / Bicep app from the MVP]()

- [ ] [Design Documentation]()

- [ ] [Decision Documentation](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/beslissing_doc.md)

- [ ] [Time logs](https://github.com/techgrounds/techgrounds-anj-dtmr/tree/main/000_cloud_project/tijd_logs)

- [ ] [Final presentation]()

## Setting Up my IaC using Azure Bicep Environment

#### Prerequisites

To use Azure Bicep, you'll need a few tools set up on your local machine, all of which are available for macOS, Linux and Windows. These prerequisites include the following:

- [x] an integrated development environment, such as Visual Studio Code;
- [x] the Azure command line interface (CLI) installed and configured;
- [x] a Microsoft Azure account; and
- [x] optionally, the Bicep VS Code extension.

1. Install Azure CLI: This provides command-line access to Azure services and resources. Instructions can be found at: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

2. Download & Launch Visual Studio Code

3. Install the Azure CLI Tools extension in Visual Studio Code: After launching our VSCode, we are going to search and install the Azure CLI tool in the extension tab.

4. Install the Azure Bicep CLI extension: This enables us to work with Bicep files.

5. Start Working with Azure CLI Tools in Visual Studio Code

To verify your current version, run:
`az --version`

To validate your Bicep CLI installation, use:
`az bicep version`

To login to your azure account, use:
`az login`

This will open Azure sign-in page on your default browser window. Click on the Signed In button and you will successful login to your Azure account.

We have successfully installed Azure CLI in Visual Studio Code and used it to access our Azure account.

You're done with setting up your Bicep environment.