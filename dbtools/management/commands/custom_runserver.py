import os
import sys
import pymysql
from django.core.management.base import BaseCommand
from django.core.management import call_command
from django.conf import settings

class Command(BaseCommand):
    help = "Checks MySQL credentials, database existence, and runs the server"

    def handle(self, *args, **kwargs):
        db_settings = settings.DATABASES['default']
        user = db_settings['USER']
        password = db_settings['PASSWORD']
        host = db_settings['HOST']
        port = db_settings['PORT']
        database = db_settings['NAME']

        try:
            # Check if MySQL credentials are correct
            connection = pymysql.connect(
                host=host,
                user=user,
                password=password,
                port=int(port)
            )
            self.stdout.write(self.style.SUCCESS("✅ MySQL credentials are correct!"))
        except pymysql.MySQLError as e:
            self.stdout.write(self.style.ERROR(f"❌ MySQL authentication failed: {e}"))
            sys.exit(1)

        try:
            # Check if database exists
            with connection.cursor() as cursor:
                cursor.execute(f"SHOW DATABASES LIKE '{database}'")
                result = cursor.fetchone()
                if result:
                    self.stdout.write(self.style.SUCCESS(f"✅ Database '{database}' exists."))
                else:
                    self.stdout.write(self.style.WARNING(f"⚠️ Database '{database}' does not exist."))
                    create_db = input("Do you want to create the database? (y/n): ").strip().lower()
                    if create_db == 'y':
                        cursor.execute(f"CREATE DATABASE {database}")
                        self.stdout.write(self.style.SUCCESS(f"✅ Database '{database}' created successfully."))
                    else:
                        self.stdout.write(self.style.ERROR("❌ Database creation cancelled. Exiting."))
                        sys.exit(1)

        except pymysql.MySQLError as e:
            self.stdout.write(self.style.ERROR(f"❌ Error checking/creating database: {e}"))
            sys.exit(1)

        finally:
            connection.close()

        # Run `dumpdb` before migrations
        self.stdout.write(self.style.SUCCESS("🔄 Running DUMPDB..."))
        call_command('dumpdb')

        # Run `loaddb` before migrations
        self.stdout.write(self.style.SUCCESS("🔄 Running loaddb..."))
        call_command('loaddb')

        # Run `initdb` before migrations
        self.stdout.write(self.style.SUCCESS("🔄 Running initdb..."))
        call_command('initdb')

        # Run migrations before starting the server
        self.stdout.write(self.style.SUCCESS("🔄 Running Migrations..."))
        call_command('migrate')

        # Start Django server
        self.stdout.write(self.style.SUCCESS("🚀 Starting Django Server..."))
        call_command('runserver')
