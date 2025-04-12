
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
