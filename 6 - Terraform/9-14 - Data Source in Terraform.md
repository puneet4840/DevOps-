# Data Source in Terraform

```Suppose azure cloud मैं एक resource group के अंदर एक virtual network बना हुआ है और आपके पास एक requirement आती है की आपको उसी resource group के अंदर और उसी virtual network को use करके एक virtual machine बनानी है तो ते ये आप डाटा सोर्स की हेल्प से करोगे|```

Data Source is a feature of terraform which helps to retrieve the existing information of created resource on cloud. It gives the details of already created resource on cloud and help you to create new resource with existing resource.

```Data source terraform का एक feature है जो azure cloud पर पहले से बने resources की information terraform को provide करता है फिर terraform उस information को use करके पुराने resources के साथ नए resources create करता हैं|```


A data source in Terraform allows you to fetch and use information about existing resources managed outside your Terraform configuration. This can include resources created manually, by another Terraform module, or by other teams.

It is a read-only block that retrieves information from an external system (like a cloud provider API or a local file). Unlike a resource block that creates or modifies infrastructure, a data source only reads and returns existing information.
