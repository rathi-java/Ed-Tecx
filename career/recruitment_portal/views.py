from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Company, ApplicantDetail, Domain, Category
from job_portal.models import Job, JobApplication
from internship_portal.models import Internship, InternshipApplication
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
import datetime

def recruitment_portal(request):
    """
    View for the recruitment portal dashboard.
    Fetches company details, jobs, and internships if the logged-in user is a company.
    """
    if request.session.get('role') != "company":
        return redirect('/?form_type=login')  # Redirect to login if not a company

    company_id = request.session.get('user_id')
    company_details = Company.objects.filter(id=company_id).first()
    
    if not company_details:
        return redirect('/?form_type=login')  # Redirect if company not found
    
    # Get jobs and internships posted by this company
    jobs = Job.objects.filter(company=company_details).order_by('-created_at')
    internships = Internship.objects.filter(company=company_details).order_by('-created_at')
    
    # Get categories for dropdown options
    categories = Category.objects.all()
    
    # Handle job form submission
    if request.method == 'POST':
        if 'job_form' in request.POST:
            handle_job_form(request, company_details)
        elif 'internship_form' in request.POST:
            handle_internship_form(request, company_details)
    
    context = {
        'company': company_details,
        'jobs': jobs,
        'internships': internships,
        'job_count': jobs.count(),
        'internship_count': internships.count(),
        'total_posts': jobs.count() + internships.count(),
        'categories': categories,
    }
    
    return render(request, 'recruitment_portal.html', context)

def handle_job_form(request, company):
    """Helper function to process job form submission"""
    try:
        category_id = request.POST.get('category')
        category = Category.objects.get(id=category_id)
        
        job = Job(
            company=company,
            category=category,
            role=request.POST.get('job_profile'),
            position=request.POST.get('job_profile'),  # Using job_profile for position as well
            job_type=request.POST.get('job_type'),
            required_experience=request.POST.get('experience_required'),
            salary_per_annum=request.POST.get('ctc_package'),
            responsibilities=request.POST.get('responsibility'),
            eligibility=request.POST.get('eligibility'),
            vacancy=request.POST.get('openings'),
            required_skills=request.POST.get('skills_required'),
            job_description=request.POST.get('job_description')
        )
        job.save()
        messages.success(request, 'Job added successfully!')
    except Exception as e:
        messages.error(request, f'Error adding job: {str(e)}')

def handle_internship_form(request, company):
    """Helper function to process internship form submission"""
    try:
        category_id = request.POST.get('category')
        category = Category.objects.get(id=category_id)
        
        internship = Internship(
            company=company,
            category=category,
            role=request.POST.get('internship_role'),
            responsibilities=request.POST.get('responsibility'),
            duration=request.POST.get('internship_type'),
            stipend=request.POST.get('stipend'),
            required_skills=request.POST.get('skills_required'),
            openings=request.POST.get('openings')
        )
        internship.save()
        messages.success(request, 'Internship added successfully!')
    except Exception as e:
        messages.error(request, f'Error adding internship: {str(e)}')

def get_job_details(request, job_id):
    """View to get details of a specific job"""
    if request.session.get('role') != "company":
        return JsonResponse({'error': 'Not authorized'}, status=403)
    
    try:
        job = Job.objects.get(job_id=job_id)
        
        # Check if the job belongs to the logged-in company
        if job.company.id != request.session.get('user_id'):
            return JsonResponse({'error': 'Not authorized'}, status=403)
        
        # Get applications for this job
        applications = JobApplication.objects.filter(job=job)
        
        # Format the applications data
        applicants_data = []
        for app in applications:
            applicant = app.applicantdetails
            applicants_data.append({
                'id': app.id,
                'name': f"{applicant.first_name} {applicant.last_name}",
                'qualification': applicant.qualification,
                'resume_url': applicant.resume.url if applicant.resume else None,
                'status': 'Pending'  # You can add a status field to JobApplication model
            })
        
        # Format job data
        job_data = {
            'id': job.job_id,
            'role': job.role,
            'category': job.category.name,
            'job_type': job.job_type,
            'salary': job.salary_per_annum,
            'experience': job.required_experience,
            'description': job.job_description,
            'posted_at': job.created_at.strftime('%d %b %Y'),
            'days_ago': (datetime.datetime.now().date() - job.created_at.date()).days,
            'applicants': applicants_data
        }
        
        return JsonResponse(job_data)
    except Job.DoesNotExist:
        return JsonResponse({'error': 'Job not found'}, status=404)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

def get_internship_details(request, internship_id):
    """View to get details of a specific internship"""
    if request.session.get('role') != "company":
        return JsonResponse({'error': 'Not authorized'}, status=403)
    
    try:
        internship = Internship.objects.get(internship_id=internship_id)
        
        # Check if the internship belongs to the logged-in company
        if internship.company.id != request.session.get('user_id'):
            return JsonResponse({'error': 'Not authorized'}, status=403)
        
        # Get applications for this internship
        applications = InternshipApplication.objects.filter(internship=internship)
        
        # Format the applications data
        applicants_data = []
        for app in applications:
            applicant = app.applicantdetail
            applicants_data.append({
                'id': app.id,
                'name': f"{applicant.first_name} {applicant.last_name}",
                'qualification': applicant.qualification,
                'resume_url': applicant.resume.url if applicant.resume else None,
                'status': 'Pending'  # You can add a status field to InternshipApplication model
            })
        
        # Format internship data
        internship_data = {
            'id': internship.internship_id,
            'role': internship.role,
            'category': internship.category.name,
            'duration': internship.duration,
            'stipend': internship.stipend,
            'skills': internship.required_skills,
            'posted_at': internship.created_at.strftime('%d %b %Y'),
            'days_ago': (datetime.datetime.now().date() - internship.created_at.date()).days,
            'applicants': applicants_data
        }
        
        return JsonResponse(internship_data)
    except Internship.DoesNotExist:
        return JsonResponse({'error': 'Internship not found'}, status=404)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
        
def company_view(request):
    """
    View to display and edit company details.
    Fetches the logged-in company's details if the role is "company".
    Handles POST requests to update company details.
    """
    if request.session.get('role') != "company":
        return redirect('/?form_type=login')
        
    company_id = request.session.get('user_id')
    company_details = Company.objects.filter(id=company_id).first()

    if not company_details:
        return redirect('/?form_type=login')

    if request.method == "POST":
        try:
            # Update company details from the form
            company_details.name = request.POST.get('name', company_details.name)
            company_details.email = request.POST.get('email', company_details.email)
            company_details.contact_number = request.POST.get('contact_number', company_details.contact_number)
            company_details.working_employees = request.POST.get('working_employees', company_details.working_employees)
            company_details.industry_type = request.POST.get('industry_type', company_details.industry_type)
            company_details.established_year = request.POST.get('established_year', company_details.established_year)
            company_details.address = request.POST.get('address', company_details.address)
            company_details.about = request.POST.get('about', company_details.about)

            # Handle logo upload
            if 'logo' in request.FILES:
                company_details.logo = request.FILES['logo']

            # Save the updated company details
            company_details.save()
            messages.success(request, 'Company details updated successfully!')
        except Exception as e:
            messages.error(request, f'Error updating company details: {str(e)}')
            
    return redirect('recruitment_portal')

# Keeping these for backward compatibility
def jobs_view(request):
    return redirect('recruitment_portal')

def internship_view(request):
    return redirect('recruitment_portal')

def recruitment_portol_signup(request):
    return render(request, 'recruitment_portal_signup.html')

def company_signup(request):
    if request.method == 'POST':
        try:
            # Check if password and confirm_password match
            password = request.POST.get('password')
            confirm_password = request.POST.get('confirm_password')
            
            if password != confirm_password:
                messages.error(request, 'Passwords do not match!')
                return render(request, 'recruitment_portal_signup.html')
            
            # Extract data from form
            company_data = {
                'name': request.POST.get('name'),
                'email': request.POST.get('email'),
                'contact_number': request.POST.get('phone'),  # Map 'phone' from form to 'contact_number' in model
                'address': request.POST.get('address'),
                'about': request.POST.get('about'),
                'working_employees': request.POST.get('working_employees'),
                'established_year': request.POST.get('established_year'),
                'industry_type': request.POST.get('industry_type'),
                'password': request.POST.get('password'),
            }
            
            # Create and save company instance
            company = Company(**company_data)
            company.save()
            
            messages.success(request, 'Company registered successfully!')
            return redirect('/?form_type=login')  # Redirect to login page after successful registration
            
        except Exception as e:
            messages.error(request, f'Error during registration: {str(e)}')
            return render(request, 'recruitment_portal_signup.html')
    
    # If GET request, just show the form
    return render(request, 'recruitment_portal_signup.html')