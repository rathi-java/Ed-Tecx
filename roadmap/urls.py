from django.urls import path
from . import views  # Ensure this import is correct

urlpatterns = [
    path('', views.roadmap, name='roadmap'),  # Example route
    path('it/', views.it_page, name='it_page'),
    path('datascience/', views.datascience, name='datascience'),
    path('development/', views.development, name='development'),
    path('devops/', views.devops, name='devops'),
    path('management/', views.management_page, name='management_page'),
    path('finance/', views.finance, name='finance'),
    path('digital_marketing/', views.digitalmarketing, name='digitalmarketing'),
    path('operationsmanagement/', views.operationsmanagement, name='operationsmanagement'),
    path('entrepreneurship/', views.entrepreneurship, name='entrepreneurship'),
]
