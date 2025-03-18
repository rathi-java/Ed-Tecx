from django.contrib import admin

# Register your models here.
from .models import Internship, InternshipApplication,  InternshipCategory, InternshipCompany

admin.site.register(Internship)
admin.site.register(InternshipApplication)
admin.site.register(InternshipCategory)
admin.site.register(InternshipCompany)
