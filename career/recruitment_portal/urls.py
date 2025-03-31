from django.urls import path
from .views import (
    recruitment_portal, jobs_view, internship_view, company_view,
    recruitment_portol_signup, company_signup, get_job_details,
    get_internship_details, view_job_resume, view_internship_resume,
    download_job_resume_pdf, download_internship_resume_pdf,
    generate_job_resume_pdf, generate_internship_resume_pdf
)

urlpatterns = [
    path('', recruitment_portal, name='recruitment_portal'),
    path('jobs/', jobs_view, name='jobs_view'),
    path('internships/', internship_view, name='internship_view'),
    path('companies/', company_view, name='company_view'),
    path('recruitment-portol-signup/', recruitment_portol_signup, name='recruitment_portol_signup'),
    path('company/signup/', company_signup, name='company_signup'),
    
    path('job/<int:job_id>/', get_job_details, name='get_job_details'),
    path('internship/<int:internship_id>/', get_internship_details, name='get_internship_details'),
    
    # Resume preview URLs
    path('resume/job/<int:application_id>/view/', view_job_resume, name='view_job_resume'),
    path('resume/internship/<int:application_id>/view/', view_internship_resume, name='view_internship_resume'),
    
    # Resume download URLs
    path('resume/job/<int:application_id>/download/', download_job_resume_pdf, name='download_job_resume'),
    path('resume/internship/<int:application_id>/download/', download_internship_resume_pdf, name='download_internship_resume'),
    
    # Backwards compatibility
    path('resume/job/<int:application_id>/', generate_job_resume_pdf, name='generate_job_resume'),
    path('resume/internship/<int:application_id>/', generate_internship_resume_pdf, name='generate_internship_resume'),
]
