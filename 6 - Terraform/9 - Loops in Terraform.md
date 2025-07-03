# Loops in Terraform

```Terraform मैं कभी-कभी आपको एक ही resource multiple बार create करना होता है, जैसे multiple Virtual machine, storage account, network interface. तो जो resource multiple बार create करना है, तो normally हम main.tf file मैं उसके resource block को उतनी बार copy paste करके लिखे सकते हैं और resource create हो जायेगा लेकिन ये efficient नहीं है|``` 


```तो इसको करने के लिए terraform 2 meta arguments provide करता है count और for_each.```

