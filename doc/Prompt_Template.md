

### Prompt Template

---

**Task:** `[US-ID]: [Brief, clear title of the user story]`

**Goal:** `[Describe the primary objective. What is the desired outcome? Be specific.]`

**Context & Requirements:**
*   `[Provide any essential background information.]`
*   `[List specific technical requirements, such as "Use Vue 3" or "The endpoint must be a POST request."]`
*   `[Mention any UI/UX details or specific user interactions.]`

**Important References:**
*   **Workflow:** "You must follow the workflow defined in `doc/AI_Agent_Guidelines.md`."
*   **Functional Specs:** "For functional requirements and user roles, refer to `doc/0.PhotoSync_Functional_Spec.md`."
*   **Other Docs:** `[Point to any other relevant documentation, like architecture diagrams or specific user stories.]`

---

### Example Prompt (for the Admin Login task)

Here is how you could have written the prompt for our last task using this template:

---

**Task:** US-015: Implement Admin Login (First Screen)

**Goal:** Build a secure Admin Login page as the first screen of the app, enabling an admin user to authenticate and access a protected area.

**Context & Requirements:**
*   This is the first step in building the admin-facing part of the application.
*   The login must authenticate only users with an "Admin" role.
*   Use the existing Laravel backend and Vue 3 frontend.
*   **Frontend:**
    *   Create a form with `email` and `password` fields and a "Login" button.
    *   Implement basic validation (required fields).
    *   On successful login, store the auth token and redirect to `/admin/dashboard`.
    *   On failure, display a clear error message.
*   **Backend:**
    *   Create a new API endpoint to handle the login.
    *   Return a JSON response with an auth token on success.
    *   Return a 401 error on failure.

**Important References:**
*   **Workflow:** You must follow the workflow defined in `doc/AI_Agent_Guidelines.md`.
*   **Functional Specs:** The "Admin" role and its capabilities are defined in `doc/0.PhotoSync_Functional_Spec.md`.

---

### Why This Works Well:

1.  **Explicit Instructions:** By explicitly stating, "You must follow the workflow defined in `doc/AI_Agent_Guidelines.md`," you make it a primary directive, which helps me prioritize it.
2.  **Clear Pointers to Documentation:** Naming the specific files (`0.PhotoSync_Functional_Spec.md`, etc.) makes it easy for me to locate and use them for context, reducing the chances of making incorrect assumptions.
3.  **Structured & Specific:** The template breaks down the request into clear, actionable sections, which aligns perfectly with how I process information.

By using a clear and structured prompt like this, you guide me to use the project's own rules and documentation as my source of truth, leading to a much smoother and more accurate development process.