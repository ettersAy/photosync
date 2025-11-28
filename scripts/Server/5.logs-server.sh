#!/bin/bash
PROJECT_DIR="$HOME/photosync"
cd "$PROJECT_DIR"

echo "   >>> Laravel log:"
tail -n 30 storage/logs/laravel-dev-server.log || echo "No Laravel log yet."

echo
echo "   >>> Vite log:"
tail -n 30 storage/logs/vite-dev.log || echo "No Vite log yet."

