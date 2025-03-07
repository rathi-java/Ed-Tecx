# job_portal/urls.py
from django.urls import path
from . import views

urlpatterns = [
    # path('', views.home, name='home'),
    path('jobs/', views.job_page, name='job_page'),
    path('submit_application/', views.submit_application, name='submit_application'),
    path('add_category/', views.add_category, name='add_category'),
    path('add_company/', views.add_company, name='add_company'),
    path('add_job/', views.add_job, name='add_job'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('delete_category/<int:category_id>/', views.delete_category, name='delete_category'),
    path('delete_company/<int:company_id>/', views.delete_company, name='delete_company'),
    path('delete_job/<int:job_id>/', views.delete_job, name='delete_job'),
    path('edit_category/<int:category_id>/', views.edit_category, name='edit_category'),
    path('edit_company/<int:company_id>/', views.edit_company, name='edit_company'),
    path('edit_job/<int:job_id>/', views.edit_job, name='edit_job'),
]
