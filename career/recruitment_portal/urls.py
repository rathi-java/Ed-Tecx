from django.urls import path
from .views import *

urlpatterns = [
    path('', recruitment_portal, name='recruitment_portal'),
]
