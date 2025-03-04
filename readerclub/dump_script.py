import os
import django
from django.core.management import call_command
from django.conf import settings
import io

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Ed_Tecx.settings')
django.setup()  # Set up the Django environment

def replace_problematic_chars(data):
    return data.replace('\u20b9', 'Rs')

# Capture the dumpdata output to a string
output = io.StringIO()
call_command('dumpdata', stdout=output)

# Get the string value of the data
data = output.getvalue()

# Replace problematic characters
data = replace_problematic_chars(data)

# Write the data to a file
with open('data.json', 'w', encoding='utf-8') as f:
    f.write(data)
