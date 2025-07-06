# Modules in Terraform

```Terraform module एक folder होता है जिसमे terraform files होती हैं जैसे main.tf, variables.tf और output.tf| फिर इन terraform की files को अलग main.tf file मैं call करते हैं module block के through जिससे ये files main.tf file मैं use हो जाती हैं और हमको बार बार same code नहीं लिखना पढता|```

```इसको ऐसे समझिये```:

```जैसे किसी भी programming language मैं हम function create करते हैं और उस function को call करते हैं जब function का logic हमको चाइये होता है| वैसे ही ये module होता है इसमें हम वह code लिखते हैं जो हमको बार बार terraform की main.tf file मैं लिखना होता है| Terraform की main.tf file मैं एक ही code बार बार न लिखेके हम एक module बना लेते हैं और उस module को अलग main.tf file मैं call कर लेते हैं और वो code जो module मैं लिखा था वो अब अलग main.tf file मैं use हो जायेगा| बस यही काम मॉडल का होता है|```

