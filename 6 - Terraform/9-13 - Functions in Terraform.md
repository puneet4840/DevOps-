# Functions in Terraform

Terraform functions are built-in operations that let you transform, combine, and work with data within your Terraform configurations. They are similar to functions you might have seen in programming languages—they take one or more inputs (arguments) and return a computed result. Using functions makes your code more dynamic, reusable, and easier to manage, especially when your infrastructure configuration needs to adjust based on different inputs or environments (like Azure).

There are pre-built function only. We can not make customized functions.

**Basic Syntax**:

```
function_name(argument1, argument2, ...)
```

<br>

## Type of Functions

### String Function:

  String functions help manipulate text values.

- ```lower()```:

  - Converts a string to lowercase.
  - Use case: Azure storage account names must be lowercase.
   
  Syntax:
  ```
  lower(string)
  ```

  Example:

  ```
  locals {
  storage_name = lower("MyAzureStorage")
  }
  # Output: "myazurestorage"
  ```

<br>

- ```upper()```

  - Converts a string to uppercase.
 
  Syntax:
  ```
  upper(string)
  ```

  Example:

  ```
  locals {
  vm_name = upper("myvm")
  }
  # Output: "MYVM"
  ```

<br>

- ```replace()```

  - Replaces specific characters in a string.
 
  Syntax:
  ```
  replace(string, pattern, replacement)
  ```

  Example:

  ```
  locals {
  clean_name = replace("My-Storage_Account!", "[^a-zA-Z0-9]", "")
  }
  # Output: "MyStorageAccount"
  ```

  So, [^a-zA-Z0-9] matches any single character that is not a letter (uppercase or lowercase) or a digit. This includes spaces, punctuation marks, symbols, and other special characters.

<br>

- ```trimspace()```

  - Removes leading and trailing spaces.
 
  Syntax:
  ```
  trimspace(string)
  ```

  Example:

  ```
  locals {
  clean_input = trimspace("  My Resource Group  ")
  }
  # Output: "My Resource Group"
  ```

<br>

- ```format()```

  -  The format function is used to create a formatted string by substituting values into a format specification. It is similar to the printf function in c programming languages.
 

  Syntax:
  ```
  format(format_string, values...)
  ```

  Placeholder:

  | **Specifier** | **Description**                                                              |
  |---------------|------------------------------------------------------------------------------|
  | %s            | String (converts the argument to a string).                                  |
  | %d            | Integer (converts the argument to a decimal integer).                        |
  | %f            | Floating-point number (converts the argument to a floating-point number).    |
  | %v            | Default format (converts the argument to its default string representation). |
  | %t            | Boolean (converts the argument to true or false).                            |
  | %%            | Literal percent sign (%).                                                    |

  Example-1:

  ```
  locals {
  vm_name = format("%s-%s", "web", "01")
  }
  # Output: "web-01"
  ```

  Example-2:

  ```
  locals {
  value = format("Hello, %s!", "World")
  }
  # Output: Hello, World!
  ```

<br>

### Numeric Functions

Numeric functions help perform mathematical calculations.

- ```min()```

  - Returns the smallest number.

  Syntax:
  ```
  min(number1, number2, ...)
  ```

  Example:

  ```
  locals {
  smallest_value = min(10, 20, 5, 30)
  }
  # Output: 5
  ```

<br>

- ```max()```

  - Returns the largest number.
 
  Syntax:
  ```
  max(number1, number2, ...)
  ```

  Example:

  ```
  locals {
  largest_value = max(10, 20, 5, 30)
  }
  # Output: 30
  ```

<br>

- ```abs()```

  - Returns the absolute value.
 
  Syntax:
  ```
  abs(number)
  ```

  Example:

  ```
  locals {
  absolute_number = abs(-15)
  }
  # Output: 15
  ```

<br>

### Collection (List & Map) Functions

These functions help work with lists and maps.

- ```length()```

  - Returns the number of elements in a list or map.
 
  Syntax:
  ```
  length(list_or_map)
  ```

  Example:

  ```
  locals {
  resource_groups = ["dev-rg", "prod-rg", "test-rg"]
  count_of_rgs    = length(local.resource_groups)
  }
  # Output: 3
  ```

<br>

- ```merge()```

  - Combines multiple maps.

  Syntax:
  ```
  merge(map1, map2, ...)
  ```

  Example:

  ```
  locals {
  default_tags = { "ManagedBy" = "Terraform", "Environment" = "Dev" }
  extra_tags   = { "Project" = "Azure Deployment" }
  final_tags   = merge(local.default_tags, local.extra_tags)
  }
  # Output: { "ManagedBy" = "Terraform", "Environment" = "Dev", "Project" = "Azure Deployment" }
  ```

<br>

- ```concat()```

  - Combines multiple lists.
 
  Syntax:
  ```
  concat(list1, list2, ...)
  ```

  Example:

  ```
  locals {
  list1 = ["eastus", "westus"]
  list2 = ["centralus", "southindia"]
  regions = concat(local.list1, local.list2)
  }
  # Output: ["eastus", "westus", "centralus", "southindia"]
  ```

<br>

- ```lookup()```

  - Retrieves a value from a map using a key.
 
  Syntax:
  ```
  lookup(map, key, default_value)
  ```

  Example:

  ```
  locals {
  vm_sizes = {
    dev  = "Standard_B1s"
    prod = "Standard_D2s_v3"
  }
  selected_size = lookup(local.vm_sizes, "prod", "Standard_B1s")
  }
  # Output: "Standard_D2s_v3"
  ```

<br>
<br>

## Working Example with Terraform Functions

**Example 1: Creating a Valid Azure Storage Account Name**

Azure storage account names must be all lowercase and only contain numbers and letters. You can use functions to sanitize a name:

```
variable "base_storage_name" {
  description = "Base name for storage account"
  type        = string
  default     = "MyStorageAccount"
}

locals {
  sanitized_storage_name = lower(replace(var.base_storage_name, "[^a-z0-9]", ""))
}

resource "azurerm_storage_account" "storage" {
  name                     = local.sanitized_storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

