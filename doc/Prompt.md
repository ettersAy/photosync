Here are **4 ready-to-use tasks** you can copy-paste to your AI developer.
Each one ends with something *you* can test yourself (locally or on prod after deploy).

---

### Task 1 – Admin Shell & Layout

**Task:** US-020: Implement Admin Shell Layout and Routing

**Goal:** Create the base Admin SPA shell (layout + routing) so that all future admin pages share a consistent sidebar, header, and content area.

**Context & Requirements:**

* This is the “base.html.twig equivalent” for the Admin area in a Vue 3 SPA.
* The result should be a working `/admin` route that shows:

  * A left sidebar with links (Dashboard, Users, Job Propositions, Messages, Reviews, Settings).
  * A top header with “Admin Panel” and the admin name placeholder.
  * A main content area that renders a child route (e.g. Dashboard).
* **Frontend:**

  * Create a `layouts/AdminLayout.vue` component with:

    * Sidebar navigation.
    * Top bar (title + admin name + logout button placeholder).
    * `<router-view />` for child pages.
  * Configure Vue Router so `/admin` uses `AdminLayout` as the parent route and renders a simple placeholder page (e.g. “Admin Dashboard” text).
  * Use Vue 3 + Vite conventions.
* **Backend:**

  * Ensure the existing Laravel auth / role system exposes a way to know the user is `Admin` (even if it’s just a stub for now).
  * Protect the `/admin` area with a basic check (e.g. route guard in frontend calling an API endpoint that returns the role).
* **Environment & Safety:**

  * Local dev must point to the **dev backend**:

    * `frontend/.env` → `VITE_API_URL=http://localhost:8000`.
  * Do **not** modify production env vars.
  * Do **not** touch production DB.

**What the user can test:**

* Locally:

  * Run backend: `php artisan serve --host=0.0.0.0 --port=8000`.
  * Run frontend: `npm run dev` from `frontend`.
  * Go to `http://localhost:5173/admin` and verify:

    * Sidebar, header, and main content are visible.
    * Clicking “Dashboard” link keeps you on the same page (for now).
* (Optional) After deployment:

  * Open `<frontend-prod-url>/admin` and see the same layout.

**Important References:**

* **Workflow:** You must follow the workflow defined in `doc/AI_Agent_Guidelines.md`.
* **Functional Specs:** For functional requirements and user roles, refer to `doc/0.PhotoSync_Functional_Spec.md`.
* **Other Docs:** See `doc/1.PhotoSync_introduction.md`, `doc/2.PhotoSync_Roadmap.md`, `doc/3.PhotoSync_Architecture.md`, `doc/5.PhotoSync_Frontend_Deployment_Guid.md`.

---

### Task 2 – Admin Dashboard Overview (Mock Data)

**Task:** US-021: Build Admin Dashboard Overview Screen (Mock Stats)

**Goal:** Provide an Admin Dashboard view under `/admin` that shows an overview of the platform (users, jobs, messages, reviews) using mock data, so the Admin can get a sense of what will be monitored.

**Context & Requirements:**

* This is the **first real admin page** that will live inside `AdminLayout`.
* Data can be mocked for now (no real DB queries yet) but the UI should look close to a final version.
* **Frontend:**

  * Create `views/admin/AdminDashboard.vue`.
  * The page should include:

    * A title (“Overview”) and short description.
    * A grid of stat cards (e.g. Total Users, Active Job Propositions, New Messages (24h), Reported Content).
    * A “Recent Admin Activity” list (e.g. “User suspended”, “Job approved”, “Message deleted”).
    * A “Quick Actions” panel with buttons like:

      * “Review New Job Propositions”
      * “Moderate Recent Messages”
      * “Manage Users”
      * “View Reports & Reviews”
  * Connect this component as the default child of `/admin` in the router.
  * Use mock data inside the component (arrays/objects in `script setup`) for now.
* **Backend:**

  * No backend change required in this task (mock only).
* **Environment & Safety:**

  * Only frontend changes.
  * No DB access or migrations.

**What the user can test:**

* Locally:

  * Open `http://localhost:5173/admin`.
  * You should see:

    * The Admin layout from US-020.
    * Inside it, dashboard cards with numbers and recent activity items.
    * The Quick Actions buttons are visible (they don’t need to be functional yet).
* Visual check:

  * Confirm the design looks clean, readable, and consistent with PhotoSync branding style.

**Important References:**

* **Workflow:** You must follow the workflow defined in `doc/AI_Agent_Guidelines.md`.
* **Functional Specs:** For Admin responsibilities (monitoring users/jobs/messages/reviews), refer to `doc/0.PhotoSync_Functional_Spec.md`.
* **Other Docs:** `doc/1.PhotoSync_introduction.md`, `doc/2.PhotoSync_Roadmap.md`, `doc/3.PhotoSync_Architecture.md`.

---

### Task 3 – Admin User Management List (API + UI)

**Task:** US-022: Implement Admin User Management List (Read-Only)

**Goal:** Allow an Admin to view a paginated list of all users (clients and photographers) with basic data, via a secure API and an Admin UI table.

**Context & Requirements:**

* This is the first Admin feature that reads from the real database.
* The Admin must be able to:

  * See a list of users with columns like: ID, Name, Email, Role, Status (active/suspended), Created At.
* **Backend (Laravel):**

  * Create a new API route, e.g. `GET /api/admin/users`.
  * Protect it so that **only Admin** users can access it (auth + role middleware).
  * Return paginated JSON (e.g. `data`, `meta`, `links`).
  * Use the **dev DB** for local testing (respect `.env`).
* **Frontend (Vue 3):**

  * Add a new Admin child route: `/admin/users`.
  * Create a `views/admin/AdminUsersList.vue` component that:

    * Calls the `GET /api/admin/users` endpoint using the configured `VITE_API_URL`.
    * Renders a table with the fields above.
    * Shows loading and error states.
    * Supports basic pagination (Next/Previous buttons are enough).
  * Add a link to this route in the Admin sidebar (“Users”) and highlight it correctly when active.
* **Environment & Safety:**

  * **Dev DB only**:

    * Get credentials from local `.env` for Laravel.
  * Do **not** run migrations against production DB.
  * For production deploy, ensure Cloud Run env vars point to the **prod DB** (don’t modify them unless needed and documented).

**What the user can test:**

* Locally:

  * Ensure backend is running against **dev DB**.
  * Create a few test users if needed.
  * Open `http://localhost:5173/admin/users`.
  * Confirm:

    * A table of users is visible.
    * Data matches what’s in the dev DB.
    * Pagination works (if there are enough users).
* Optionally:

  * Deploy and check `<frontend-prod-url>/admin/users` using a real Admin account.

**Important References:**

* **Workflow:** You must follow the workflow defined in `doc/AI_Agent_Guidelines.md`.
* **Functional Specs:** Admin user management capabilities are described in `doc/0.PhotoSync_Functional_Spec.md`.
* **Other Docs:** `doc/3.PhotoSync_Architecture.md`, `doc/4.PhotoSync_Backend_Deployment_Guide.md`, `doc/5.PhotoSync_Frontend_Deployment_Guid.md`.

---

### Task 4 – Admin Job Propositions Management (Read-Only + Publish/Unpublish)

**Task:** US-023: Implement Admin Job Propositions Management (List + Publish/Unpublish)

**Goal:** Allow an Admin to list all photoshoot job propositions and toggle their visibility (publish/unpublish) from an Admin UI.

**Context & Requirements:**

* Admin must be able to:

  * See a list of all job propositions (created by clients).
  * See key info: ID, Title, Client, Status (draft/published/unpublished), Created At.
  * Publish/unpublish a job (simple moderation).
* **Backend (Laravel):**

  * Add `GET /api/admin/jobs` to list all job propositions.

    * Paginated, Admin-only (auth + role).
  * Add `PATCH /api/admin/jobs/{id}/publish` to set status to `published`.
  * Add `PATCH /api/admin/jobs/{id}/unpublish` to set status to `unpublished`.
  * Make sure job statuses are stored consistently (enum or string).
* **Frontend (Vue 3):**

  * Add a new route `/admin/jobs` as child of `AdminLayout`.
  * Create `views/admin/AdminJobsList.vue` that:

    * Fetches jobs from `GET /api/admin/jobs`.
    * Displays them in a table with the fields above.
    * Shows action buttons for each row:

      * “Publish” if status is not published.
      * “Unpublish” if status is published.
    * Calls the correct API endpoint when buttons are clicked and updates the UI accordingly.
    * Shows success/error feedback (e.g. toast or inline messages).
  * Ensure the “Job Propositions” link in the Admin sidebar navigates to this page.
* **Environment & Safety:**

  * Test **only on dev DB** locally.
  * Do **not** change or run migrations on prod DB while implementing this.
  * When deploying, verify that:

    * No hard-coded credentials are added.
    * Only environment variables are used on Cloud Run.

**What the user can test:**

* Locally:

  * Create some job propositions as a client (using the existing flow or seeding).
  * Open `http://localhost:5173/admin/jobs`.
  * Verify:

    * Jobs appear in a table.
    * Clicking “Publish” or “Unpublish” changes the status in the UI.
    * Refreshing the page keeps the updated status.
* Optionally:

  * Deploy the changes and repeat the test on `<frontend-prod-url>/admin/jobs` as an Admin.

**Important References:**

* **Workflow:** You must follow the workflow defined in `doc/AI_Agent_Guidelines.md`.
* **Functional Specs:** Job proposition lifecycle and Admin moderation are defined in `doc/0.PhotoSync_Functional_Spec.md`.
* **Other Docs:** `doc/1.PhotoSync_introduction.md`, `doc/2.PhotoSync_Roadmap.md`, `doc/3.PhotoSync_Architecture.md`, `doc/4.PhotoSync_Backend_Deployment_Guide.md`, `doc/5.PhotoSync_Frontend_Deployment_Guid.md`.

---

If you’d like, next step I can generate a **second batch of tasks** specifically for the **Photographer** and **Client** layouts once these Admin tasks are done.
