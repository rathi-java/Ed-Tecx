#!/bin/sh
python manage.py search_index --rebuild
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
    --name career \
    --workers 4 \
    --timeout 120 \
    --bind 0.0.0.0:8001 \
    --log-level info \
    --log-file /app/logs/gunicorn.log \
    --access-logfile /app/logs/gunicorn-access.log \
    career.wsgi:application