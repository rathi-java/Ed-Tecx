import pymysql
from django.core.management.base import BaseCommand
from django.conf import settings

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
            connection = pymysql.connect(
                host=host, user=user, password=password, port=port
            )
            cursor = connection.cursor()

            cursor.execute(f"SHOW DATABASES LIKE '{db_name}'")
            if not cursor.fetchone():
                cursor.execute(f"CREATE DATABASE `{db_name}`")
                self.stdout.write(self.style.SUCCESS(f"✅ Database '{db_name}' created successfully."))
            else:
                self.stdout.write(self.style.SUCCESS(f"✅ Database '{db_name}' already exists."))

        except pymysql.MySQLError as e:
            self.stderr.write(self.style.ERROR(f"❌ Error creating/checking database: {e}"))
        finally:
            cursor.close()
            connection.close()
