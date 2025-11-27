Below is a clean, structured, professional **`Main_Documentation.md`** designed specifically for **AI Agents working on your PhotoSync application**.
It explains architecture, workflow, rules, and how they should update the doc over time.

You can copy/paste this file directly into your repository root as:

```
Main_Documentation.md
```

---

# 📘 **PhotoSync – Main Documentation for AI Agents**

### **Version:** 1.0

### **Purpose:**

This document defines the architecture, conventions, workflow, and rules for **AI Agents contributing to the PhotoSync codebase**.
Every AI Agent must read and follow this document before making any changes.

---

# 🚀 **1. Project Overview**

**PhotoSync** is a web platform for photoshoot booking and client communication.

### **Tech Stack**

| Layer    | Technology      | Hosting          |
| -------- | --------------- | ---------------- |
| Frontend | Vue.js 3 (Vite) | Vercel           |
| Backend  | Laravel 12      | Google Cloud Run |
| Database | PostgreSQL      | Neon.tech        |

---

# 🏛️ **2. System Architecture**

```
Vercel (Vue.js frontend SPA)
       ↓ API requests (HTTPS)
Google Cloud Run (Laravel backend)
       ↓ SQL connection (SSL required)
Neon PostgreSQL (Direct + Pooled endpoints)
```

### **Important Neon Rules**

* **`pooled`** endpoint → used by **runtime application**
* **`direct`** endpoint → used by **migrations only**
  (Because Neon pooled does not support transactional DDL)

---

# 🗂️ **3. Folder Structure (High-Level)**

```
photosync/
│
├── app/
│   ├── Http/
│   ├── Models/
│   └── …
│
├── database/
│   ├── migrations/
│   └── seeders/
│
├── frontend/ (Vue.js app in later phase)
│
├── Main_Documentation.md   ← YOU ARE HERE
└── README.md
```

---

# 🧩 **4. Responsibilities of AI Agents**

AI Agents working in this repository **must follow these rules**:

### **4.1 Before Making Changes**

* Read this documentation entirely.
* Validate understanding of the task.
* Locate correct code section before modifying anything.
* Ensure no breaking changes are introduced.

### **4.2 When Making Changes**

* Keep code clean, consistent, and documented.
* Follow Laravel & Vue best practices.
* Never hardcode secrets (use env variables only).
* Maintain separation of concerns (backend logic vs. frontend UI).

### **4.3 After Making Changes**

Every AI Agent **must update this file** (Main_Documentation.md) using:

### ✅ Additions required after each change:

* **What was added / changed**
* **Date of change**
* **Agent identifier**
* **Location of updated files**
* **Impact on API / frontend / database**

Add updates in the section:

```
# 📝 Change Log (for AI Agents)
```

(Section provided below.)

### **4.4 Required formatting for change log entry**

Each entry must follow this format:

```
## [YYYY-MM-DD] — Agent: <name or ID>

### Summary
<short summary of the feature/fix>

### Files Modified
- path/to/file1
- path/to/file2

### Technical Notes
<details needed for future agents>

### API Impact
<added/updated endpoints or N/A>

---
```

---

# 🔧 **5. Development Standards**

### **5.1 Backend (Laravel 12)**

* Use PSR-12 style.
* Controllers should remain thin.
* Use Eloquent models & validation rules.
* All DB operations must use the correct connection:

  * `pgsql` → app runtime
  * `pgsql_direct` → migrations

### **5.2 Frontend (Vue.js + Vite)**

* Use single-file components (`.vue`).
* API calls through Fetch or Axios.
* Environment variables:

  * `VITE_API_URL` → backend public URL

### **5.3 API Format**

All API responses must follow this structure:

```
{
  "ok": true/false,
  "data": ...,
  "message": "...",
  "errors": {...}
}
```

### **5.4 Security**

* No admin endpoints should be public.
* CORS must allow Vercel + localhost only.
* HTTPS required for all connections.
* Follow Neon SSL requirements.

---

# 🧪 **6. Testing Rules**

AI Agents must test:

* API endpoints (`POST`, `GET`) via local dev or Cloud Run staging
* Migrations using the **direct** endpoint
* Frontend behavior after backend updates
* That the application builds successfully on:

  * Vercel (frontend)
  * Cloud Run (backend)

---

# 🚀 **7. Deployment Workflow**

### **Frontend (Vercel)**

Commit to `main` → Vercel auto-deploy
Frontend uses environment variable:

```
VITE_API_URL=https://<cloud-run-url>
```

### **Backend (Cloud Run)**

Changes merged to `main` trigger:

* Container build via Cloud Build
* Deployment to Cloud Run

Environment variables in Cloud Run must include DB credentials.

---

# 📝 **8. Change Log (for AI Agents)**

> Every AI Agent must append updates below in chronological order.

---

## No changes logged yet

*(The first AI Agent to modify the codebase should create the first entry.)*

---