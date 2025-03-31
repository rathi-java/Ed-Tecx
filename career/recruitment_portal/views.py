from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Company, ApplicantDetail, Domain, Category
from job_portal.models import Job, JobApplication
from internship_portal.models import Internship, InternshipApplication
from django.http import JsonResponse, HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.template.loader import get_template
from xhtml2pdf import pisa
from io import BytesIO
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
    
    # Handle job form submission
    if request.method == 'POST':
        if 'job_form' in request.POST:
            handle_job_form(request, company_details)
            return redirect('recruitment_portal')  # Redirect after POST
        elif 'internship_form' in request.POST:
            handle_internship_form(request, company_details)
            return redirect('recruitment_portal')  # Redirect after POST
    
    # Get jobs and internships posted by this company
    jobs = Job.objects.filter(company=company_details).order_by('-created_at')
    internships = Internship.objects.filter(company=company_details).order_by('-created_at')
    
    # Get categories for dropdown options
    categories = Category.objects.all()
    
    # Prepare job candidates for all jobs
    job_candidates = {}
    for job in jobs:
        applications = JobApplication.objects.filter(job=job)
        candidates = []
        for idx, app in enumerate(applications):
            applicant = app.applicantdetails
            qualification = ', '.join([edu.degree for edu in applicant.educations.all()]) if applicant.educations.exists() else 'Not specified'
            candidates.append({
                'id': app.id,
                'index': idx + 1,
                'name': f"{applicant.first_name} {applicant.last_name}",
                'qualification': qualification,
                'resume_url': f"/recruitment-portal/resume/job/{app.id}/view/"  # Changed to preview URL
            })
        job_candidates[job.job_id] = candidates
    
    # Prepare internship candidates for all internships
    internship_candidates = {}
    for internship in internships:
        applications = InternshipApplication.objects.filter(internship=internship)
        candidates = []
        for idx, app in enumerate(applications):
            applicant = app.applicantdetail
            qualification = ', '.join([edu.degree for edu in applicant.educations.all()]) if applicant.educations.exists() else 'Not specified'
            candidates.append({
                'id': app.id,
                'index': idx + 1,
                'name': f"{applicant.first_name} {applicant.last_name}",
                'qualification': qualification,
                'resume_url': f"/recruitment-portal/resume/internship/{app.id}/view/"  # Changed to preview URL
            })
        internship_candidates[internship.internship_id] = candidates
    
    context = {
        'company': company_details,
        'jobs': jobs,
        'internships': internships,
        'job_count': jobs.count(),
        'internship_count': internships.count(),
        'total_posts': jobs.count() + internships.count(),
        'categories': categories,
        'job_candidates': job_candidates,
        'internship_candidates': internship_candidates,
        'now': datetime.datetime.now(),  # For timestamp in form submission ID
    }
    
    return render(request, 'recruitment_portal.html', context)

def handle_job_form(request, company):
    """Helper function to process job form submission"""
    try:
        # Check if this is potentially a duplicate submission
        form_id = request.POST.get('form_submission_id')
        if form_id:
            # Check if we've already processed this form submission
            if request.session.get('processed_job_forms', []) and form_id in request.session.get('processed_job_forms', []):
                messages.info(request, 'This job has already been added.')
                return
            
            # Add this form ID to processed forms
            processed_forms = request.session.get('processed_job_forms', [])
            processed_forms.append(form_id)
            request.session['processed_job_forms'] = processed_forms
            
        # Check if a similar job already exists
        existing_job = Job.objects.filter(
            company=company,
            role=request.POST.get('job_profile'),
            created_at__gte=datetime.datetime.now() - datetime.timedelta(minutes=5)
        ).first()
        
        if existing_job:
            messages.info(request, 'A similar job was added recently. Please check the job listings.')
            return
        
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
        # Check if this is potentially a duplicate submission
        form_id = request.POST.get('form_submission_id')
        if form_id:
            # Check if we've already processed this form submission
            if request.session.get('processed_internship_forms', []) and form_id in request.session.get('processed_internship_forms', []):
                messages.info(request, 'This internship has already been added.')
                return
            
            # Add this form ID to processed forms
            processed_forms = request.session.get('processed_internship_forms', [])
            processed_forms.append(form_id)
            request.session['processed_internship_forms'] = processed_forms
            
        # Check if a similar internship already exists
        existing_internship = Internship.objects.filter(
            company=company,
            role=request.POST.get('internship_role'),
            created_at__gte=datetime.datetime.now() - datetime.timedelta(minutes=5)
        ).first()
        
        if existing_internship:
            messages.info(request, 'A similar internship was added recently. Please check the internship listings.')
            return
        
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
                'qualification': ', '.join([edu.degree for edu in applicant.educations.all()])
                                 if applicant.educations.exists() else 'Not specified'
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
                'qualification': ', '.join([edu.degree for edu in applicant.educations.all()])
                                 if applicant.educations.exists() else 'Not specified'
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

def view_job_resume(request, application_id):
    """View a job application resume with download and back options"""
    try:
        # Get application and related data
        application = JobApplication.objects.get(id=application_id)
        
        # Check authorization - only the company who posted the job or the application owner can view
        if request.session.get('role') == "company":
            if application.job.company.id != request.session.get('user_id'):
                return HttpResponse('Not authorized to view this resume', status=403)
        elif request.user.is_authenticated and request.user.id != application.user.id:
            return HttpResponse('Not authorized to view this resume', status=403)
            
        applicant = application.applicantdetails
        job = application.job
        educations = applicant.educations.all()
        experiences = applicant.experiences.all() if hasattr(applicant, 'experiences') else []
        
        # Prepare context for template
        context = {
            'application': application,
            'applicant': applicant,
            'job': job,
            'educations': educations,
            'experiences': experiences,
            'current_date': datetime.datetime.now().strftime('%B %d, %Y'),
            'download_url': f"/recruitment-portal/resume/job/{application_id}/download/",
            'back_url': "/recruitment-portal/"  # Default back URL
        }
        
        # If there's a referer, use it as the back URL
        if 'HTTP_REFERER' in request.META:
            context['back_url'] = request.META['HTTP_REFERER']
        
        return render(request, 'job_resume_preview.html', context)
    except JobApplication.DoesNotExist:
        return HttpResponse('Application not found', status=404)
    except Exception as e:
        return HttpResponse(f'Error: {str(e)}', status=500)

def view_internship_resume(request, application_id):
    """View an internship application resume with download and back options"""
    try:
        # Get application and related data
        application = InternshipApplication.objects.get(id=application_id)
        
        # Check authorization - only the company who posted the internship or the application owner can view
        if request.session.get('role') == "company":
            if application.internship.company.id != request.session.get('user_id'):
                return HttpResponse('Not authorized to view this resume', status=403)
        elif request.user.is_authenticated and request.user.id != application.user.id:
            return HttpResponse('Not authorized to view this resume', status=403)
            
        applicant = application.applicantdetail
        internship = application.internship
        educations = applicant.educations.all()
        experiences = applicant.experiences.all() if hasattr(applicant, 'experiences') else []
        
        # Prepare context for template
        context = {
            'application': application,
            'applicant': applicant,
            'internship': internship,
            'educations': educations,
            'experiences': experiences,
            'current_date': datetime.datetime.now().strftime('%B %d, %Y'),
            'download_url': f"/recruitment-portal/resume/internship/{application_id}/download/",
            'back_url': "/recruitment-portal/"  # Default back URL
        }
        
        # If there's a referer, use it as the back URL
        if 'HTTP_REFERER' in request.META:
            context['back_url'] = request.META['HTTP_REFERER']
        
        return render(request, 'internship_resume_preview.html', context)
    except InternshipApplication.DoesNotExist:
        return HttpResponse('Application not found', status=404)
    except Exception as e:
        return HttpResponse(f'Error: {str(e)}', status=500)

def download_job_resume_pdf(request, application_id):
    """Generate a downloadable PDF resume for a job application"""
    try:
        # Get application and related data
        application = JobApplication.objects.get(id=application_id)
        
        # Check authorization - only the company who posted the job or the application owner can download
        if request.session.get('role') == "company":
            if application.job.company.id != request.session.get('user_id'):
                return HttpResponse('Not authorized to download this resume', status=403)
        elif request.user.is_authenticated and request.user.id != application.user.id:
            return HttpResponse('Not authorized to download this resume', status=403)
            
        applicant = application.applicantdetails
        job = application.job
        educations = applicant.educations.all()
        experiences = applicant.experiences.all() if hasattr(applicant, 'experiences') else []
        
        # Prepare context for PDF template
        context = {
            'application': application,
            'applicant': applicant,
            'job': job,
            'educations': educations,
            'experiences': experiences,
            'current_date': datetime.datetime.now().strftime('%B %d, %Y')
        }
        
        # Render HTML template
        template = get_template('job_resume_template.html')
        html = template.render(context)
        
        # Create PDF response
        response = HttpResponse(content_type='application/pdf')
        filename = f"resume_{applicant.first_name}_{applicant.last_name}.pdf"
        response['Content-Disposition'] = f'attachment; filename="{filename}"'
        
        # Generate PDF
        pdf_status = pisa.CreatePDF(BytesIO(html.encode('UTF-8')), response)
        
        if pdf_status.err:
            return HttpResponse('Error generating PDF', status=500)
        
        return response
    except JobApplication.DoesNotExist:
        return HttpResponse('Application not found', status=404)
    except Exception as e:
        return HttpResponse(f'Error: {str(e)}', status=500)

def download_internship_resume_pdf(request, application_id):
    """Generate a downloadable PDF resume for an internship application"""
    try:
        # Get application and related data
        application = InternshipApplication.objects.get(id=application_id)
        
        # Check authorization - only the company who posted the internship or the application owner can download
        if request.session.get('role') == "company":
            if application.internship.company.id != request.session.get('user_id'):
                return HttpResponse('Not authorized to download this resume', status=403)
        elif request.user.is_authenticated and request.user.id != application.user.id:
            return HttpResponse('Not authorized to download this resume', status=403)
            
        applicant = application.applicantdetail
        internship = application.internship
        educations = applicant.educations.all()
        experiences = applicant.experiences.all() if hasattr(applicant, 'experiences') else []
        
        # Prepare context for PDF template
        context = {
            'application': application,
            'applicant': applicant,
            'internship': internship,
            'educations': educations,
            'experiences': experiences,
            'current_date': datetime.datetime.now().strftime('%B %d, %Y')
        }
        
        # Render HTML template
        template = get_template('internship_resume_template.html')
        html = template.render(context)
        
        # Create PDF response
        response = HttpResponse(content_type='application/pdf')
        filename = f"resume_{applicant.first_name}_{applicant.last_name}.pdf"
        response['Content-Disposition'] = f'attachment; filename="{filename}"'
        
        # Generate PDF
        pdf_status = pisa.CreatePDF(BytesIO(html.encode('UTF-8')), response)
        
        if pdf_status.err:
            return HttpResponse('Error generating PDF', status=500)
        
        return response
    except InternshipApplication.DoesNotExist:
        return HttpResponse('Application not found', status=404)
    except Exception as e:
        return HttpResponse(f'Error: {str(e)}', status=500)

# For backward compatibility, but make sure to use the new names in your code
generate_job_resume_pdf = download_job_resume_pdf
generate_internship_resume_pdf = download_internship_resume_pdf