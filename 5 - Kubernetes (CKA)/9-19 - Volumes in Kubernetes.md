# Volumes in Kubernetes

### What is Volume?

Volume is the directory with the data in it.

```Volume एक directory है जिसके अंदर data stored है|```

```सूपपोसे आपके लैपटॉप मैं एक फोल्डर बना हुआ है जिसमे कुछ फाइल्स है, तो फोल्डर एक वॉल्यूम होगा|```


<br>

### Why do we need volumes in kubernetes?

```सबसे पहले समझो कि Volumes की ज़रूरत ही क्यों पड़ती है?```

```जब तुम Kubernetes में कोई Pod रन करते हो, उसमें containers चलते हैं| Containers के अंदर जो file system होता है, वो temporary होता है| इसका मतलब है की जैसे ही pod या container terminate होता है या restart होता है तो उसके अंदर का data delete हो जाता है|```

For example:
- ```तुम एक container में कोई फाइल /data/test.txt create करते हो।```
- ```Container crash हुआ → फाइल गई।```
- ```Container recreate हुआ → खाली filesystem मिली।```

```इसका मतलब है जब भी container या pod restart होते हैं तो उसके अंदर का data delete हो जाता है| Production workloads में ऐसा कभी acceptable नहीं है।```

```तो volume की help से हम container के data को container के outside store करते हैं जिससे container का data delete होने पर भी container का data available रहता है|```
