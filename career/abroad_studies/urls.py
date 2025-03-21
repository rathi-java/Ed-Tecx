
from django.urls import path
from . import views

urlpatterns = [

    path('', views.abroad_studies, name='abroad_studies'),
    path('dashboard/', views.dashboard, name='dashboard'),

    path('enquiry/', views.enquiry_view, name='enquiry'),
]
