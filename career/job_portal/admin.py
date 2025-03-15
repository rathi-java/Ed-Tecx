from django.contrib import admin
from .models import Category, Company, Job, Domain, JobApplication, JobSeeker, JobSeekerEducation, JobSeekerExperience

admin.site.register(Category)
admin.site.register(Company)
admin.site.register(Job)
admin.site.register(Domain)
admin.site.register(JobApplication)
admin.site.register(JobSeeker)
admin.site.register(JobSeekerEducation)
admin.site.register(JobSeekerExperience)

