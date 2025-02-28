# dbtools/management/commands/loaddb.py
import subprocess
from django.core.management.base import BaseCommand
from django.conf import settings

class Command(BaseCommand):
    help = 'Loads the SQL dump file (db.sql) into the MySQL database'

    def handle(self, *args, **options):
        db_settings = settings.DATABASES['default']
        db_name = db_settings['NAME']  # e.g., "Ed_tecx"
        user = db_settings['USER']
        password = db_settings['PASSWORD']
        host = db_settings.get('HOST', 'localhost')
        port = str(db_settings.get('PORT', '3306'))

        # First, ensure the target database exists.
        create_db_command = [
            r'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe',
            '-u', user,
            f'-p{password}',
            '-h', host,
            '-P', port,
            '-e', f"CREATE DATABASE IF NOT EXISTS `{db_name}`;"
        ]
        subprocess.run(create_db_command, stderr=subprocess.PIPE, text=True)

        # Build the command to load the dump.
        load_command = [
            r'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe',
            '-u', user,
            f'-p{password}',
            '-h', host,
            '-P', port,
            db_name,
        ]

        try:
            with open('db.sql', 'r') as infile:
                result = subprocess.run(load_command, stdin=infile, stderr=subprocess.PIPE, text=True)
            if result.returncode == 0:
                self.stdout.write(self.style.SUCCESS("Database loaded successfully from db.sql"))
            else:
                self.stderr.write(self.style.ERROR(f"Error during database load: {result.stderr}"))
        except Exception as e:
            self.stderr.write(self.style.ERROR(f"Exception occurred: {e}"))
