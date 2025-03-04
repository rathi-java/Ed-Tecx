from django.contrib import admin
from django.urls import path, include
from admin_portal.views import *

urlpatterns = [

    path('', dashboard,name="dashboard"),
  
    path('manage_admin/', manage_admin, name='manage_admin'),
    path('manage_manager/', manage_manager, name="manage_manager"),
    path('manage_employee/', manage_employee, name="manage_employee"),
    path('manage_users/', manage_users, name="manage_users"),
    path("add_college/", add_college, name="add_college"),
    path("delete_college/<int:college_id>/", delete_college, name="delete_college"),
    path("add_question/", add_question, name="add_question"),
    path("delete_question/<int:question_id>/", delete_question, name="delete_question"),
    path("add-student/", add_student, name="add_student"),
    path("delete-student/<int:student_id>/", delete_student, name="delete_student"),
    # path('manage-questions/', manage_questions, name='manage_questions'),
    path('get-subjects/', get_subjects, name='get_subjects'),
    path("update_certificate_status/", update_certificate_status, name="update_certificate_status"),
    path('add-jobs/', add_jobs, name='add_jobs'),  # Handles adding and updating jobs
    path('delete-job/<int:job_id>/', delete_job, name='delete_job'),
    path('get_superadmin_profile/', get_superadmin_profile, name='get_superadmin_profile'),
    path('update_superadmin_profile/', update_superadmin_profile, name='update_superadmin_profile'),  
    path('add_placement_stories/', add_placement_story, name='add_placement_stories'),
    path('delete_placement_story/<int:story_id>/', delete_placement_story, name='delete_story'),
    path('transfer_admin/<int:admin_id>/<int:new_superadmin_id>/', transfer_admin, name='transfer_admin'),
    path('transfer_manager/<int:manager_id>/<int:new_admin_id>/', transfer_manager, name='transfer_manager'),
    path('transfer_employee/<int:employee_id>/<int:new_manager_id>/', transfer_employee, name='transfer_employee'),
    path('admin-dashboard/', adm_dashboard, name='adm_dashboard'),
    path('manager-dashboard/', mgr_dashboard, name='mgr_dashboard'),
    path('employee-dashboard/', emp_dashboard, name='emp_dashboard'),
    path('adm_dashboard/', adm_dashboard, name='adm_dashboard'),
    path('mgr_dashboard/', mgr_dashboard, name='mgr_dashboard'),
    path('emp_dashboard/', emp_dashboard, name='emp_dashboard'),
]
