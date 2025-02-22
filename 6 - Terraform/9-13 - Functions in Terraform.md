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

  Example:

  ```
  locals {
  vm_name = format("%s-%s", "web", "01")
  }
  # Output: "web-01"
  ```
