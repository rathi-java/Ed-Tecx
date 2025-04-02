from django.contrib import admin
from django.urls import path, include
from admin_portal.views import *

urlpatterns = [

    path('', dashboard,name="dashboard"),
    path("add-college/", dashboard, name="add-college-section"),
    path("add-admin/", dashboard, name="add-admin-section"),
    path("add-employee/", dashboard, name="add-employee-section"),
    path("add-college/", dashboard, name="add-college-section"),
    path('add-job/', dashboard, name='add-job-section'),  # Handles adding and updating jobs
    path("add-manager/", dashboard, name="add-manager-section"),
    path("add-question/", dashboard, name="add-question-section"),
    path("add-student/", dashboard, name="add-student-section"),
    path('add-user/', dashboard, name='add-user-section'),
    path("add-student/", dashboard, name="add-student-section"), 
    path('add-placement-stories/', dashboard, name='add-placement-story-section'),
    path("add-exam/", dashboard, name="add-exam-section"), 
    path("manage-admin/", dashboard, name="manage-admin-section"),
    path("manage-employee/", dashboard, name="manage-employee-section"),
    # path("manage-college/", add_college, name="manage-college-section"),
    path("manage-college/", dashboard, name="manage-college-section"),
    path('manage-job/', dashboard, name='manage-job-section'),  # Handles adding and updating jobs
    path("manage-manager/", dashboard, name="manage-manager-section"),
    path("manage-question/", dashboard, name="manage-question-section"),
    path("manage-student/", dashboard, name="manage-student-section"),
    path('manage-user/', dashboard, name='manage-user-section'),
    path("manage-student/", dashboard, name="manage-student-section"), 
    path('manage-placement-stories/', dashboard, name='manage-placement-story-section'),
    path("manage-exam/", dashboard, name="manage-exam-section"), 
    path("manage-plan-types/", manage_plan_types, name="manage_plan_types"),
    path("manage-subscription-plans/", manage_subscription_plans, name="manage_subscription_plans"),
    path('toggle-subscription-status/', toggle_subscription_status, name='toggle_subscription_status'),
    path('reorder_subscription_plans/', reorder_subscription_plans, name='reorder_subscription_plans'),

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
    path('manage_price/', price_management, name='manage_price'),
    path('manage_subscription/', subscription_management, name='manage_subscription'),
    path("dashboard/delete_subscription/<int:plan_id>/", delete_subscription_plan, name="delete_subscription_plan"),

    path("add_question/", add_question, name="add_question"),
    path("delete_question/<int:question_id>/", delete_question, name="delete_question"),
    # path('manage-questions/', manage_questions, name='manage_questions'),
    path('get-subjects/', get_subjects, name='get-subjects'),
    path('get_superadmin_profile/', get_superadmin_profile, name='get_superadmin_profile'),
    path('update_superadmin_profile/', update_superadmin_profile, name='update_superadmin_profile'),
    # path('exams/', list_exams, name='list_exams'),
    # path('exams/create/', create_exam, name='create_exam'),
    # path('transfer_admin/<int:admin_id>/<int:new_superadmin_id>/', transfer_admin, name='transfer_admin'),
    # path('transfer_manager/<int:manager_id>/<int:new_admin_id>/', transfer_manager, name='transfer_manager'),
    # path('transfer_employee/<int:employee_id>/<int:new_manager_id>/', transfer_employee, name='transfer_employee'),
    # path('admin-dashboard/', adm_dashboard, name='adm_dashboard'),
    # path('manager-dashboard/', mgr_dashboard, name='mgr_dashboard'),
    # path('employee-dashboard/', emp_dashboard, name='emp_dashboard'),
    # path('adm_dashboard/', adm_dashboard, name='adm_dashboard'),
    # path('mgr_dashboard/', mgr_dashboard, name='mgr_dashboard'),
    # path('emp_dashboard/', emp_dashboard, name='emp_dashboard'),
    path('view-top-achievers/', view_top_achievers, name='view-top-achievers'),
    path('manage-top-achievers/', manage_top_achievers, name='manage-top-achievers'),
    path('dashboard/', dashboard, name='dashboard'),
]
