# Dynamic Provisioning

**Old Method**:

Pehle kya hota tha ki tum mannualy pehle PV create karte the fir PVC create karte aur inko Bind karke apne pod main use kar lete the.

**New method (modern Kubernetes)**:

Automatic provisioning ka matlab hai – tumhe PV manually create nahi karna padta, Kubernetes tumhare liye automatically storage backend se volume create kar deta hai.

Ab modern Kubernetes mein CSI ka zamana hai.

Cloud providers apna plugin dete hain:
- AWS → EBS CSI.
- GCP → PD CSI.
- Azure → Disk CSI

<br>

Old Method:

Maan lo tumhe storage chahiye:

Pehle kya hota tha?
- Tum PV khud likhte ho YAML se
