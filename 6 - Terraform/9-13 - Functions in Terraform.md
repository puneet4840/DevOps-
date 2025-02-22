# Functions in Terraform

Terraform functions are built-in operations that let you transform, combine, and work with data within your Terraform configurations. They are similar to functions you might have seen in programming languages—they take one or more inputs (arguments) and return a computed result. Using functions makes your code more dynamic, reusable, and easier to manage, especially when your infrastructure configuration needs to adjust based on different inputs or environments (like Azure).

There are pre-built function only. We can not make customized functions.

**Basic Syntax**:

```
function_name(argument1, argument2, ...)
```

<br>

## Type of Functions

- ### String Function:

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

  
