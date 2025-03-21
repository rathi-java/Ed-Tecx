from django.urls import path
from .views import *

urlpatterns = [
    path('', freelancing_landing_page, name='freelancing_landing_page'),
]