# job_portal/urls.py
from django.urls import path
from . import views

urlpatterns = [
    # path('', views.home, name='home'),
    path('', views.abroad_studies, name='abroad_studies'),

    path('enquiry/', views.enquiry_view, name='enquiry'),
]
