from django.urls import path
from .views import elastic_internship_search, autocomplete_internship

urlpatterns = [
    path('internships/', elastic_internship_search, name='internship_search'),
    path('autocomplete/internships/', autocomplete_internship, name='autocomplete_internship'),
]