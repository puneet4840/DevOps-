# Data Source in Terraform

```Suppose azure cloud मैं एक resource group के अंदर एक virtual network बना हुआ है और आपके पास एक requirement आती है की आपको उसी resource group के अंदर और उसी virtual network को use करके एक virtual machine बनानी है तो ते ये आप डाटा सोर्स की हेल्प से करोगे|```

Data Source is a feature of terraform which helps to retrieve the information of existing created resource on cloud. It gives the details of already created resource on cloud and help you to create new resource with existing resource.

```Data source terraform का एक feature है जो azure cloud पर पहले से बने resources की information terraform को provide करता है फिर terraform उस information को use करके पुराने resources के साथ नए resources create करता हैं|```


A data source in Terraform allows you to fetch and use information about existing resources managed outside your Terraform configuration. This can include resources created manually, by another Terraform module, or by other teams.

<br>

### Why use Data Source?

- **First understand, How terraform works:**

```सबसे पहले हम main.tf file मैं resources को define करते हैं और जो resource define किया है वो cloud पर create हो जाता है अगर कोई resource पहले से ही cloud पर बना हुआ है और उसी resource को हम terraform के through create करते हैं तो terraform error देगा और उस resource को create नहीं करेगा|```

- In many cases, you may already have infrastructure resources (e.g., resource groups, virtual networks, storage accounts) that were created outside of Terraform or by another Terraform configuration on your azure cloud.

- Instead of recreating these resources, you can use data sources to reference and reuse them in your current configuration.

```तो पहले से बने हुए resources के साथ अगर कोई नया resource बनाना है जैसे पहले से बने हुए virtual network मैं एक नयी virtual machine attach करनी है तो हम data source का use करके virtual network की configuration को main.tf file मैं लाके virtual machine की configuration मैं use कर लेंगे जिससे पहले से बने हुए virtual network मैं हमारी नयी virtual machine cfreate हो जाएगी |```

<br>

### How Data Sources Work in Terraform?

- **Plan/Apply Phase**:
  - When you run ```terraform plan``` or ```terraform apply```, Terraform processes data source blocks first. It calls the provider’s API (or reads from a file) to fetch the latest values.
    
- **State Integration**:
  - The fetched data is stored in the state (or at least in-memory during the plan phase) and can be referenced by other parts of your configuration using interpolation (e.g., ```${data.aws_ami.ubuntu.id}```).

- **Immutability**:
  - Data sources do not change anything in your environment. They only pull information; any changes in the underlying data are picked up on the next Terraform run.

<br>

###  Syntax of Data Source

```
data "provider_resource" "local_name" {
  # Provider-specific configuration parameters
  key = "value"
  # You can include filters, names, or other identifiers here.
}
```

Explanation:
- ```data```: It is a keyword. Indicates that you are defining a data source.
- ```"provider_resource"```: Specifies the type of data source, which is determined by the provider (e.g., azurerm_resource_group).
- ```"local_name"```: A local identifier used to reference this data source later in the configuration.

<br>

## Examples:

### Example-1: Reusing an Existing Azure Resource Group

**Scenario**: Assume we already have a resource group named "my-existing-rg" in Azure, and we want to create a new Virtual Network inside it.

```main.tf``` file

```
# Lookup the existing resource group
data "azurerm_resource_group" "existing" {
  name = "my-rg"
}

# Create a Virtual Network using the existing resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = data.azurerm_resource_group.existing.location  # Dynamically fetched
  resource_group_name = data.azurerm_resource_group.existing.name      # Dynamically fetched
  address_space       = ["10.0.0.0/16"]
}
```

Explanation:
- **Purpose**: This block creates a new Azure Virtual Network (VNet) in the existing resource group fetched by the data source.
- ```data```: Block
  - ```"azurerm_resource_group"```: Specifies the type of data source. In this case, it’s an Azure resource group.
  - ```"existing"```: A local name for the data source. This is used to reference the fetched data elsewhere in the configuration.
  - ```name = "my-rg"```: Specifies the name of the existing resource group to fetch. This is a required argument for the ```azurerm_resource_group``` data source. It means there is already a resource group created ```my-rg``` for which we are telling here in data block to get data for.
 
