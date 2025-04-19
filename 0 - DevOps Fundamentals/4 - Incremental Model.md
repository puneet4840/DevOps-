# Incremental Model

In incremental model software is developed in small parts instead of delivering complete product at once.

The Incremental Model is a method of software development where the product is designed, implemented, and tested incrementally — meaning that it is built in small parts or increments. Rather than delivering the complete system at once, development and delivery are split into builds, each of which adds functionality to the existing software. The core idea is to build the software piece by piece, with each part going through a complete SDLC cycle: requirements, design, development, testing, and deployment.

In this requirement divided into multiple modules. Then eash module goes throught the desing, implementation and testing.

Saal 1980 ka aas-paas hai, aur ek naya idea saamne aata hai—Incremental Model. Tumhara manager kehta hai, “Poora software ek saath mat banao. Chhote-chhote parts banao, aur ek-ek karke client ko do.” Tum pehle login module banaate ho, phir dashboard, phir reports. Client har month kuch na kuch dekh raha hota hai. Feedback jaldi milta hai. Tumhe kaam mazedaar lagne lagta hai. Lekin jab saare modules ko jodte ho, tab bugs nikalte hain—kyunki planning pehle se strong nahi thi.

<br>

<img src="https://drive.google.com/uc?export=view&id=19dUTcdQVkJz7q8SBzzXpXpC0fHo4j_oU" height=350 weight=400>

<br>

### How It Works?

Let’s say we’re building an e-commerce website. The features you want are:
- User Registration/Login
- Product Catalog
- Shopping Cart
- Checkout/Payment
- Order Tracking

In the Incremental Model, you don't build everything in one go. Instead:

- Increment 1: You build and deliver User Registration/Login.
- Increment 2: You build Product Catalog and integrate it with the existing login system.
- Increment 3: You develop the Shopping Cart and connect it to the catalog and user sessions.
- Increment 4: You add Checkout and Payment Gateway.
- Increment 5: Finally, you implement Order Tracking.

At every stage:
- You go through analysis, design, code, and test — just like in full SDLC.
- The output of each increment is a working software module, fully integrated with what has already been built.

<br>

### Testing Strategy in Incremental Model

From a QA/DevOps viewpoint, testing happens continuously, but in layers:
- **Unit Testing**: After each feature/module is built.
- **Integration Testing**: Once new increment is added to the system.
- **System Testing**: To ensure the whole app still functions correctly.
- **Regression Testing**: As older modules can be affected by new changes.
- **User Acceptance Testing (UAT)**: At the end of each increment or major milestone.

<br>

### Advantages (Technically)

- Early delivery of working software.
- Lower risk: easier to identify and fix technical debt early.
- Easier to adapt to changes in requirements.
- Continuous customer feedback loop.
- Smaller codebase at any given moment — better for debugging, reviewing, and testing.
- Scales well with Agile and DevOps pipelines.

<br>

### Disadvantages

- Architecture must be designed from the start to support scalability and extensibility.
- Integration between modules becomes increasingly complex as more increments are added.
- If design is not modular, coupling increases and makes changes risky.

<br>

### What are the issues with the Incremental Model?

- **Design Complexity Grows**:
  - As you keep adding more increments, the codebase becomes complex.
 
- **Requirement Freeze per Increment**:
  - Once an increment starts, its scope is fixed — you can’t change the requirements mid-way for that piece.
 
- **Not Fully Customer-Driven**:
  - Feedback is considered after each increment, not continuously.
  - Customers still don't get daily interaction or control over backlog priorities.
 
- **Testing Overhead**:
  - With every new increment, you must re-test the entire system.
