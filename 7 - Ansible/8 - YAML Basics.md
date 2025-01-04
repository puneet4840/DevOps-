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
