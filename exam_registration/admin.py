from django.contrib import admin
from .models import StudentsDB

@admin.register(StudentsDB)
class StudentAdmin(admin.ModelAdmin):
    list_display = ('registration_code', 'full_name', 'email', 'phone_number', 'domain', 'subject', 'date', 'payment')
