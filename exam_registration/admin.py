from django.contrib import admin
from .models import StudentsDB

@admin.register(StudentsDB)
class StudentsDBAdmin(admin.ModelAdmin):
    list_display = ("username", "email", "domain", "subject", "date", "payment")
    search_fields = ("username", "email")
    list_filter = ("domain", "subject", "date")
