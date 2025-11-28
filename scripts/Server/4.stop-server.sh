#!/bin/bash
set -e

PROJECT_DIR="$HOME/photosync"
cd "$PROJECT_DIR"

LARAVEL_PID_FILE=".laravel-dev.pid"
VITE_PID_FILE=".vite-dev.pid"

echo "     >>> Stopping PhotoSync dev servers..."

stop_by_pid_file() {
  local name="$1"
  local pid_file="$2"

  if [ -f "$pid_file" ]; then
    local pid
    pid=$(cat "$pid_file")

    if ps -p "$pid" > /dev/null 2>&1; then
      echo "     >>> Stopping $name (PID $pid)..."
      kill "$pid" 2>/dev/null || true
    else
      echo "     >>> $name: PID file exists but process is not running (PID $pid)"
    fi

    rm -f "$pid_file"
  else
    echo "     >>> No $name PID file found."
  fi
}

stop_by_port() {
  local name="$1"
  local port="$2"

  echo "     >>> Checking for any $name still using port $port..."

  # Use lsof if available
  if command -v lsof >/dev/null 2>&1; then
    PIDS=$(lsof -ti:"$port" || true)
    if [ -n "$PIDS" ]; then
      echo "     >>> Forcing stop of $name on port $port (PIDs: $PIDS)..."
      kill $PIDS 2>/dev/null || true
    else
      echo "     >>> No $name found on port $port (lsof)."
    fi
  # Fallback to fuser if lsof not present
  elif command -v fuser >/dev/null 2>&1; then
    if fuser "$port"/tcp >/dev/null 2>&1; then
      echo "     >>> Forcing stop of $name on port $port using fuser..."
      fuser -k "$port"/tcp 2>/dev/null || true
    else
      echo "     >>> No $name found on port $port (fuser)."
    fi
  else
    echo "     >>> ⚠️ Neither lsof nor fuser is available to check port $port."
  fi
}

# 1) Try stopping via PID files (normal case)
stop_by_pid_file "Laravel dev server" "$LARAVEL_PID_FILE"
stop_by_pid_file "Vite dev server" "$VITE_PID_FILE"

# 2) Extra cleanup: kill anything on ports 8000 (Laravel) and 5173 (Vite)
stop_by_port "Laravel dev server" 8000
stop_by_port "Vite dev server" 5173

echo "     >>> ✅ All dev servers stopped (as far as we can detect)."
