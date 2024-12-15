# Authenticating Terraform with Azure

Terraform is a tool that automates the provisioning and management of resources in cloud environments. To perform these operations, Terraform needs permission to interact with Azure's control plane (Azure Resource Manager, or ARM). This is where authentication comes into play.

Setting up authentication between Terraform and Azure involves configuring Terraform to securely access your Azure resources. This is done by providing Terraform with credentials to communicate with the Azure Resource Manager (ARM) API, which is the control plane for Azure services.

## Possible Ways to Authenticate Terraform with Azure

Terraform provides multiple ways to authenticate with Azure. The method you choose depends on your use case (development, production, CI/CD, etc.) and security requirements. Let’s explore each option in detail:

### Authenticate with Azure using Azure CLI

This method is the simplest way to set up authentication, especially for development or testing environments.

- **Log in to Azure**:

  - Open a terminal and run:

    ```
    az login
    ```

  - This will open a browser where you can log in with your Azure credentials. If you’re in a terminal-only environment, use the --use-device-code option to authenticate.
  - After logging in, Azure CLI will display your active subscriptions.

- **Set the Default Subscription (Optional)**:

  - If you have multiple subscriptions, set the default one for Terraform:

    ```
    az account set --subscription "SUBSCRIPTION_ID_OR_NAME"
    ```

  - Verify Access:

    ```
    az account show
    ```

  - This shows the current subscription details.

- **Configure Terraform Provider**:

  In your Terraform configuration, define the Azure provider like this:

  ```
  provider "azurerm" {
    features = {}
  }
  ```

  Terraform will use the credentials stored by az login.

- **Pros**:
  - Quick and easy setup.
  - Useful for local development and testing.

- **Cons**:
  - Not suitable for automation or production environments.
  - Credentials expire after a certain period.

<br>

### Authenticate Using a Service Principal (Recommended for Production)
