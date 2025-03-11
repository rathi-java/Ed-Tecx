#!/bin/sh
set -e

# Run migrations (if needed)
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput

# Start Gunicorn server – this replaces the CMD instruction in the Dockerfile
exec gunicorn --chdir /app --bind 0.0.0.0:8001 career.wsgi:application
