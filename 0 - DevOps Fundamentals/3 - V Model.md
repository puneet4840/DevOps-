# V Model (Validation and Verification Model)

In this V model testing is planned in parallel with each phase. Each phase must be completed before moving to the next phase and it follow sequestial design process same as waterfall model.

It is called V-Model because it forms a V shape as software development phases in left side and testing phases in the right side.

In simple words, for every software development activity, there is directly associated testing activity.

```इस phase मैं हर software development phase के साथ testing activity होती है```

<br>

### Why was V-Model introduced?

```Waterfall Model. Saal tha 1970. Tum ek naye project mein ho, aur tumhare manager bolte hain ki ab hum ek formal process follow karenge. Sabse pehle hum requirements likhenge, fir unka design banayenge, fir code likhenge, fir testing, aur phir deploy karenge. Tumhein laga, "Waah! Kitni planning hai!" Har cheez ek sequence mein ho rahi thi, jaise paani waterfall se girta hai—upar se neeche. Sab kuch document hota tha. Client bhi khush tha, kyunki usse lagta tha ki project professional tarike se chal raha hai.```

```Lekin phir kuch mahine baad client ne kaha, “Humein ek aur feature chahiye.” Tumhara poora structure hil gaya. Tumhein dobara planning se leke deployment tak sab kuch karna pada. Tum realize karte ho ki yeh model stable hai, lekin flexible nahi hai. Software banate waqt agar beech mein koi change aaye, toh yeh model bekaar ho jata hai.```

```Isi frustration ke beech aata hai V-Model. Tum sochte ho, “Agar development ke har step ke saath testing bhi karun, toh issues end mein nahi aayenge.” V-Model ke andar tum pehle requirement lete ho, aur saath hi acceptance test plan banate ho. Design ke saath system test plan. Coding ke saath unit tests. Tumhara code kaafi achha chalne lagta hai. Lekin ek problem ab bhi hai—client agar beech mein kuch badalna chahe, toh tum phir se poora flow mein jaate ho. Time zyada lagta hai, aur phir se wahi rigidness tumhe feel hoti hai.```

<br>

Before V-Model, we mostly used the Waterfall model, which had a major drawback:
- Testing came only after development, which led to late discovery of bugs.

So, the industry needed a model where:
- Testing could be started early (before code is written).
- Defects could be caught as soon as possible

That’s where V-Model came in — as a refined and more test-driven evolution of Waterfall.

<br>

### V-Model Structure (Phase-by-Phase)

<img src="https://drive.google.com/uc?export=view&id=1x74SD6sgJ6_V1DFSoQerEv0eGh8VZ2fs" height=350 weight=350>

<img src="https://drive.google.com/uc?export=view&id=1ccXQObGYrLmV-dgUqB4vHOWs9xet5Sjb" height=200 weight=250>

Let’s go through each phase clearly:

**Requirements Analysis → Acceptance Testing**:
- What Happens: Understand exactly what the customer wants
- Deliverable: Software Requirement Specification (SRS)
- Testing Thought: Plan how to verify these final requirements through Acceptance Testing later.

**System Design → System Testing**
- What Happens: Define how the system will function as a whole. You plan how the entire system will behave — what modules are needed, what features connect where. And again, you're thinking, “How do I test the full system once it's built?”
- Deliverable: High-Level Design (HLD)
- Testing Thought: Plan System Tests that check overall system behavior

**Architecture Design → Integration Testing**
- What Happens: Break system into components/modules and design interactions.
- Deliverable: Software Architecture Documents.
- Testing Thought: Design Integration Tests to ensure modules talk to each other correctly.

**Module Design → Unit Testing**
- What Happens: Design each module's internal logic.
- Deliverable: Low-Level Design (LLD).
- Testing Thought: Prepare Unit Tests for each module individually.

**Coding → Implementation**
- What Happens: Actual development based on module designs.
- Output: Working code.
- Validation Side: Perform all planned tests (unit → integration → system → acceptance).

<br>

### Why V-Model is Valuable

- **Early Testing Focus**: Catch issues before code is written.
- **Clear Documentation**: Strong mapping of test cases to requirements. It means test cases are created at requirement phase.
- **Low Risk**: Since everything is validated step-by-step, fewer surprises late in development.

<br>

### Limitations of the V-Model

- Not flexible for changing requirements. (If client changes their mind mid-way, it’s hard to adjust).
- A lot of planning required before coding even begins.

<br>

### When to Use V-Model

- Requirements are clear and well-documented.
- High risk or regulatory project (banking, medical, etc.).
- Projects that need strong testing coverage.

<br>

### Example of V-Model in Real Life

Imagine building an online banking app.

- Requirements: "User can transfer money".
  - You define Acceptance Tests for transfer success, failure, balance checks.
 
- System Design: Includes login, transfer, history modules.
  - You design System Tests that validate full user journeys.
 
- Architecture Design: Break into API layer, DB, frontend.
  - Plan Integration Tests to ensure DB + API + UI sync well.
 
- Module Design: Design how transfer module handles limits, errors.
  - Prepare Unit Tests for transfer logic.
 
- Code: Developers build it.
  - Run unit → integration → system → acceptance tests accordingly.
 
