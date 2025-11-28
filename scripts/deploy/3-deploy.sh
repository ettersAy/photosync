#!/bin/bash

set -e

echo ""
echo "    >>>    Start Backend Building...    <<< ";
echo ""

# Set the project
gcloud config set project photosync-backend-479418

# Check if authenticated, if not, skip and let user handle it manually
ACCOUNT=$(gcloud auth list --format="value(account)" 2>/dev/null)
if [ -z "$ACCOUNT" ]; then
    echo "ERROR: No authenticated account found. Please run 'gcloud auth login' first."
    echo "Then run this script again."
    exit 1
fi

echo "Building with account: $ACCOUNT"

gcloud builds submit \
  --tag us-central1-docker.pkg.dev/photosync-backend-479418/photosync-repo/photosync-app

echo ""
echo "    >>>    The Build is ready    <<< ";
echo ""


echo ""
echo "    >>>   Start deploying...   <<< ";
echo ""

# Set the project
gcloud config set project photosync-backend-479418

# Check if authenticated, if not, skip and let user handle it manually
ACCOUNT=$(gcloud auth list --format="value(account)" 2>/dev/null)
if [ -z "$ACCOUNT" ]; then
    echo "ERROR: No authenticated account found. Please run 'gcloud auth login' first."
    echo "Then run this script again."
    exit 1
fi

echo "Deploying with account: $ACCOUNT"

gcloud run deploy photosync-backend \
  --image us-central1-docker.pkg.dev/photosync-backend-479418/photosync-repo/photosync-app \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated
echo ""
echo "    >>>   Backend deployed   <<< ";
echo ""
echo "    >>>   Start Check...   <<< ";
echo ""

URL=$(gcloud run services describe photosync-backend --region us-central1 --format='value(status.url)')
curl -i "$URL/api/messages"

echo ""
echo "    >>>   End   <<< ";
echo ""