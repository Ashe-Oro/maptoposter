#!/bin/bash
set -e

# Default to port 8000 if PORT not set
PORT="${PORT:-8000}"

echo "Starting server on port $PORT"
exec uvicorn app.main:app --host 0.0.0.0 --port "$PORT"
