# File and Directory Structure in Terraform

When you write terraform code, you need to organize your files properly so that Terraform can read and execute them easily. So that we divide the terraform scrips in multiple files.

A directory structure in Terraform is the way we organize files and folders in a project. It helps manage different parts of the infrastructure efficiently.

```अब तक हम simple एक main.tf file मैं ही resources, variables और बाकी terraform की configuration को define कर रहे थे लेकिन अब हम इसी configuration को उनकी अलग-अलग files मैं define करेंगे|```

```ऐसा हम इसलिए कर रहे हैं क्युकी जब बहुत सारे resources को एक ही file मैं रखने से वो एक messy file बन जाती है और कुछ समझ नहीं आता या फिर कोई team member उस infrastructure पे work करेगा और terraform की scripts देखेगा तो उसको चीज़े समझ नहीं आएँगी इसलिए resources को उनकी अलग-अलग files मैं रखेंगे| ऐसा करने से terraform की कितनी भी बड़ी scripts को हम easily समझ सकते है|```

### Why Do We Need a Directory Structure?

Imagine you are working on a large project where you need to manage:
- Virtual Machines.
- Databases.
- Networks.
- Storage.

If you dump all the files in a single folder, it becomes chaotic. You will not know:
- What file does what.
- Which configuration belongs to which environment (dev,prod).
- How to reuse parts of infrastructure.

By using a structured directory and file organization, you can:
- Easily find specific configuration.
- Reuse modules (instead of writing same code again).
- Seperate production and development environments.
- Collabrate with teams easily.

