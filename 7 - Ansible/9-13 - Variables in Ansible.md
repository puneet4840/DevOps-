# Variables in Ansible

A Variable is a value that can change.

OR 

A Variable is a data holder.


In Ansible, **variables** are used to store values that can be dynamically referenced and reused throughout playbooks, tasks, templates, and roles.

Variables make your playbooks more flexible, reusable, and easier to manage, especially when dealing with multiple environments or configurations.

<br>

## Why Use Variables in Ansible?

- **Dynamic Configuration**: Adjust configurations based on different environments (e.g., development, staging, production).
- **Reusability**: Write generic playbooks that work with different hosts and scenarios.
- **Maintainability**: Centralize values to make updates easier and reduce duplication.

<br>

## Defining Variables

- **In Playbooks**: Variables are defined in the ```vars``` section of a playbook.

- **In Inventory Files**: Variables can be defined for specific hosts or groups in the inventory.

- **In Variable Files**: Variables can be stored in separate YAML files and included in playbooks.

- **As Command-Line Arguments**: Variables can be passed using the --extra-vars option.

<br>

## Variable Syntax

- Variables are defined in YAML format as key-value pairs.
- They are referenced using double curly braces ```{{ variable_name }}```.

```
my_variable: "Hello, Ansible"
```

<br>

## Types of Variables

- **Scalar Variables**: Hold a single value (string, number, or boolean).
- **List Variables**: Store a list of values.
- **Dictionary Variables**: Store key-value pairs (nested variables).

<br>

## Examples of Variables

### Example 1: Scalar Variables

In YAML files, Variables are defined in vars section
```
vars:
  - var1
  - var2
```

```
---
- name: Using scalar variables
  hosts: all
  vars:
    my_name: "Alice"
    server_port: 8080

  tasks:
    - name: Print variable values
      ansible.builtin.debug:
        msg: "My name is {{ my_name }} and the server port is {{ server_port }}."
```

Explanation:
- ```my_name```: A string variable storing the name "Alice".
- ```server_port```: A number variable storing the port ```8080```.
- The ```debug``` module prints the values of the variables dynamically.

### Example 2: List Variables

```
---
- name: Using list variables
  hosts: all
  vars:
    fruits:
      - apple
      - banana
      - cherry

  tasks:
    - name: Print all fruits
      ansible.builtin.debug:
        msg: "Available fruits are {{ fruits }}."

    - name: Print each fruit
      ansible.builtin.debug:
        msg: "Fruit: {{ item }}"
      loop: "{{ fruits }}"
```

Explanation:
- ```fruits```: A list variable containing multiple items.
- The first task prints the entire list.
- The second task iterates over the list using loop and prints each fruit individually.

### Example 3: Dictionary Variables

```
---
- name: Using dictionary variables
  hosts: all
  vars:
    server_config:
      host: "192.168.1.10"
      port: 8080
      protocol: "https"
  tasks:
    - name: Print server configuration
      ansible.builtin.debug:
        msg: "The server is at {{ server_config.host }}:{{ server_config.port }} using {{ server_config.protocol }}."
```

Explanation:
- ```server_config```: A dictionary variable with keys (```host```, ```port```, ```protocol```) and their values.
- Variables are accessed using dot notation (e.g., ```server_config.host```).


### Example 4: Variables in Inventory

```
[web]
web1 ansible_host=192.168.1.11 ansible_user=ubuntu

[web:vars]
nginx_port=80
```

Explanation:
- ```nginx_port```: A group variable assigned to all hosts in the ```web``` group.
- The variable can be used in tasks targeting the ```web``` group.


### Example 5: Variables in External Files

Variable File (```vars.yml```):

```
app_name: "MyApp"
app_version: "1.0.0"
```

```
---
- name: Using variables from a file
  hosts: all
  vars_files:
    - vars.yml
  tasks:
    - name: Print app details
      ansible.builtin.debug:
        msg: "Deploying {{ app_name }} version {{ app_version }}."
```

Explanation:
- Variables are stored in an external file (```vars.yml```) and included in the playbook using ```vars_files```.
- The playbook references these variables to display the app name and version.

### Example 6: Passing Variables via Command Line

Command:
```
ansible-playbook playbook.yml --extra-vars "env=production app_name=MyApp"
```

Playbook:

```
---
- name: Passing variables from CLI
  hosts: all
  tasks:
    - name: Print environment details
      ansible.builtin.debug:
        msg: "Deploying {{ app_name }} in {{ env }} environment."
```

Explanation:
- The variables ```env``` and ```app_name``` are passed at runtime using ```--extra-vars```.
- They are directly available in the playbook.

<br>

## Variable Precedence in Ansible

Ansible determines the value of a variable based on a hierarchy (highest to lowest priority):

- **Extra Vars** (```--extra-vars```).
- **Task Variables** (e.g., ```vars``` in a task).
- **Block Variables**
- **Play Variables** (```vars``` in a play).
- **Host Variables** (defined in inventory).
- **Group Variables** (defined in inventory).
