from django.shortcuts import render, redirect
from .models import Company, ApplicantDetail, Domain

def recruitment_portal(request):
    """
    View for the recruitment portal dashboard.
    Fetches company details if the logged-in user is a company.
    """
    company_details = None
    if request.session.get('role') == "company":
        company_id = request.session.get('user_id')
        company_details = Company.objects.filter(id=company_id).first()

    return render(request, 'recruitment_portal.html', {'company': company_details})

def jobs_view(request):
    jobs = ApplicantDetail.objects.all()  # Replace with your Job model if available
    return render(request, 'dashboardSection/jobs.html', {'jobs': jobs})

def internship_view(request):
    internships = Domain.objects.all()  # Replace with your Internship model if available
    return render(request, 'dashboardSection/internship.html', {'internships': internships})

def company_view(request):
    """
    View to display and edit company details.
    Fetches the logged-in company's details if the role is "company".
    Handles POST requests to update company details.
    """
    company_details = None
    if request.session.get('role') == "company":
        company_id = request.session.get('user_id')
        company_details = Company.objects.filter(id=company_id).first()

        if request.method == "POST":
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
            return redirect('company_view')  # Redirect to the same page after saving

    return render(request, 'recruitment_portal.html', {'company': company_details})

