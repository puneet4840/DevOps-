# Ingress in Kubernetes

Ingress is a resource in kubernetes which is used to manage external access to service within a kubernetes cluster. 

```Ingress kubernetes का एक resource है जो external traffic को kubernetes की services तक पहुचता है मतलब application को outside world के लिए expose करता है मतलब users ingress के through kubernetes पर deployed application को internet के through access कर पाएंगे|```

In a Kubernetes cluster, applications often need to be accessed from outside the cluster, such as a website that users access via the internet. Ingress is a Kubernetes resource designed to expose such services to external clients, typically via HTTP or HTTPS.

### Why do we need Ingress?

```हमको पता है की जब appllication को kubernetes cluster पर deploy करते है तो उस application को access करने के लिए हम service बनाते हैं खासकर application को internet कर access करना होता है तो Load Balancer type की service बनाते है| तो ये Load Balancer type की service cloud पर एक Load Balancer create कर देती है जिससे Load Balancer पर request भेजकर application को access करते हैं| जब यहाँ तक सब चीज़ ठीक चल रही थी तो ये Ingree नाम की चीज़ क्यों आयी|```

```क्युकी kubernetes मैं service की कुछ disadvantages होती हैं जैसे की: ```

- ```Service को सिर्फ हम cloud clusters पर ही use कर सकते हैं मतलब cloud मैं जब हम cluster बनाते है जैसे AKS, EKS, GKE इन clusters पर ही Load Balancer type सर्विस कर use होता है क्युकी जब service Load Balancer type की होती है तो service को Load Balancer cloud ही provide करता है| इसका मतलब है की Load Balancer type की service सिर्फ cloud dependent होती है जो एक disadvantage है|```

- ```अगर Kubernetes Cluster मैं हमने एक web application deploy की, तो उस web application को internet पर access करने के लिए load balancer type की service बनानी पड़ेगी जिससे एक load balancer web application के लिए cloud पर create हो जायेगा| Suppose अगर हमारे पास ऐसी 10 web applications है और वो हम kubernetes पर deploy कर रहे हैं तो उन सभी वेब एप्लीकेशन को इंटरनेट पर एक्सेस करने के लिए अलग-अलग load balancers क्रिएट करने होंगे मतलब 10 web applications के लिए 10 load balancers create होंगे जिससे होगा ये की इतने सारे load balancers की cost हमको pay करनी पड़ेगी और ऐसा scenario efficient नहीं है तो हर application को internet पर expose करने के लिए load balancer का use न करके हम Ingress resource का use करते हैं|```.
