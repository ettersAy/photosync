#!/bin/bash
set -e

PROJECT_DIR="$HOME/photosync"
FRONTEND_DIR="$PROJECT_DIR/frontend"   # <-- change if your frontend path is different

LARAVEL_PID_FILE="$PROJECT_DIR/.laravel-dev.pid"
VITE_PID_FILE="$PROJECT_DIR/.vite-dev.pid"

echo "     >>> Starting Laravel dev server $PROJECT_DIR..."
cd "$PROJECT_DIR"

# Clean old stale PID if any
if [ -f "$LARAVEL_PID_FILE" ]; then
  OLD_PID=$(cat "$LARAVEL_PID_FILE")
  if ! ps -p "$OLD_PID" > /dev/null 2>&1; then
    rm -f "$LARAVEL_PID_FILE"
  fi
fi

# Clear caches
echo "     >>> Clearing Laravel caches..."
php artisan config:clear >/dev/null 2>&1
php artisan route:clear >/dev/null 2>&1
php artisan view:clear >/dev/null 2>&1
php artisan optimize:clear >/dev/null 2>&1

# Start Laravel
php artisan serve --host=0.0.0.0 --port=8000 > storage/logs/laravel-dev-server.log 2>&1 &
LARAVEL_PID=$!

# Give it a second to fail if it’s going to
sleep 2

if ps -p "$LARAVEL_PID" > /dev/null 2>&1; then
  echo "$LARAVEL_PID" > "$LARAVEL_PID_FILE"
else
  echo "     >>> ⚠️ Laravel server failed to start. Check storage/logs/laravel-dev-server.log"
fi

echo "     >>> Starting Vite dev server..."
cd "$FRONTEND_DIR"

# Clean old stale PID if any
if [ -f "$VITE_PID_FILE" ]; then
  OLD_VITE_PID=$(cat "$VITE_PID_FILE")
  if ! ps -p "$OLD_VITE_PID" > /dev/null 2>&1; then
    rm -f "$VITE_PID_FILE"
  fi
fi

npm run dev > "$PROJECT_DIR/storage/logs/vite-dev.log" 2>&1 &
VITE_PID=$!

sleep 2

if ps -p "$VITE_PID" > /dev/null 2>&1; then
  echo "$VITE_PID" > "$VITE_PID_FILE"
else
  echo "     >>> ⚠️ Vite dev server failed to start. Check storage/logs/vite-dev.log"
fi

echo "     >>> ✅ Dev servers started:"
echo "     >>> - Laravel: http://0.0.0.0:8000"
echo "     >>> - Vite:    http://0.0.0.0:5173 (or your configured port)"
