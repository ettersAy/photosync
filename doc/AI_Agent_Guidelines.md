# AI Agent Guidelines (with Dev vs Prod Env Rules)

Follow these steps **every time** you work on this project.

# 1. Create a New Branch (Always)

Branch naming format:
  US-[User Story ID]-User_Story_Title

Example:
  US-005-Create_API_Endpoint_Contact_Us

# 2. Create `1.Instruction.md`

Location:
  doc/user-stories/2 - 🚧 In Progress/

Steps:
1. Create a folder named exactly like the branch:
     us-[User Story ID]-User_Story_Title
2. Inside it, create `1.Instruction.md` containing:
   - Story title  
   - Story goal  

# 3. Implement the Work

Make your code changes safely inside your branch.

# 4. Document What You Did

In the same folder:

* Describe:
  - Actions taken
  - Commands executed
  - Files modified
  - Any issues or incidents

When finished, move the folder to:
  doc/user-stories/3 - ✅ Done/

# 5. Commit & Push

Commit message format:
  US-005: Implement Contact Us API endpoint

===
# TECHNICAL OVERVIEW (MUST READ)
===

The project has **two separate applications**:

===
## 1. Backend — Laravel 12 (API only)

- Local dev URL:
    http://localhost:8000
- Runs with:
    php artisan serve --host=0.0.0.0 --port=8000
- Deployment:
    Google Cloud Run
- Production URL:
    https://photosync-backend-xxxxxx-uc.a.run.app

### Backend Environment Rules

- `.env` is **for local development only**
- Cloud Run NEVER uses `.env`
- Cloud Run gets all variables from the Cloud Run dashboard
- **Production DB and Dev DB are separated**

===
## 2. Frontend — Vue 3 + Vite

- Local dev URL:
    http://localhost:5173
- Deployment:
    Vercel
- Production URL:
    https://photosync-frontend.vercel.app

### Frontend Environment Rules

- Local env file:
    frontend/.env
- Production env variables:
    Set in Vercel dashboard only
- Key variable:
    VITE_API_URL=<backend-url>

Examples:
  Local:  VITE_API_URL=http://localhost:8000
  Prod:   VITE_API_URL=https://photosync-backend-xxxxxx-uc.a.run.app

===
## 3. Database Strategy (Important)

There are **two completely separate Neon PostgreSQL databases**:

### Dev DB (for local)

- Stored in `.env`
- All local testing writes here
- Safe to modify

### Prod DB (for Cloud Run)

- Passed as environment variables in Cloud Run
- Used ONLY in production
- Must never be touched during local development

===
## 4. Critical Safety Rules for Agents

- ❗ NEVER commit `.env`
- ❗ NEVER use production DB credentials locally
- ❗ NEVER run migrations against the production DB
- ✔️ Local development must use the dev DB only
- ✔️ Production uses Cloud Run env vars only
- ✔️ Always test both:
    - Local (localhost:5173 → localhost:8000)
    - Production (Vercel → Cloud Run)

