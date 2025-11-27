#!
URL=$(gcloud run services describe photosync-backend --region us-central1 --format='value(status.url)')
curl -i "$URL/api/messages"