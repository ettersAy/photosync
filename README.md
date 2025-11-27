
# Remote Development on Google Cloud Shell via VS Code (Linux Mint)

This guide explains how to develop the `photosync` Laravel backend stored inside Google Cloud Shell using VS Code Remote-SSH on a Linux Mint machine.

## Requirements
- Linux Mint
- VS Code with **Remote - SSH** extension
- Google Cloud account
- Cloud Shell activated at least once

---

## 1. Install Google Cloud SDK (system-wide)

```bash
sudo apt update && sudo apt install -y curl apt-transport-https ca-certificates gnupg
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
| sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt update
sudo apt install -y google-cloud-sdk
```

---

## 2. Authenticate and set project

```bash
gcloud auth login
gcloud config set project photosync-backend-479418
```

---

## 3. Fix SSH key permissions

```bash
chmod 600 ~/.ssh/google_compute_engine
chmod 644 ~/.ssh/google_compute_engine.pub
```

---

## 4. Add SSH config for Cloud Shell (dynamic, stable)

Update `~/.ssh/config` :

```
Host google-cloud-shell
  ProxyCommand gcloud cloud-shell ssh --ssh-flag='-W localhost:22'
  User YOUR_GOOGLE_USERNAME
  IdentityFile ~/.ssh/google_compute_engine
  StrictHostKeyChecking no
```

Replace `YOUR_GOOGLE_USERNAME` with your actual Cloud Shell username.

---

## 5. Test SSH

`$ ssh google-cloud-shell`

If you see `Welcome to Cloud Shell!` you’re good.

---

## 6. VS Code

1. Install **Remote - SSH**
2. `Ctrl + Shift + P` → **Remote-SSH: Connect to Host...**
3. Select `google-cloud-shell`
4. Open the folder:
   `/home/<username>/photosync`

---

## Done 🎉

Your Cloud Shell Laravel project now behaves like a local project inside VS Code.