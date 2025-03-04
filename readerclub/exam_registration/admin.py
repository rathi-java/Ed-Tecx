from django.contrib import admin
from .models import StudentsDB

class StudentsDBAdmin(admin.ModelAdmin):
    list_display = ('studentId', 'full_name', 'email', 'phone_number',  'payment', 'registration_code')
    # search_fields = ('studentId', 'full_name', 'email', 'phone_number')
    # list_filter = ('payment')
    # readonly_fields = ('studentId', 'registration_code')

admin.site.register(StudentsDB, StudentsDBAdmin)
