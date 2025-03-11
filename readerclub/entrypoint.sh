#!/bin/sh
set -e

# Run migrations (if needed)
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput

LOG_DIR="/var/log/readerclub"
mkdir -p $LOG_DIR
# Start Gunicorn server – this replaces the CMD instruction in the Dockerfile
exec gunicorn --chdir /app \
    --bind 0.0.0.0:8000 \
    --workers 4 \
    --access-logfile "$LOG_DIR/gunicorn_access.log" \
    --error-logfile "$LOG_DIR/gunicorn_error.log" \
    readerclub.wsgi:application
