# Conditions in Ansible

In **Ansible**, conditions allow you to control when a task is executed. You can use conditional statements to specify that a task should run only if certain criteria are met.

In **Ansible**, conditions let you control whether a task should run or not. Instead of blindly running every task in a playbook, you can use conditions to make sure tasks are executed only when certain requirements are met. This makes your automation smarter and more efficient.

## Why Use Conditions?

- **Customization**: Execute tasks only for specific scenarios, like certain hosts, variables, or states.
- **Efficiency**: Avoid running unnecessary tasks, saving time and resources.
- You only want to install a specific software if the operating system is Ubuntu.

## How Conditions Work in Ansible

In Ansible, conditions are written using the ```when``` keyword. A task with a ```when``` clause will run only if the condition is true.

**Basic Syntax**:

```
when: <condition>
```

