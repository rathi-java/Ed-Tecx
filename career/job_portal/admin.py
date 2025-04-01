from django.contrib import admin
from .models import  *
from recruitment_portal.models import Category, Company, ApplicantDetail
admin.site.register(Job)
admin.site.register(Category)
admin.site.register(Company)

admin.site.register(ApplicantDetail)
admin.site.register(JobApplication)