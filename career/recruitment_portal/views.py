from django.shortcuts import render
from .models import Company, ApplicantDetail, Domain

def recruitment_portal(request):
    return render(request, 'recruitment_portal.html')

def jobs_view(request):
    jobs = ApplicantDetail.objects.all()  # Replace with your Job model if available
    return render(request, 'dashboardSection/jobs.html', {'jobs': jobs})

def internship_view(request):
    internships = Domain.objects.all()  # Replace with your Internship model if available
    return render(request, 'dashboardSection/internship.html', {'internships': internships})

def company_view(request):
    companies = Company.objects.all()
    return render(request, 'dashboardSection/company.html', {'companies': companies})

