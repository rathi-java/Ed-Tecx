import datetime
import calendar
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.db.models import Q
from .forms import CategoryForm, CompanyForm, JobForm
from .models import Category, Company, Job, JobApplication
from django.http import JsonResponse
from .documents import JobDocument
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import JsonResponse
from .models import JobSeeker, JobSeekerEducation, JobSeekerExperience, JobApplication, Job
import json
from datetime import datetime

def submit_application_job(request):
    """View to handle job application form submission"""
    print("=" * 50)
    print("SUBMIT APPLICATION JOB VIEW STARTED")
    print(f"Request method: {request.method}")
    print(f"User: {request.user}")
    
    if request.method != 'POST':
        return redirect('job_page')
    
    try:
        # Print all POST data for debugging
        print("Form data received:")
        for key, value in request.POST.items():
            print(f"  {key}: {value}")
        
        # Get job_id from form
        job_id = request.POST.get('job_id')
        print(f"Original job_id from form: {job_id}")
        
        # Try to find the job by job_code
        if job_id:
            try:
                job = get_object_or_404(Job, job_code=job_id)
                print(f"Found job by exact match: {job.job_code} - {job.role}")
            except Http404:
                print(f"No job found with job_code: {job_id}")
                messages.error(request, f"No job found with ID: {job_id}")
                return redirect('job_page')
        else:
            print("No job_id provided in form")
            messages.error(request, "No job selected. Please select a job before applying.")
            return redirect('job_page')
        
        # Personal details
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        phone = request.POST.get('phone')
        skills = request.POST.get('skills')
        
        # Get or create JobSeeker
        job_seeker, created = JobSeeker.objects.get_or_create(
            user=request.user,
            defaults={
                'first_name': first_name,
                'last_name': last_name,
                'phone': phone,
                'skills': skills
            }
        )
        
        # Update if already exists
        if not created:
            job_seeker.first_name = first_name
            job_seeker.last_name = last_name
            job_seeker.phone = phone
            job_seeker.skills = skills
            job_seeker.save()
        
        # Process Education data
        # Clear existing education entries if updating
        if not created:
            JobSeekerEducation.objects.filter(job_seeker=job_seeker).delete()
        
        # Find all education entries from the form
        education_data = {}
        for key, value in request.POST.items():
            if key.startswith('education['):
                parts = key.replace('education[', '').replace(']', '').split('[')
                index = parts[0]
                field = parts[1]
                
                if index not in education_data:
                    education_data[index] = {}
                
                education_data[index][field] = value
        
        # Create new education entries
        for edu_entry in education_data.values():
            if edu_entry.get('degree') and edu_entry.get('institution') and edu_entry.get('passing_year'):
                JobSeekerEducation.objects.create(
                    job_seeker=job_seeker,
                    degree=edu_entry.get('degree'),
                    specialization=edu_entry.get('specialization', ''),
                    institution=edu_entry.get('institution'),
                    passing_year=edu_entry.get('passing_year'),
                    score=edu_entry.get('score', '')
                )
        
        # Process Experience data
        # Clear existing experience entries if updating
        if not created:
            JobSeekerExperience.objects.filter(job_seeker=job_seeker).delete()
        
        # Find all experience entries from the form
        experience_data = {}
        for key, value in request.POST.items():
            if key.startswith('experience['):
                parts = key.replace('experience[', '').replace(']', '').split('[')
                index = parts[0]
                field = parts[1]
                
                if index not in experience_data:
                    experience_data[index] = {}
                
                experience_data[index][field] = value
        
        # Create new experience entries
        for exp_entry in experience_data.values():
            if exp_entry.get('company') and exp_entry.get('role') and exp_entry.get('start_date'):
                start_date = datetime.strptime(exp_entry.get('start_date'), '%Y-%m-%d').date()
                end_date = None
                if exp_entry.get('end_date'):
                    end_date = datetime.strptime(exp_entry.get('end_date'), '%Y-%m-%d').date()
                
                JobSeekerExperience.objects.create(
                    job_seeker=job_seeker,
                    company=exp_entry.get('company'),
                    role=exp_entry.get('role'),
                    start_date=start_date,
                    end_date=end_date,
                    description=exp_entry.get('description', ''),
                    achievements=exp_entry.get('achievements', '')
                )
        
        # Create JobApplication
        application_skills = request.POST.get('application_skills')
        expected_ctc = request.POST.get('expected_ctc', '')
        
        # Check if application for this job already exists
        existing_application = JobApplication.objects.filter(
            user=request.user,
            job_seeker=job_seeker,
            job=job
        ).first()
        
        if existing_application:
            existing_application.skills = application_skills
            existing_application.expected_ctc = expected_ctc
            existing_application.save()
            messages.success(request, "Your application has been updated successfully!")
        else:
            JobApplication.objects.create(
                user=request.user,
                job_seeker=job_seeker,
                job=job,
                skills=application_skills,
                expected_ctc=expected_ctc
            )
            messages.success(request, "Your application has been submitted successfully!")
            
        print(f"Application submitted for job: {job.job_code} - {job.role}")
        return redirect('job_page')
    
    except Exception as e:
        print(f"ERROR IN SUBMISSION: {str(e)}")
        import traceback
        print(traceback.format_exc())
        messages.error(request, f"Error submitting application: {str(e)}")
        return redirect('job_page')

def autocomplete(request):
    term = request.GET.get('term', '')
    suggestions = []
    
    if term and len(term) > 2:
        search = JobDocument.search().suggest(
            'job-suggest', term,
            completion={
                'field': 'role_suggest',
                'fuzzy': {'fuzziness': 'AUTO'}
            }
        )
        search_response = search.execute()
        # Use direct indexing since search_response.suggest is an AttrDict.
        try:
            suggest_results = search_response.suggest["job-suggest"]
        except KeyError:
            suggest_results = []
        
        for entry in suggest_results:
            for option in entry.options:
                suggestions.append(option.text)
    
    return JsonResponse(suggestions, safe=False)

def elastic_job_search(request):
    """
    Search for jobs using Elasticsearch instead of Django ORM.
    """
    # Retrieve parameters from GET request
    location = request.GET.get('location', '')
    package = request.GET.get('package', '')
    opening_date = request.GET.get('opening_date', '')
    experience = request.GET.get('experience', '')
    query = request.GET.get('q', '')  # free-text query

    # Start building an Elasticsearch search query using the JobDocument
    search = JobDocument.search()

    # Apply free-text search using a bool should query to match multiple fields
    if query:
        search = search.query("bool", should=[
            {"match": {"role": {"query": query, "fuzziness": "AUTO"}}},
            {"match": {"job_description": {"query": query}}},
            {"match": {"required_skills": {"query": query}}},
            {"match": {"eligibility": {"query": query}}}
        ], minimum_should_match=1)

    # Filter by location: assume the field is "company.address"
    if location:
        search = search.filter("match", **{"company.address": location})

    # Filter by package using a range on salary_per_annum
    if package:
        try:
            min_package, max_package = map(float, package.split('-'))
            search = search.filter("range", salary_per_annum={"gte": min_package, "lte": max_package})
        except ValueError:
            pass

    # Filter by opening date (using the month of job creation)
    if opening_date:
        try:
            month = int(opening_date)
            year = datetime.datetime.now().year  # adjust if needed
            start_date = datetime.datetime(year, month, 1)
            last_day = calendar.monthrange(year, month)[1]
            end_date = datetime.datetime(year, month, last_day, 23, 59, 59)
            search = search.filter("range", created_at={"gte": start_date, "lte": end_date})
        except ValueError:
            pass

    # Filter by experience (using a match query)
    if experience:
        search = search.filter("match", required_experience={"query": experience})

    # Execute the search
    response = search.execute()
    jobs = response.hits
    
    # Process jobs to extract city from address
    for job in jobs:
        if hasattr(job, 'company') and hasattr(job.company, 'address'):
            try:
                address_parts = job.company.address.split(',')
                if len(address_parts) > 1:
                    job.company.city = address_parts[1].strip()
                else:
                    job.company.city = job.company.address
            except Exception:
                job.company.city = job.company.address

    # Render the same template, passing the ES results instead of ORM objects.
    return render(request, 'job_page.html', {'jobs': jobs})
# def job_page(request):
#     """
#     Display jobs with optional filtering using Django ORM.
#     """
#     # Retrieve filter parameters from the request
#     location = request.GET.get('location')
#     package = request.GET.get('package')
#     opening_date = request.GET.get('opening_date')
#     experience = request.GET.get('experience')
#     query = request.GET.get('q')

#     jobs = Job.objects.all()

#     if query:
#         jobs = jobs.filter(
#             Q(role__icontains=query) |
#             Q(job_description__icontains=query) |
#             Q(required_skills__icontains=query) |
#             Q(eligibility__icontains=query)
#         )

#     if location:
#         jobs = jobs.filter(company__address__icontains=location)

#     if package:
#         try:
#             min_package, max_package = map(float, package.split('-'))
#             jobs = jobs.filter(salary_per_annum__gte=min_package, salary_per_annum__lte=max_package)
#         except ValueError:
#             pass

#     if opening_date:
#         try:
#             month = int(opening_date)
#             year = datetime.datetime.now().year
#             start_date = datetime.datetime(year, month, 1)
#             last_day = calendar.monthrange(year, month)[1]
#             end_date = datetime.datetime(year, month, last_day, 23, 59, 59)
#             jobs = jobs.filter(created_at__range=(start_date, end_date))
#         except ValueError:
#             pass

#     if experience:
#         jobs = jobs.filter(required_experience__icontains=experience)

#     return render(request, 'job_page.html', {'jobs': jobs})


def home(request):
    return render(request, 'index.html')


def submit_application(request):
    if request.method == 'POST':
        # Handle job application form submission
        # Extract data from request.POST and request.FILES,
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
