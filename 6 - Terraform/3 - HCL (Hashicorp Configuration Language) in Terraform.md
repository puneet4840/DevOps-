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

```अगर हमको कोई भी resource create करना है, तो हम resource block का use करेंगे|```

Syntax:

```
resource "resource_name" "local_name" {

  arguments...

}
```

<br>

**Variable Block**

```हम variable block का use resource को value provide करने के लिए use करते हैं| जैसे अगर हमको azure मैं resource group के लिए नाम देना है की किस नाम से create होगा| अगर हम terraform script मैं directly value hardcode कर देंगे और हमको value change करनी है तो हमको बार बार मैं script मैं value edit करनी पड़ेगी लेकिन अगर variable block use करे तो value hardcode करने की जरुरत नहीं है directly variable group मैं value change करदो|```

<br>

**Output Block**

```Output block resource की information को print करने के लिए use होता है, जैसे हमने azure मैं एक resource group बनाया. अब हम चाहते हैं की उस resource group का नाम print करे तो उसके लिए हम एक output block बना देंगे और resource group के नाम को print करा देंगे|```

