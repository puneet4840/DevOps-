# ErrorImagePull

Error: **ErrImagePull**

ya

Error: **ImagePullBackOff**

Yeh dono closely related errors hain — lekin ```ErrImagePull``` pehla stage hota hai, aur ```ImagePullBackOff``` uska retry stage hota hai.

<br>

### “ErrImagePull” kya hota hai?

Jab ````kubelet``` container runtime ko container start karne ko kehta hai, to container runtime, registry se docker image pull karta hai, aga docker image pull karne mein koi error aata hai, chahe image missing ho, wrong tag ho, registry unreachable ho,
ya credentials invalid ho — to kubelet ye status dikhata hai:
```
Error: ErrImagePull
```

Aur agar ye repeatedly fail hoti hai, to Kubernetes retry backoff apply karta hai (2s, 4s, 8s, 16s...) aur state ban jaata hai:
```
ImagePullBackOff
```

Iske liye already **ImagePullBackOff** notes created hain.
