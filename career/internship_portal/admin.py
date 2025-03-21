from django.contrib import admin

# Register your models here.
from .models import Internship, InternshipApplication

admin.site.register(Internship)
admin.site.register(InternshipApplication)
