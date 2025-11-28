#!/bin/bash

echo "=== Installing Google Cloud SDK ==="

sudo apt update && sudo apt install -y curl apt-transport-https ca-certificates gnupg

curl -fsSL [https://packages.cloud.google.com/apt/doc/apt-key.gpg](https://packages.cloud.google.com/apt/doc/apt-key.gpg) 
| sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] [https://packages.cloud.google.com/apt](https://packages.cloud.google.com/apt) cloud-sdk main" 
| sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt update
sudo apt install -y google-cloud-sdk

echo "=== Fixing SSH Key Permissions ==="
chmod 600 ~/.ssh/google_compute_engine 2>/dev/null
chmod 644 ~/.ssh/google_compute_engine.pub 2>/dev/null

echo "=== Adding SSH Config Entry ==="
cat <<EOF >> ~/.ssh/config

Host google-cloud-shell
ProxyCommand gcloud cloud-shell ssh --ssh-flag='-W localhost:22'
User $(whoami)
IdentityFile ~/.ssh/google_compute_engine
StrictHostKeyChecking no
EOF

echo "=== Done! Now run: gcloud auth login ==="
echo "Then test with: ssh google-cloud-shell"