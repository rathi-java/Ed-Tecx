from django import forms
from .models import Category, Company, Job

class CategoryForm(forms.ModelForm):
    class Meta:
        model = Category
        fields = ['name']

class CompanyForm(forms.ModelForm):
    class Meta:
        model = Company
        fields = ['name', 'address', 'email', 'contact_number', 'logo', 'about', 'working_employees', 'established_year']

class JobForm(forms.ModelForm):
    class Meta:
        model = Job
        fields = ['category', 'company', 'role', 'responsibilities', 'position', 'eligibility', 'job_type', 'salary_per_annum', 'required_experience', 'job_description', 'required_skills', 'vacancy']
