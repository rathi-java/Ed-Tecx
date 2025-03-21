from django.contrib import admin
from django.urls import path, include
from admin_portal.views import *

urlpatterns = [
    path('', dashboard, name="dashboard"),
    path("add-college/", dashboard, name="add-college-section"),
    path("add-admin/", dashboard, name="add-admin-section"),
    path("add-employee/", dashboard, name="add-employee-section"),
    path("add-manager/", dashboard, name="add-manager-section"),
    path("add-student/", dashboard, name="add-student-section"),
    path('add-user/', dashboard, name='add-user-section'),
    path('add-placement-stories/', dashboard, name='add-placement-story-section'),
    path("add-exam/", dashboard, name="add-exam-section"),
    
    path("manage-admin/", manage_admin, name="manage-admin-section"),  # Corrected to manage_admin view
    path("manage-employee/", manage_employee, name="manage-employee-section"),
    path("manage-college/", dashboard, name="manage-college-section"),
    path("manage-manager/", manage_manager, name="manage-manager-section"),
    path("manage-student/", dashboard, name="manage-student-section"),
    path('manage-user/', manage_users, name='manage-user-section'),
    path('manage-placement-stories/', dashboard, name='manage-placement-story-section'),
    path("manage-exam/", dashboard, name="manage-exam-section"),

    path('certificate-req/', dashboard, name='certificate-req'),
    path("add-student/", add_student, name="add_student"),
    path('add-placement-stories/', add_placement_story, name='add_placement_stories'),
    path("add-college/", add_college, name="add_college"),
    path("manage-student/", add_student, name="manage_student"),
    path('manage_placement_stories/', add_placement_story, name='manage_placement_story'),
    path('manage_admin/', manage_admin, name='manage_admin'),
    path('manage_manager/', manage_manager, name="manage_manager"),
    path('manage_employee/', manage_employee, name="manage_employee"),
    path('manage_users/', manage_users, name="manage_users"),
    path("delete_college/<int:college_id>/", delete_college, name="delete_college"),
    path("delete-student/<int:student_id>/", delete_student, name="delete_student"),
    path("update_certificate_status/", update_certificate_status, name="update_certificate_status"),
    path('delete_placement_story/<int:story_id>/', delete_placement_story, name='delete_story'),

    path("add_question/", add_question, name="add_question"),
    path("delete_question/<int:question_id>/", delete_question, name="delete_question"),
    path('get-subjects/', get_subjects, name='get_subjects'),
    path('get_superadmin_profile/', get_superadmin_profile, name='get_superadmin_profile'),
    path('update_superadmin_profile/', update_superadmin_profile, name='update_superadmin_profile'),
    path('exams/', list_exams, name='list_exams'),
    path('exams/create/', create_exam, name='create_exam'),
    path('transfer_admin/<int:admin_id>/<int:new_superadmin_id>/', transfer_admin, name='transfer_admin'),
    path('transfer_manager/<int:manager_id>/<int:new_admin_id>/', transfer_manager, name='transfer_manager'),
    path('transfer_employee/<int:employee_id>/<int:new_manager_id>/', transfer_employee, name='transfer_employee'),
]