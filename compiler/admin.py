from django.contrib import admin
from .models import CodeSubmission
# Register your models here.

@admin.register(CodeSubmission)
class CodeSubmissionAdmin(admin.ModelAdmin):
    list_display = ('id', 'language', 'created_at', 'updated_at', 'output')
    search_fields = ('language', 'created_at', 'updated_at')
