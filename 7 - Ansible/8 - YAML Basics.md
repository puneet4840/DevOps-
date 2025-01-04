# YAML Basics

YAML = Yet Another Markup Language

YAML is the human-readable data serialization language that is used for writing configuration files and data exchange in different language with different data structures.

**Data Serialization**

Data Serialization refers to the process of converting complex data structures (like objects, lists, dictionaries, etc.) into a textual format that can be easily stored, transmitted, and then reconstructed back into the original data structure.

Imagine you have a complex object, like a description of a person:

```
Name: John Doe
Age: 30
Address:
  Street: 123 Main St
  City: Anytown
  State: CA
Hobbies:
  - Reading
  - Hiking
```

Serialization is the process of turning this information into a string of text that can be saved to a file, sent over the network, or stored in a database. Later, you can "deserialize" this text back into the original object with all its information intact.

<br>

## YAML Syntax

### String

```
name: Puneet Kumar
```

```
name: "Puneet Kumar"
```

```
name: 'Puneet Kumar'
```

### Number

```
number: 10
```

### Boolean

```
is_admin: True
```

```
is_active: FALSE
```

### List

```
fruits:
  - Apple
  - Banana
  - Orange
```

### Dictionary

```
person:
  name: John
  age: 23
  city: New York
```

### Nested Structure

```
person:
  name: John Doe
  address:
    street: 123 Main St
    city: Anytown
    state: CA
  hobbies:
    - Reading
    - Hiking
```
