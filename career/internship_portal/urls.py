from django.urls import path
from . import views  # Import the views module
from .views import (
    internship_landing_page,
    autocomplete_internship,
    elastic_internship_search,
    submit_application_internship,
    upskill_page,
    certificate_page,
    study_material_page,
    practice_page,
)

urlpatterns = [
    path('internships/', elastic_internship_search, name='internship_search'),
    path('autocomplete/internships/', autocomplete_internship, name='autocomplete_internship'),
    path('', internship_landing_page, name='internship_landing_page'),
    path('submit-application-internship/', submit_application_internship, name='submit_application_internship'),
    path('upskill/', upskill_page, name='upskill_page'),
    path('certificate/', certificate_page, name='certificate_page'), 
    path('study_material/', study_material_page, name='study_material_page'), 
    path('practice/', practice_page, name='practice_page'),
]