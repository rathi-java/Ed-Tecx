import datetime
import calendar
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.db.models import Q
from .forms import CategoryForm, CompanyForm, JobForm
from .models import Category, Company, Job, JobApplication
from django.http import JsonResponse
from .documents import JobDocument

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

    # Render the same template, passing the ES results instead of ORM objects.
    return render(request, 'job_page.html', {'jobs': jobs})
def job_page(request):
    """
    Display jobs with optional filtering using Django ORM.
    """
    # Retrieve filter parameters from the request
    location = request.GET.get('location')
    package = request.GET.get('package')
    opening_date = request.GET.get('opening_date')
    experience = request.GET.get('experience')
    query = request.GET.get('q')

    jobs = Job.objects.all()

    if query:
        jobs = jobs.filter(
            Q(role__icontains=query) |
            Q(job_description__icontains=query) |
            Q(required_skills__icontains=query) |
            Q(eligibility__icontains=query)
        )

    if location:
        jobs = jobs.filter(company__address__icontains=location)

    if package:
        try:
            min_package, max_package = map(float, package.split('-'))
            jobs = jobs.filter(salary_per_annum__gte=min_package, salary_per_annum__lte=max_package)
        except ValueError:
            pass

    if opening_date:
        try:
            month = int(opening_date)
            year = datetime.datetime.now().year
            start_date = datetime.datetime(year, month, 1)
            last_day = calendar.monthrange(year, month)[1]
            end_date = datetime.datetime(year, month, last_day, 23, 59, 59)
            jobs = jobs.filter(created_at__range=(start_date, end_date))
        except ValueError:
            pass

    if experience:
        jobs = jobs.filter(required_experience__icontains=experience)

    return render(request, 'job_page.html', {'jobs': jobs})


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
