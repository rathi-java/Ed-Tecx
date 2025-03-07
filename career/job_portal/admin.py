from django.contrib import admin
from .models import Category, Company, Job, Domain

admin.site.register(Category)
admin.site.register(Company)
admin.site.register(Job)
admin.site.register(Domain)

