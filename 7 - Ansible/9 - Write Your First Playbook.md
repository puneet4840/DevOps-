# Learn How to write Playbooks

## What is a Playbook?

An Ansible playbook is a YAML file that desribes a set of tasks to be executed on managed nodes.

```
OR
```

An Ansible playbook is a YAML file which consists the list of plays.

```Playbook एक YAML file होती है जिसमे list of plays होते हैं मतलब एक playbook मैं plays लिखे होते हैं इसलिए इसको playbook कहते हैं|```

## What is a Play?

A play is a set of instructions that are executed on managed nodes.

<br>

## Structure of Play

A playbook starts from three hyphens (---).

Any play you write in your playbook, just give a hyphen (-) and write a play. It means a play start from a single hyphen (-).

Suppose your task is to create a DB server and a Web Server on a ubuntu virtual machine (managed node). So you have to create two plays in your ansible playbook.

One play for DB Server and Other Play for web server.
