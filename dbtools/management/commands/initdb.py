from django.core.management.base import BaseCommand
from django.conf import settings
import MySQLdb

class Command(BaseCommand):
    help = "Creates the MySQL database if it does not exist."

    def handle(self, *args, **options):
        db_settings = settings.DATABASES['default']
        db_name = db_settings['NAME']
        user = db_settings['USER']
        password = db_settings['PASSWORD']
        host = db_settings.get('HOST', 'localhost')
        port = int(db_settings.get('PORT', 3306))
        
        try:
            connection = MySQLdb.connect(host=host, port=port, user=user, passwd=password, db='mysql')
            cursor = connection.cursor()
            cursor.execute(f"CREATE DATABASE IF NOT EXISTS `{db_name}`")
            connection.commit()
            self.stdout.write(self.style.SUCCESS(f"Database '{db_name}' is ready."))
        except Exception as e:
            self.stderr.write(self.style.ERROR(f"Error creating database: {e}"))
        finally:
            if cursor:
                cursor.close()
            if connection:
                connection.close()
