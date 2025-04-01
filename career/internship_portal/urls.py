from django.urls import path
from .views import *

urlpatterns = [
    path('internships/', elastic_internship_search, name='internship_search'),
    path('autocomplete/internships/', autocomplete_internship, name='autocomplete_internship'),
    path('', internship_landing_page, name='internship_landing_page'),
    path('submit-application-internship/', submit_application_internship, name='submit_application_internship'),
]