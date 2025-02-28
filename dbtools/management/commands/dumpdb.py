# myapp/management/commands/dumpdb.py
import subprocess
from django.core.management.base import BaseCommand
from django.conf import settings

class Command(BaseCommand):
    help = "Automatically dumps the MySQL database to db.sql"

    def handle(self, *args, **options):
        db_settings = settings.DATABASES['default']
        db_name = db_settings['NAME']
        user = db_settings['USER']
        password = db_settings['PASSWORD']
        host = db_settings.get('HOST', 'localhost')
        port = str(db_settings.get('PORT', '3306'))

        # Build the mysqldump command.
        # Note: Be cautious with embedding passwords in commands.
        dump_command = [
            r'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe',
            '-u', user,
            f'-p{password}',
            '-h', host,
            '-P', port,
            db_name,
        ]


        try:
            with open('db.sql', 'w') as outfile:
                result = subprocess.run(dump_command, stdout=outfile, stderr=subprocess.PIPE, text=True)
            if result.returncode == 0:
                self.stdout.write(self.style.SUCCESS("Database dump created as db.sql"))
            else:
                self.stderr.write(self.style.ERROR(f"Error during dump: {result.stderr}"))
        except Exception as e:
            self.stderr.write(self.style.ERROR(f"Exception occurred: {e}"))
