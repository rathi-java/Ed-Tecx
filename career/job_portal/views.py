from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from .forms import CategoryForm, CompanyForm, JobForm  # Import forms
from .models import Category, Company, Domain, Job, JobApplication
from django.db.models import Q

from django.shortcuts import render
from .models import Job

def job_page(request):
    jobs = Job.objects.all()

    location = request.GET.get('location')
    package = request.GET.get('package')
    opening_date = request.GET.get('opening_date')
    experience = request.GET.get('experience')

    if location:
        jobs = jobs.filter(company__address__icontains=location)

    if package:
        try:
            min_package, max_package = map(float, package.split('-'))
            jobs = jobs.filter(salary_per_annum__gte=min_package, salary_per_annum__lte=max_package)
        except ValueError:
            pass  # Ignore invalid values

    if opening_date:
        try:
            jobs = jobs.filter(created_at__month=int(opening_date))
        except ValueError:
            pass  # Ignore invalid values

    if experience:
        if experience.lower() in ['fresher', 'mid', 'senior']:  # Adjust as needed
            jobs = jobs.filter(required_experience__icontains=experience)
        else:
            try:
                jobs = jobs.filter(required_experience__gte=int(experience))
            except ValueError:
                pass  # Ignore invalid values

    return render(request, 'job_page.html', {'jobs': jobs})

def home(request):
    return render(request, 'index.html')

def submit_application(request):
    if request.method == 'POST':
        # Handle job application form submission
        # Extract data from request.POST and request.FILES
        # Save the data to the JobApplication model
        messages.success(request, 'Your application has been submitted successfully.')
        return redirect('job_page')
    return redirect('job_page')

def add_category(request):
    if request.method == 'POST':
        form = CategoryForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Category added successfully.')
            return redirect('add_category')
    else:
        form = CategoryForm()
    return render(request, 'add_category.html', {'form': form})

def add_company(request):
    if request.method == 'POST':
        form = CompanyForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, 'Company added successfully.')
            return redirect('add_company')
    else:
        form = CompanyForm()
    return render(request, 'add_company.html', {'form': form})

def add_job(request):
    if request.method == 'POST':
        form = JobForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Job added successfully.')
            return redirect('add_job')
    else:
        form = JobForm()
    return render(request, 'add_job.html', {'form': form})

def dashboard(request):
    categories = Category.objects.all()
    companies = Company.objects.all()
    jobs = Job.objects.all()
    return render(request, 'dashboard.html', {'categories': categories, 'companies': companies, 'jobs': jobs})

def delete_category(request, category_id):
    category = get_object_or_404(Category, id=category_id)
    category.delete()
    messages.success(request, 'Category deleted successfully.')
    return redirect('dashboard')

def delete_company(request, company_id):
    company = get_object_or_404(Company, id=company_id)
    company.delete()
    messages.success(request, 'Company deleted successfully.')
    return redirect('dashboard')

def delete_job(request, job_id):
    job = get_object_or_404(Job, id=job_id)
    job.delete()
    messages.success(request, 'Job deleted successfully.')
    return redirect('dashboard')

def edit_category(request, category_id):
    category = get_object_or_404(Category, id=category_id)
    if request.method == 'POST':
        form = CategoryForm(request.POST, instance=category)
        if form.is_valid():
            form.save()
            messages.success(request, 'Category updated successfully.')
            return redirect('dashboard')
    else:
        form = CategoryForm(instance=category)
    return render(request, 'edit_category.html', {'form': form})

def edit_company(request, company_id):
    company = get_object_or_404(Company, id=company_id)
    if request.method == 'POST':
        form = CompanyForm(request.POST, request.FILES, instance=company)
        if form.is_valid():
            form.save()
            messages.success(request, 'Company updated successfully.')
            return redirect('dashboard')
    else:
        form = CompanyForm(instance=company)
    return render(request, 'edit_company.html', {'form': form})

def edit_job(request, job_id):
    job = get_object_or_404(Job, id=job_id)
    if request.method == 'POST':
        form = JobForm(request.POST, instance=job)
        if form.is_valid():
            form.save()
            messages.success(request, 'Job updated successfully.')
            return redirect('dashboard')
    else:
        form = JobForm(instance=job)
    return render(request, 'edit_job.html', {'form': form})
