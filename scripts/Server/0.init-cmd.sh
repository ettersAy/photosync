#!/bin/bash
set -e

# === Config ===
PROJECT_DIR="$HOME/photosync"
SERVER_SCRIPTS_DIR="$PROJECT_DIR/scripts/Server"

declare -A CMD_MAP=(
  ["pss-start"]="1.start-server.sh"
  ["pss-status"]="2.status-server.sh"
  ["pss-restart"]="3.restart-server.sh"
  ["pss-stop"]="4.stop-server.sh"
  ["pss-logs"]="5.logs-server.sh"
)

echo "🔧 Initializing PhotoSync dev commands..."

# === 1. Ensure ~/bin exists ===
if [ ! -d "$HOME/bin" ]; then
  echo "📁 Creating $HOME/bin ..."
  mkdir -p "$HOME/bin"
else
  echo "📁 $HOME/bin already exists."
fi

# === 2. Ensure ~/bin is in PATH (current shell + future shells) ===
if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo "➕ Adding \$HOME/bin to current PATH..."
  export PATH="$HOME/bin:$PATH"
fi

if [ -f "$HOME/.bashrc" ]; then
  if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$HOME/.bashrc"; then
    echo '➕ Persisting \$HOME/bin in PATH via ~/.bashrc'
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  else
    echo "ℹ️ ~/.bashrc already updates PATH with \$HOME/bin."
  fi
fi

# === 3. Ensure server scripts are executable ===
for script in "${CMD_MAP[@]}"; do
  target="$SERVER_SCRIPTS_DIR/$script"
  if [ -f "$target" ]; then
    chmod +x "$target"
    echo "✅ Exec permission ensured for: $target"
  else
    echo "⚠️ Missing script: $target (command will be skipped)"
  fi
done

# === 4. Create wrapper commands in ~/bin ===
for cmd in "${!CMD_MAP[@]}"; do
  target="$SERVER_SCRIPTS_DIR/${CMD_MAP[$cmd]}"
  link="$HOME/bin/$cmd"

  if [ ! -f "$target" ]; then
    echo "⏭ Skipping $cmd: target script not found ($target)"
    continue
  fi

  cat > "$link" <<EOF
#!/bin/bash
"$target" "\$@"
EOF

  chmod +x "$link"
  echo "🔗 Installed command: $cmd -> $target"
done

echo
echo "✅ Done. Available commands now:"
echo "   - pss-start"
echo "   - pss-status"
echo "   - pss-restart"
echo "   - pss-stop"
echo
echo "👉 Open a new shell or run:  source ~/.bashrc"
