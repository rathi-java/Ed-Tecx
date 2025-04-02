#!/bin/sh

# # Wait for Elasticsearch to be available on the correct host
# echo "Waiting for Elasticsearch to start..."
# until curl -s http://elasticsearch:9200 > /dev/null; do
#     echo "Elasticsearch not available yet. Waiting 2 seconds..."
#     sleep 2
# done
# echo "Elasticsearch is up and running."

# # Continue with your startup commands...

# Update database schemas/tables using db.sql

python manage.py migrate --noinput
python manage.py collectstatic --noinput --clear
mkdir -p /app/logs
touch /app/logs/gunicorn.log
touch /app/logs/gunicorn-access.log

exec gunicorn \
    --name readerclub \
    --workers 4 \
    --timeout 30 \
    --bind 0.0.0.0:8000 \
    --log-level info \
    --log-file /app/logs/gunicorn.log \
    --access-logfile /app/logs/gunicorn-access.log \
    readerclub.wsgi:application
