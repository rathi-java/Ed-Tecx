# job_portal/urls.py
from django.urls import path
from . import views

urlpatterns = [
    # path('', views.home, name='home'),
    path('jobs/', views.elastic_job_search, name='job_page'),
    path('submit_application/', views.submit_application, name='submit_application'),
    path('add-category/', views.add_category, name='add_category'),
    path('add-company/', views.add_company, name='add_company'),
    path('add-job/', views.add_job, name='add_job'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('delete-category/<int:category_id>/', views.delete_category, name='delete_category'),
    path('delete-company/<int:company_id>/', views.delete_company, name='delete_company'),
    path('delete-job/<int:job_id>/', views.delete_job, name='delete_job'),
    path('edit-category/<int:category_id>/', views.edit_category, name='edit_category'),
    path('edit-company/<int:company_id>/', views.edit_company, name='edit_company'),
    path('edit-job/<int:job_id>/', views.edit_job, name='edit_job'),

    path('submit-application-job/', views.submit_application_job, name='submit_application_job'),
]
