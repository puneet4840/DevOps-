# Hashicorp Configuration Language (HCL)

This language is used by terraform to create resoures.

To create any resource we use below syntax:

**Syntax of HCL**:

```
block parameters {

  arguments

}
```

<br>

### Types of Blocks:

Three types of block in terraform:
- Resource block.
- Variable block.
- Output block.

<br

**Resource Block**

Resource Block is used to create any resources in terraform.

```अगर हमको कोई भी resource create करना है, तो हम resource clock का use करेंगे|```

Syntax:

```
resource "resource_name" "local_name" {

  arguments...

}
```

<br>

**Variable Block**

Variable block is used to create variables in terraform.

```Variable block variable create करने के लिए use होता है|```

<br>

**Output Block**

Output block is used to print the ouput variables.
