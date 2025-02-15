from django.contrib import admin
from .models import StudentsDB

@admin.register(StudentsDB)
class StudentAdmin(admin.ModelAdmin):
    list_display = ('username', 'full_name', 'email', 'phone_number', 'domain', 'subject', 'date', 'payment')
    list_filter = ('domain', 'subject', 'date')
    search_fields = ('username', 'full_name', 'email', 'phone_number')
    ordering = ('-date',)
