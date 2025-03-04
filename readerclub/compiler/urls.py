from django.urls import path
from .views import *

urlpatterns = [
    path('compiler/', compile_code, name='compile_code'),
]