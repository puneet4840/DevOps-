# Spiral Model

The Spiral Model is a cycle-based development process where you build software step-by-step — but at each step, you first analyze risks, solve the complex parts, and only then do the coding and testing.
It’s best for complex, risky systems that need careful planning and review.

Spiral Model ek risk-driven SDLC model hai jisme development multiple cycles (spirals) ke through hota hai. Har cycle main aap ek chhota set of features plan karte ho, uska risk evaluate karte ho, usko develop karte ho, test karte ho, aur fir agle spiral main jaate ho.

Iska main focus hai:**“Risk ko pahle samjho, fir develop karo.”**

<br>

<img src="https://drive.google.com/uc?export=view&id=1cHaUKie1sq_E3nvO3_wnvPcV0DFIvLE1" height=250 weight=250>

<br>

### Technical Thought Behind Spiral Model

Problem kya thi pehle ke models mein?

- Waterfall main ek hi baar sab kuch plan karna padta tha, agar requirement galat ho gayi to poora system fail.
- Incremental mein risk analysis ka system nahi tha.
- Prototyping model mein full architecture plan nahi hota tha, code messy ho jata tha.

To isliye Barry Boehm ne 1986 mein Spiral Model banaya jo planning, prototyping, development, testing, aur feedback sabko logically combine karta hai.

<br>

### How Does the Spiral Model Work?

The entire development is structured as a spiral of cycles (phases) — each loop of the spiral represents a phase of the software process.

Each loop/iteration has four key phases:

- **Planning**:
  - Har iteration ke start mein yeh decide hota hai ki kya banana hai.
  - Technical requirements likhe jaate hain: e.g., “user authentication module” ya “encryption system”.
  - Yeh phase similar hai requirement gathering se, lekin yeh har cycle mein hota hai.
 
- **Risk analysis**:
  - Ab aap check karte ho ki naye feature mein kya technical ya business risks hain.
  - Agar koi technology nayi hai (e.g., real-time messaging system), to uska prototype banake test karte ho.
  - Agar risk zyada hua to agla spiral plan kiya ja sakta hai.
  - Yeh Spiral ka core hai — kisi bhi naye decision pe development se pehle proof-of-concept banta hai.
    
- **Design + development + Testing**:
  - Ab aap plan ke hisaab se coding karte ho.
  - Unit testing, integration testing isi phase mein hoti hai.
  - Yeh phase traditional SDLC ki tarah hi hota hai.
  - Lekin ab tak risk kam ho chuka hota hai, isliye development safer hoti hai.
    
- **Customer Evaluation & Planning Next Spiral**:
  - Jo features banaye uska demo diya jata hai.
  - Client feedback liya jata hai.
  - Fir agla spiral ke liye naye features aur planning shuru hoti hai.

Har spiral cycle ka result ek increment hota hai — aur har cycle ke baad software thoda aur mature ho jaata hai. Jab tak product final nahi hota, spiral chalta rehta hai — aur har spiral se risk aur uncertainty reduce hoti jaati hai.
