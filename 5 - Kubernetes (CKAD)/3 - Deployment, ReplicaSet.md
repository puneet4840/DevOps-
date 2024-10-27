### What is Deployment?

Deployment is the process in kubernetes which is responsible for controlling the behavior of a pod.

```OR```

Deployment is the process that is used to manage your pods. Because deployment file has the specification related to the pod.

```Deployment actually kubernetes cluster को Auto - Healing, Auto - Scaling जैसे features provide करता है क्युकी एक deployment YAML file मैं Pod के बारे मैं Auto - Healing, Auto - Scaling, कोनसी container image use करनी है, कोनसे port पर container run करना है. ये सारी information deployment YAML file मैं लिखी होती है.```

```जैसे हम चाहते हैं की Node मैं pod के 2 replica होने चाइये. तो इस specification को हम deployment.yaml file मैं mention कर देंगे फिर replica-set 2 pods बना देगा.```

A **Deployment** in Kubernetes is a way to define the desired state of an application. It manages how your application is run, updated, and scaled, automating the creation and management of application instances.

<br>

**Note**: The standard rule is we only create the deployment then pod is created after the deployment automatically. We don't need to create a pod itself using yaml file. We only create deployment.

<br>

### Difference between Container, Pod and Deployment.

- **Container**: ```हम containers बनाते हैं तो command लिखकर बनाते हैं जैसे "docker run -itd -p 3000:3000 image_name .", जो की docker tool का usr करके create हैं. Container सिर्फ एक runtime environment है.```

- **Pods**: ```जब kubernetes market मैं आया तो kubernetes ने decide  किया की हम कंटेनर बनाने के लिए एंटरप्राइज मॉडल को उसे करें इसका मतलब है की कंटेनर बनाने के लिए हम कमांड का उसे न करके एक फाइल के अंदर वही सब लिख लेते हैं जो कंटेनर बनाने के लिए कमांड्स लिखते हैं तो पॉड्स एक रनिंग स्पेसिफिकेशन होता है ```
