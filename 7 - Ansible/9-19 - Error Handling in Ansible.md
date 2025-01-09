# Error Handling in Ansible

Before understand the error handling, we need to know about what is the task execution flow on managed node. It means how does ansible executes multiple tasks on multiple managed node. 

## Task Execution flow on Managed Nodes

```Suppose आपके पास 3 managed nodes हैं और आपको हर एक node पर 3 tasks execute करने हैं तो Ansible पहले पर सभी tasks execute करेगा फिर दूसरे node पर सभी tasks execute करेगा फिर तीसरे Node पर सभी tasks execute करेगा|```

- Ansible will wait for all hosts to complete a task before moving to the next task.

## What Happens if a Task Fails?

- **Default Behavior**:
  - If a task fails on any host, Ansible stops executing subsequent tasks for that host. This is called "**host-level failure**".
  - Ansible will continue executing the remaining tasks on other hosts.

- **Impact Across Hosts**:
  - A task failure on ```managed node 1``` does not affect the execution of the same or subsequent tasks on ```managed nodes 2``` and ```3```.

```अगर managed node पर एक भी task fail हो जाता है तो ansibel बाकी के tasks उस node पर execute नहीं करेगा और उस node को ignore कर देगा ये ansible का default behavior होता है|```


<br>

## Error-Handling Mechanisms in Ansible

- ```ignore_errors```

  Use ```ignore_errors``` to tell Ansible to continue running tasks even if one fails. By default, Ansible stops executes further tasks on managed node if any of the task is failed. But this ```ignore_errors``` will allow ansible to execute further tasks if any tasks failed.

  Example:

  ```
  - name: Ignore errors example
    hosts: all
    tasks:
      - name: Task 1
        ansible.builtin.command:
          cmd: invalid_command
        ignore_errors: yes

      - name: Task 2
        ansible.builtin.command:
          cmd: echo "This will run even if Task 1 fails"
  ```

  How It Works:
  - If Task 1 fails, Ansible logs the failure but does not stop execution. Task 2 will still run.
