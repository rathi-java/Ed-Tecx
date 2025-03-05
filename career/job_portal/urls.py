# job_portal/urls.py
from django.urls import path
from .views import *

urlpatterns = [
    path('job_page/', job_page, name='job_page'),
    
]
