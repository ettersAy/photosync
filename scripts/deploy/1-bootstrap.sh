#!/usr/bin/env bash
set -euo pipefail

# ---- Config ----
PROJECT_ID="photosync-backend-479418"
REGION="us-central1"
REPO_NAME="photosync-repo"

echo "Setting gcloud project..."
gcloud config set project "$PROJECT_ID"

echo "Enabling required APIs..."
gcloud services enable \
  artifactregistry.googleapis.com \
  run.googleapis.com \
  cloudbuild.googleapis.com

echo "Creating Artifact Registry repository (if not exists)..."
gcloud artifacts repositories create "$REPO_NAME" \
  --repository-format=docker \
  --location="$REGION" \
  --description="Photosync Laravel backend images" \
  --quiet || echo "Repository $REPO_NAME may already exist, skipping."

echo "Bootstrap complete."