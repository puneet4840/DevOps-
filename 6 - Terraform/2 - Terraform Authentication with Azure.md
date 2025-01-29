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

A Service Principal is a non-interactive account that Terraform can use to authenticate with Azure. It’s more secure than using your own user credentials.

- **Access Azure Active Directory**

  - Log in to the Azure Portal.
  - Search for and select Azure Active Directory.

- **Register a New Application**

  - Under Azure Active Directory, click App registrations in the sidebar.
  - Click the + New registration button at the top.
  - Fill out the form:
    - **Name**: Enter a descriptive name (e.g., ```TerraformSP```).
    - **Supported Account Types**: Select the default option, Accounts in this organizational directory only (Default Directory).
    - **Redirect URI**: Leave this blank or set it to https://localhost (not needed for Terraform).
  - Click Register.
 
- **Retrieve Application (Client) Details**

  - Once the app is registered, you'll be redirected to its overview page.
  - Note down the following details (you’ll need them for Terraform):
    - Application (client) ID: This is your ```client_id```.
    - Directory (tenant) ID: This is your ```tenant_id```.

- **Create a Client Secret**

  - In the app's overview, go to the Certificates & secrets tab on the sidebar.
  - Under the Client Secrets section, click + New client secret.
  - Fill out the form:
    - **Description**: Enter a name for the secret (e.g., ```TerraformSecret```).
    - **Expires**: Choose an expiration period (e.g., 6 months, 1 year, or 2 years).
  - Click Add.
  - Once created, a secret value will appear. Copy and save this value (you’ll need it as ```client_secret```). You won’t be able to see it again after navigating away.

- **Assign a Role to the Service Principal**

  - Go to Subscriptions in the Azure Portal:
    - Search for and select Subscriptions in the top search bar.
    - Click on the subscription you want Terraform to manage.
  - Click **Access Control (IAM)** in the sidebar.
  - Click + **Add → Add role assignment**.
  - Fill out the form:
    - **Role**: Select a role appropriate for Terraform, such as **Contributor** (provides full access to resources without managing access itself).
    - **Assign Access to**: Select **User, group, or service principal**.
    - **Members**: Click + **Select members**, search for the Service Principal you created (e.g., ```TerraformSP```), and select it.
  - Click Save.

- **Configure Terraform to Use the Service Principal**

  Now that your Service Principal is ready, configure Terraform to use it.

  - **Option 1: Use Hardcoded Values (Not Recommended)**
    - In your Terraform configuration file, update the Azure provider block with the values from the Azure Portal:

    ```
    terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "4.14.0"
        }
      }
    }
    provider "azurerm" {
      features = {}

      client_id       = "APPLICATION_CLIENT_ID"  # Replace with Application ID
      client_secret   = "CLIENT_SECRET"          # Replace with the Client Secret
      subscription_id = "SUBSCRIPTION_ID"        # Replace with your Subscription ID
      tenant_id       = "TENANT_ID"              # Replace with Tenant ID
    }
    ```

  - **Option 2: Use Environment Variables (Recommended)**
    - Export the credentials as environment variables in your terminal. Terraform will automatically use these values:

    - For Linux/MacOS:

      Open a terminal and run the following commands:

      ```
      export ARM_CLIENT_ID="APPLICATION_CLIENT_ID"
      export ARM_CLIENT_SECRET="CLIENT_SECRET"
      export ARM_SUBSCRIPTION_ID="SUBSCRIPTION_ID"
      export ARM_TENANT_ID="TENANT_ID"
      ```

    - For Windows (PowerShell):

      Run these commands in PowerShell:

      ```
      $env:ARM_CLIENT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      $env:ARM_CLIENT_SECRET="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      $env:ARM_SUBSCRIPTION_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      $env:ARM_TENANT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      ```

      Here terraform will automatically use exported variables from shell.

- **Verify Terraform Access**

  - Open your Terraform project directory and run:

    ```
    terraform init
    ```

  - Test the connection to Azure by running:

    ```
    terraform plan
    ```

    Terraform will authenticate using the Service Principal and show a plan of what it will create or modify.

  - Apply the plan if it looks good:

    ```
    terraform apply
    ```

### Best Practices for Using a Service Principal

- **Environment Variables**:

  - Always prefer environment variables over hardcoding credentials in ```.tf``` files.
  - Use a secure secrets manager like Azure Key Vault to manage sensitive data.

- **Least Privilege**

  - Assign the minimum role necessary. For example:
    - Use Reader for read-only access.
    - Use Contributor for full resource management.

- **Rotate Secrets**:
  - Regularly update the client secret to enhance security, especially for long-term projects.
 
<br>

###  Authenticate Using Managed Identity (For Azure Resources)

If Terraform is running from an Azure resource (e.g., an Azure VM, Azure Function, or Azure DevOps), you can use a **Managed Identity** to authenticate.
