# AI Agent Workflow & Safety Guidelines

Follow this workflow **strictly** for every task to ensure accuracy, safety, and clear communication.

---

### Phase 1: Setup & Planning

**1. Create a New Branch (Always)**
-   **Action:** Create a new Git branch before starting any work.
-   **Format:** `US-[User Story ID]-User_Story_Title`
-   **Example:** `git checkout -b US-005-Create_API_Endpoint_Contact_Us`

**2. Create Initial Documentation**
-   **Action:** Create a folder for the user story in `doc/user-stories/2 - 🚧 In Progress/`.
-   **Folder Name:** `us-[User Story ID]-User_Story_Title`
-   **Action:** Inside the new folder, create `1.Instruction.md`.
-   **Content:**
    -   Story Title
    -   Story Goal

**3. Explore & Verify (❗Crucial Step)**
-   **Goal:** Understand the current state of the codebase before writing any new code. **Do not make assumptions.**
-   **Actions:**
    -   Use `read_file`, `list_files`, and `search_files` to examine relevant parts of the project.
    -   Verify the database schema, existing libraries, helper functions, and coding patterns.
    -   If you are unsure about something, ask the user for clarification.
    -   Present a clear, high-level plan of implementation to the user.

---

### Phase 2: Implementation & Documentation

**4. Implement the Work**
-   **Action:** Make your code changes iteratively.
-   **Communication:** Briefly explain each major step before you take it.

**5. Document Your Actions**
-   **Goal:** Keep a clear log of what you have done.
-   **Action:** As you work, update the `1.Instruction.md` file (or create a new `2.Implementation_Log.md`) with:
    -   **Actions Taken:** A summary of the changes made.
    -   **Commands Executed:** A list of all terminal commands run.
    -   **Files Modified/Created:** A complete list of affected files.
    -   **Issues/Incidents:** Notes on any errors encountered and how they were resolved.

---

### Phase 3: Testing & Confirmation

**6. Create a Test Plan**
-   **Goal:** Provide the user with a clear, repeatable way to verify your work.
-   **Action:** Write a step-by-step test plan. Include:
    -   Any necessary setup (e.g., database seeding commands).
    -   Server start commands.
    -   Browser navigation steps.
    -   What to click, what to input, and the expected outcome.

**7. Request User Verification**
-   **Action:** Present the test plan to the user.
-   **Action:** Explicitly ask the user to execute the plan and confirm whether the implementation was successful.
-   **Rule:** **❗ DO NOT proceed to the next phase until the user confirms the tests have passed.**

---

### Phase 4: Finalization

**8. Commit & Push**
-   **Pre-check:** Once the user gives their approval, run `git status` to review all changes one last time.
-   **Commit:** Commit the changes with a descriptive message.
    -   **Format:** `US-[ID]: [Description of work]`
    -   **Example:** `US-015: Implement Admin Login screen`
-   **Push:** Push your branch to the remote repository.

**9. Final Cleanup**
-   **Action:** Move the user story folder from `.../2 - 🚧 In Progress/` to `.../3 - ✅ Done/`.

---
# TECHNICAL OVERVIEW & ENV RULES
(This section remains the same)
(Content omitted for brevity)
---
