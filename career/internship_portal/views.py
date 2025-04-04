from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse, Http404
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .documents import InternshipDocument
from .models import Internship, InternshipApplication
from recruitment_portal.models import ApplicantDetail, ApplicantEducation, ApplicantExperience
from datetime import datetime
import calendar


def internship_landing_page(request):
    return render(request, 'internship_landing_page.html')


def autocomplete_internship(request):
    term = request.GET.get('term', '')
    suggestions = []
    
    if term and len(term) > 2:
        search = InternshipDocument.search().suggest(
            'internship-suggest', term,
            completion={
                'field': 'role_suggest',
                'fuzzy': {'fuzziness': 'AUTO'}
            }
        )
        search_response = search.execute()
        
        try:
            suggest_results = search_response.suggest["internship-suggest"]
        except KeyError:
            suggest_results = []
        
        for entry in suggest_results:
            for option in entry.options:
                suggestions.append(option.text)
    
    return JsonResponse(suggestions, safe=False)


def elastic_internship_search(request):
    # Initialize the search object from InternshipDocument
    search = InternshipDocument.search()

    # Optionally, add filters, queries, pagination, etc.
    # For example:
    location = request.GET.get('location', '')
    if location:
        search = search.filter("match", location=location)

    # Execute the search
    response = search.execute()
    
    internships = []
    for hit in response:
        # Extract city from location
        city = hit.location
        if hit.location and ',' in hit.location:
            try:
                address_parts = hit.location.split(',')
                if len(address_parts) > 1:
                    city = address_parts[1].strip()
            except Exception:
                city = hit.location
                
        internship = {
            'id': hit.meta.id,
            'role': hit.role,
            'company': {
                'name': hit.company_name,
                'address': hit.location,
                'city': city,  # Add the extracted city
                'logo': hit.company_logo,
                'about': hit.company_about,
                'established_year': hit.company_established_year,
            },
            'duration': hit.duration,
            'stipend': hit.stipend,
            'openings': hit.openings,
            'required_skills': hit.required_skills.split(',') if isinstance(hit.required_skills, str) else hit.required_skills,
            'responsibilities': hit.responsibilities.split('\n') if isinstance(hit.responsibilities, str) else hit.responsibilities,
            'created_at': hit.created_at,
            'internship_code': getattr(hit, 'internship_code', ''),  # Add internship_code
        }
        internships.append(internship)

    # Return response based on the request type
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        return JsonResponse({'internships': internships})
    else:
        return render(request, 'internship_page.html', {'internships': internships})


@login_required
def submit_application_internship(request):
    """View to handle internship application form submission"""
    print("=" * 50)
    print("SUBMIT APPLICATION INTERNSHIP VIEW STARTED")
    print(f"Request method: {request.method}")
    print(f"User: {request.user}")
    
    if request.method != 'POST':
        return redirect('internship_search')
    
    try:
        # Print all POST data for debugging
        print("Form data received:")
        for key, value in request.POST.items():
            print(f"  {key}: {value}")
        
        # Get internship_id from form
        internship_id = request.POST.get('internship_id')
        print(f"Original internship_id from form: {internship_id}")
        
        # Try to find the internship - handle both numeric IDs and internship_code
        internship = None
        if internship_id:
            # First try by internship_code
            try:
                internship = Internship.objects.get(internship_code=internship_id)
                print(f"Found internship by code: {internship.internship_code} - {internship.role}")
            except Internship.DoesNotExist:
                # Then try by primary key (numeric ID)
                try:
                    internship = Internship.objects.get(pk=internship_id)
                    print(f"Found internship by ID: {internship.internship_code} - {internship.role}")
                except (Internship.DoesNotExist, ValueError):
                    # Finally, try with 'I' prefix if it's numeric (convert 123 to I0123)
                    if internship_id.isdigit():
                        try:
                            formatted_id = f"I{int(internship_id):04d}"
                            internship = Internship.objects.get(internship_code=formatted_id)
                            print(f"Found internship by formatted code: {internship.internship_code} - {internship.role}")
                        except Internship.DoesNotExist:
                            pass
            
            if not internship:
                print(f"No internship found with ID or code: {internship_id}")
                messages.error(request, f"No internship found with ID: {internship_id}")
                return redirect('internship_search')
        else:
            print("No internship_id provided in form")
            messages.error(request, "No internship selected. Please select an internship before applying.")
            return redirect('internship_search')
        
        # Personal details
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        phone = request.POST.get('phone')
        skills = request.POST.get('skills')
        
        # Get or create ApplicantDetail
        applicant, created = ApplicantDetail.objects.get_or_create(
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
            applicant.first_name = first_name
            applicant.last_name = last_name
            applicant.phone = phone
            applicant.skills = skills
            applicant.save()
        
        # Process Education data
        # Clear existing education entries if updating
        if not created:
            ApplicantEducation.objects.filter(applicant=applicant).delete()
        
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
                ApplicantEducation.objects.create(
                    applicant=applicant,
                    degree=edu_entry.get('degree'),
                    specialization=edu_entry.get('specialization', ''),
                    institution=edu_entry.get('institution'),
                    passing_year=edu_entry.get('passing_year'),
                    score=edu_entry.get('score', '')
                )
        
        # Process Experience data
        # Clear existing experience entries if updating
        if not created:
            ApplicantExperience.objects.filter(applicant=applicant).delete()
        
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
                
                ApplicantExperience.objects.create(
                    applicant=applicant,
                    company=exp_entry.get('company'),
                    role=exp_entry.get('role'),
                    start_date=start_date,
                    end_date=end_date,
                    description=exp_entry.get('description', ''),
                    achievements=exp_entry.get('achievements', '')
                )
        
        # Create InternshipApplication
        application_reason = request.POST.get('application_reason')
        expected_stipend = request.POST.get('expected_stipend', '')
        
        # Check if application for this internship already exists
        existing_application = InternshipApplication.objects.filter(
            user=request.user,
            applicantdetail=applicant,
            internship=internship
        ).first()
        
        if existing_application:
            existing_application.skills = skills
            existing_application.cover_letter = application_reason
            existing_application.save()
            messages.success(request, "Your internship application has been updated successfully!")
        else:
            InternshipApplication.objects.create(
                user=request.user,
                applicantdetail=applicant,
                internship=internship,
                skills=skills,
                cover_letter=application_reason
            )
            messages.success(request, "Your internship application has been submitted successfully!")
            
        print(f"Application submitted for internship: {internship.internship_code} - {internship.role}")
        return redirect('internship_search')
    
    except Exception as e:
        print(f"ERROR IN SUBMISSION: {str(e)}")
        import traceback
        print(traceback.format_exc())
        messages.error(request, f"Error submitting application: {str(e)}")
        return redirect('internship_search')


def upskill_page(request):
    return render(request, 'upskill.html')


def certificate_page(request):
    return render(request, 'certificate.html')

def study_material_page(request):
    study_materials = [
        {'title': 'Mathematics', 'description': 'Master algebra, calculus, and more with expert notes.', 'link': '#'},
        {'title': 'Science', 'description': 'Dive into physics, chemistry, and biology concepts.', 'link': '#'},
        {'title': 'Computer Science', 'description': 'Learn programming, algorithms, and software development.', 'link': '#'},
        {'title': 'General Knowledge', 'description': 'Expand your awareness with current affairs and quizzes.', 'link': '#'},
        {'title': 'English', 'description': 'Improve grammar, vocabulary, and reading comprehension.', 'link': '#'},
        {'title': 'Logical Reasoning', 'description': 'Sharpen your analytical and problem-solving skills.', 'link': '#'},
    ]
    return render(request, 'study_material.html', {'study_materials': study_materials})

def practice_page(request):
    return render(request, 'practice.html')
