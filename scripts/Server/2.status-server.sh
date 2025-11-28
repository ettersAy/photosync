#!/bin/bash
set -e

PROJECT_DIR="$HOME/photosync"
cd "$PROJECT_DIR"

LARAVEL_PID_FILE=".laravel-dev.pid"
VITE_PID_FILE=".vite-dev.pid"

check_service() {
  local name="$1"
  local pid_file="$2"

  if [ ! -f "$pid_file" ]; then
    echo "$name: ❌ not running (no PID file)"
    return
  fi

  local pid
  pid=$(cat "$pid_file")

  if ps -p "$pid" > /dev/null 2>&1; then
    echo "$name: ✅ running (PID $pid)"
  else
    echo "$name: ⚠️ PID file exists but process is not running (PID $pid) → cleaning up"
    rm -f "$pid_file"
  fi
}

echo "     >>> PhotoSync dev servers status:"
check_service "Laravel server" "$LARAVEL_PID_FILE"
check_service "Vite dev server" "$VITE_PID_FILE"
