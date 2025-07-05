# Provisioners in Terraform

Provisioner is functionality of terraform which is used to perform some actions on resources before or after created by terraform.

```Provisioner terraform की एक functionality है जिसके help से आप resources बनने से पहले और resources बनने के बाद उन resources पर कुछ actions perform कर सकते हो| Actions जैसे की आपको कोई script या command किसी resource पर execute करना |```

```Suppose आप terraform के help से azure पर एक virtual machine बना रहे हो और virtual machine बनने के बाद आपको उस virtual machine पर कोई bash या powershell command या script run करनी पड़े तो ये आप provisioner की help से करते हो मतलब provisioner ये ही काम करने के लिए होता है|```

Terraform ka main kaam hota hai infrastructure ko declare karna aur manage karna, lekin kabhi-kabhi tumhe resource create hone ke turant baad koi command chalani hoti hai, jaise:
- Server pe script run karna.
- Software install karna.
- Configuration file copy karna.

Is purpose ke liye provisioners use hote hain.


### Important Note:

```Terraform ये कहता है की provisioner आपको normally use नहीं करना चाइये| अगर आपके पास कोई और option है ये task करने का तो आप वो use करे| Terraform के provisioner को use तब करना है जब आपके पास इसके आलावा कोई और option नहीं होता है|```

इसको इसलिए use नहीं करना चाइये क्युकी:

**Provisioners Terraform State se Bahar Kaam Karte Hain**:
- Terraform state file mein resources track karta hai — jaise resource name, ID, IP, etc. Lekin jo bhi tum provisioner se karte ho (jaise software install karna) woh Terraform ki state mein record nahi hota.
- Problem:
  - Terraform ko pata hi nahi ki provisioner ne kya kiya.
  - Agar woh kaam fail ho jaye ya manually delete ho jaye, Terraform usko fix nahi kar sakta.
 
**Provisioner Failure Se Apply Fail Ho Jaata Hai**:
- Terraform mein provisioner block agar fail ho jaye, to pura terraform apply fail ho jaata hai.

**Provisioners Slow Karte Hain Deployment**:
- Agar tum har server par manually provisioning kar rahe ho, to woh time-consuming hota hai.

```Provisoner के आलावा हमारे पास क्या option रहता है```:
- Use Configuration Management tools like Ansible.

<br>

### Types of Provisioners:

Three types of provisioners:
- Local Provisioner.
- Remote Provisioner.
- File Provisioner.

<br>

**Local Provisioner**:

```जिस local machine पर terraform run हो रहा है, उस machine पर command run करने का काम करता है|```

Example: ```Suppose आपको एक file मैं ये store करना है की terraform ने deployment कब start की और कब ख़तम की| अगर ये logs file मैं store करने हैं तो local provisioner को use करेंगे|```

<br>

**Remote Provisioner**:

```Terraform के help से आप जो भी resources create करते हो| ये remote provisioner उन remote resources जैसे virtual machine, app service jaise resources पर command रन करता है|```

It connects to remote resources like virtiual machine, app service, etc using the SSH command.
