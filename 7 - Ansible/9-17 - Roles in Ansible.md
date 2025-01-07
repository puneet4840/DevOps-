# Roles in Ansible

Ansible **roles** are a way to organize your playbook into reusable and modular components. 

Roles break your playbook into multiple files.

```Suppose हमको एक server पर ansible के through बहुत सारे packages install करने हैं और हमने एक playbook बना ली अब उस playbook के अंदर हमने suppose 50 tasks लिख दिए अथवा और भी चीज़े|```

```जैसे handlers, variables, etc. अगर हम इस playbook को देखे तो ये playbook बहुत lengthy हो जाएगी और playbook मैं इतनी सारी चीज़े होने की वजह से हमको playbook को समझने मैं भी problem होगी|```

```तो यहाँ concept आता है ansible roles का, ansible roles क्या करते हैं की एक playbook को अलग-अलग folders के अंदर YAML files मैं define कर देते हैं जैसे Hosts के लिए अलग YAML file बनाई और उसमे hosts लिखे दिए, Tasks के लिए अलग YAML file बनाकर उसमे tasks लिखे दिए, ऐसे ही सभी अलग-अलग components को अलग-अलग YAML files मैं define कर देते हैं मतलब playbook का एक अलग structure create करना इसी को ही roles कहते हैं|```
