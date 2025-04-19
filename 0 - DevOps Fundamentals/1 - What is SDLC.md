
# SDLC

SDLC (Software Development Life Cycle)

SDLC is the process to develop a software.

SDLC is the step-by-step process to develop a software.

SDLC is the systematic appraoch to develop a software which has multiple phases that helps a company to deliver high quality software.

### Phases of SDLC (Software Development Life Cycle)

This process has multiple phases which helps to deliver a better and high quality product.
- Requirement Collection.
- Feasibility Study.
- Design.
- Testing.
- Deployment.
- Maintenance.

<br>

**1 - Requirement Collection**:

In this phase requirement is collected from the client. It means the details of software is collected from the client like what features client want in its product.

The requirement collection or requirement analysis is the first phase where product analyst or business analyst and sits with the client and gather the funtional requirements, non-functional requirements and business requirements, etc.

e.g., We have a client who wants a Mobile Application for their students:-

Business analyst will gone through a meeting with client and ask the below requirements:

- What the software do (Functional Requirements):
  - A student should be able to log in.
  - A teacher can upload marks.
  - A parent can view their child’s attendance.

- How the software should behave (Non-Functional Requirements):
  - The app should load within 3 seconds.
  - The system should work 24/7 without crashing.
 
- Why the software is being built (Business Requirements):
  - The school wants to reduce paperwork.
  - The company wants to track employee work hours digitally.

Once the requirements gathered, then a team desides whether to take up the project of not.

<br>

**2 - Feasibility Study**

In this phase a team of Product Managers, Finance Team, Architects, HR Team, Business Analysts decides whether to take this project or not. It means ```क्या ये प्रोजेक्ट इनको लेना चाहिए या नहीं```. They talk on three things:
- Whether taking up this project will be beneficial for them.
- Do they have enough resources to work on this project.
- Do they have technology to work on this project.

After discussing on the above points they come to a desicion. Whether to take this project or not. If they have decided to take this project they work on design.

<br>

**3 - Design**

In the Design phase a team of Architects creates the system design from requirements. It means how the software will be structured and implmented.

This phase is divided into two levels of designs:
- High Level Design (HLD).
- Low Level Design (LLD).

**High Level Design**:

High Level Design means desiging the architecture of the application. HLD focuses on the structure of the application.

e.g., Example for a Student Management System:

There will be three components:
- Student Dashboard.
- Admin Dashboard.
- Teacher Dashboard.

They will interact with a central database.

The backend will use Djange and frontend will use Angular.

**Low Level Design**:

Low Level Design focuses on how each and every module will work. 

e.g., Example for a Student Management System:

- The Student class with properties: id, name, grade, dob, attendance_record
- API endpoint: GET /students/{id} returns student details.
- SQL Table: students(id INT PRIMARY KEY, name TEXT, grade TEXT, dob DATE)
- Logic: If attendance drops below 75%, send notification to parent.

e.g., Example of Gmail:

HLD defines that gmail has multiple components like Inbox, Compose, Draft, Spam and etc. This is the high level design.

LL defines that when you compose mail there is ```TO``` to write receiver's mail, ```CC``` to write other users, Subject to give a topic to email and Body to write message to receiver.

<br>

**4 - Coding**

In this phase Developers write the code in choosen programming language to develop the software. Developers use requirements and design to write the code.

<br>

**5 - Testing**

In this phase testers test the software to check the bugs and failures. Perform unit testing (individual components), integration testing (combined modules), and system testing (entire application).

<br>

**6 - Deployment**

In this phase deployment team deploy the software on customer environment.

<br>

**7 - Maintenance**

In this phase if the client faces any issues with the software then dev and qa team work on the issue and resolve those issues.

<br>

### Before SDLC

```शुरुआत मैं जब software development नया नया था तब कोई process नहीं था, developer सीधा code लिखते थे बिना किसी planning, design और testing के तो result ये होता था या तो software delay हो जाता था या फिर fail हो जाता था|```

```तब ये सोचा गया की एक systematic process होना चाइये software को develop करने के लिए जिससे हर step plan किया जा सके|```

```फिर 1970s मैं Winston Royce SDLC के concept को लेके आये, जिसमे software को develop करने के अलग-अलग स्टेप्स बनाये गए जैसे की Requirement gathering -> Desing -> Development -> Testing -> Deployemnt -> Maintenance```

<br>

### Why different SDLC Models Created

```तो सबसे पहले SDLC के steps को define किया मतलब create किया गया, लेकिन फिर सोचा गया इन steps को practically apply कैसे करना है, इसके लिए SDLC models बनाये गए.```

**First Model Created: Waterfall**

```अब ये steps तो बन गए लेकिन इनका implmentation कैसे हो.``` ```इस सवाल का जवाब दिया Winston Royce ने 1970 में जब उसने waterfall model का concept दिया.```

We know that first model that is waterfall model is created. So, why did more SDLC models created?

Because projects are not same like:
- Har project ki requirement alag hoti hai – kabhi client clear hota, kabhi nahi.
- Risk levels alag hote hain – jaise military projects mein zyada risk hota hai.
- Delivery ka pressure hota hai – kuch projects mein jaldi delivery chahiye.
- Feedback loop zaroori hota hai – jaise web/mobile apps mein.

So creating projects with waterfall model will not work efficiently. Matlab sabke liye ek hi tarike ka model kaam nahi karta. har model ek specific problem solve karne ke liye aaya.

<br>

### Types of SDLC Models:

- **Waterfall Model**.
- **V-Model**.
- **Incremental Model**.
- **Prototyping Model**.
- **Spiral Model**.
- **Agile Model**.
- **DevOps**.

<br>

### SDLC Models Flow

Shuruat main jab software development naya-naya tha, tab koi process nahi tha. Developers seedha code likhte the bina kisi planning, design, ya testing ke. Result ye hota tha ki software ya to delay hota ya fail ho jata. Tab socha gaya ki ek systematic process hona chahiye — jisse har step plan kiya ja sake. Is tarah SDLC concept aaya — jisme software develop karne ke liye alag-alag stages banaye gaye jaise requirement gathering, design, development, testing, deployment, aur maintenance.

Lekin har project alag hota hai — isiliye sabke liye ek hi tarike ka model kaam nahi karta. Isi wajah se alag-alag SDLC models banaye gaye — har model ek specific problem solve karne ke liye aaya.

Sabse pehla model **Waterfall** tha, jisme saari phases ek ke baad ek follow hoti thi bina peeche jaaye. Ye simple aur clear tha, lekin agar kisi stage main kuch galti ho gayi, to usse baad main theek karna mushkil hota tha. Phir aaya **V-Model**, jisme har development phase ke saath uska testing phase parallel chalta tha — jisse bugs jaldi pakad main aayein.

Lekin log chahte the ki unhe software jaldi mil jaye, to is problem ko solve karne ke liye **Incremental Model** aaya. Isme software ko chhote-chhote parts main deliver kiya jata tha — har part ek feature hota. Is model ke baad Prototyping model aaya, jisme client ko ek dummy software dikhaya jata tha taaki wo feedback de sake — khas kar tab jab client ko khud clear nahi hota tha ki usse kya chahiye.

Jab speed sabse important ban gayi, to **RAD (Rapid Application Development)** model introduce kiya gaya. Isme fast delivery hoti thi aur ready-made components ka use hota tha. Phir jab large aur complex projects aaye jisme risk high tha, to Spiral Model ne unka solution diya. Isme planning aur risk analysis baar-baar hota tha har round ke baad.

Aur finally, market itna fast ho gaya ki log chahte the software baar-baar, jaldi aur unke feedback ke saath bane. Tab aaya **Agile Model**. Agile ne pura game change kar diya. Isme software chhoti-chhoti sprints main banta hai (jaise 2-4 week ke chunks), har sprint ke baad ek working version milta hai aur client se feedback liya jata hai. Team daily milti hai, discuss karti hai, aur process har baar improve hota hai.

Lekin Agile ke sath ek nayi dikkat saamne aayi — software jaldi ban raha tha lekin usko baar-baar deploy karna, test karna, aur production main le jaana mushkil ho raha tha. Yaha se **DevOps** ka janm hua. DevOps ne Agile ke speed ko support karne ke liye automation laaya — jisme code likhne ke baad testing, deployment, monitoring sab automatically ho sake.

Is tarah Agile ne development side improve ki, aur DevOps ne delivery & operations side streamline ki — dono milke software ko fast, reliable aur efficient banate hain.
