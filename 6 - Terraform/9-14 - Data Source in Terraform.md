# Data Source in Terraform

```Suppose azure cloud मैं एक resource group के अंदर एक virtual network बना हुआ है और आपके पास एक requirement आती है की आपको उसी resource group के अंदर और उसी virtual network को use करके एक virtual machine बनानी है तो ते ये आप डाटा सोर्स की हेल्प से करोगे|```

Data Source is a feature of terraform which helps to retrieve the information of existing created resource on cloud. It gives the details of already created resource on cloud and help you to create new resource with existing resource.

```Data source terraform का एक feature है जो azure cloud पर पहले से बने resources की information terraform को provide करता है फिर terraform उस information को use करके पुराने resources के साथ नए resources create करता हैं|```


A data source in Terraform allows you to fetch and use information about existing resources managed outside your Terraform configuration. This can include resources created manually, by another Terraform module, or by other teams.


### Why use Data Source?

- **First understand, How terraform works:**

```सबसे पहले हम main.tf file मैं resources को define करते हैं और जो resource define किया है वो cloud पर create हो जाता है अगर कोई resource पहले से ही cloud पर बना हुआ है और उसी resource को हम terraform के through create करते हैं तो terraform error देगा और उस resource को create नहीं करेगा|```

- In many cases, you may already have infrastructure resources (e.g., resource groups, virtual networks, storage accounts) that were created outside of Terraform or by another Terraform configuration on your azure cloud.

- Instead of recreating these resources, you can use data sources to reference and reuse them in your current configuration.

```तो पहले से बने हुए resources के साथ अगर कोई नया resource बनाना है जैसे पहले से बने हुए virtual network मैं एक नयी virtual machine attach करनी है तो हम data source का use करके virtual network की configuration को main.tf file मैं लाके virtual machine की configuration मैं use कर लेंगे जिससे पहले से बने हुए virtual network मैं हमारी नयी virtual machine cfreate हो जाएगी |```

