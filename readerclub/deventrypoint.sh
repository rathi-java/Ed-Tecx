#!/bin/sh

# Run Django migrations
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput --clear

# Create log directory
mkdir -p /app/logs
touch /app/logs/gunicorn.log
touch /app/logs/gunicorn-access.log

# Start Gunicorn server
exec gunicorn \
    --name readerclub \
    --workers 4 \
    --timeout 30 \
    --bind 0.0.0.0:8000 \
    --log-level info \
    --log-file /app/logs/gunicorn.log \
    --access-logfile /app/logs/gunicorn-access.log \
    readerclub.wsgi:application