# AI Agent Guidelines

Follow these steps **every time** you start a task.

## 1. Create a New Branch

Always create a new branch **before changing any file**.

Branch naming format: `US-[User Story ID]-User_Story_Title`

Example: `US-005-Create_API_Endpoint_Contact_Us`

## 2. Create `1.Instruction.md`

Inside: `doc/user-stories/2 - 🚧 In Progress/`

Do the following:

1. Create a new folder named exactly like the branch: `us-[User Story ID]-User_Story_Title`

2. Inside that folder, create: `1.Instruction.md`

This file must include:

* User story title
* User story goal

## 3. Start Working

Implement the user story and complete the required changes.

## 4. When Finished

Inside the same story folder:

1. Document everything you did:

   * Actions
   * Commands executed
   * Files modified
   * Any issues or incidents encountered

2. Move the story folder from: `doc/user-stories/2 - 🚧 In Progress/` to: `doc/user-stories/3 - ✅ Done/`

## 5. Commit & Push

Write a short, clear commit message describing what was accomplished. Example: `US-005: Implement Contact Us API endpoint`

---

# **Technical Overview (Required Knowledge for Agents)**

This project is composed of **two separate applications**:

---

## **1. Backend — Laravel 12 (API Only)**

* Purpose: serves all API endpoints (`/api/...`)
* Deployment: **Google Cloud Run**
* Prod URL example:
  `https://photosync-backend-xxxxxx-uc.a.run.app`
* DB: **Neon PostgreSQL (prod DB)**
* Backend local dev URL:
  `http://localhost:8000`
* Local DB: **Neon PostgreSQL (dev DB)**
* `.env` is used **only locally**
* Cloud Run uses **environment variables**, not `.env`

Local start command:

```
php artisan serve --host=0.0.0.0 --port=8000
```

---

## **2. Frontend — Vue 3 + Vite**

* Deployment: **Vercel**
* Prod URL example:
  `https://photosync-frontend.vercel.app`
* Local dev URL:
  `http://localhost:5173`

Environment variables:

* **Local**: `frontend/.env`
* **Prod**: Vercel → Project Settings → Environment Variables

Key variable:

```
VITE_API_URL=<backend-url>
```

Examples:

### Local:

```
VITE_API_URL=http://localhost:8000
```

### Prod:

```
VITE_API_URL=https://photosync-backend-xxxxxx-uc.a.run.app
```

---

## **3. Database Strategy**

There are two completely separate Neon DBs:

### Dev DB (used locally)

* All local testing writes here
* Stored in `.env`

### Prod DB (used on Cloud Run)

* Cloud Run receives DB creds via environment variables
* Not affected by dev testing
* Never use `.env` for production

---

## **4. Important Notes for Agents**

* NEVER modify or commit the `.env` file.
* NEVER use production DB credentials in local environment.
* ALWAYS run migrations only against the intended DB (dev or prod).
* For any feature that touches the API, make sure both:

  * Local version works (`localhost:5173` → `localhost:8000`)
  * Production version works (Vercel → Cloud Run)
