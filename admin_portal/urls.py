from django.contrib import admin
from django.urls import path, include
from admin_portal.views import *

urlpatterns = [

    path('', dashboard,name="dashboard"),
    path('examportol/', include('examportol.urls')),
    path('add-admin/', add_admin, name='add_admin'),
    path('add_manager/', add_manager, name='add_manager'),
    path('add_employee/', add_employee, name='add_employee'),
    path('delete-admin/<int:admin_id>/', delete_admin, name='delete_admin'),
    path('delete-manager/<int:manager_id>/', delete_manager, name='delete_manager'),
    path('delete-employee/<int:employee_id>/', delete_employee, name='delete_employee'),
    path("add_college/", add_college, name="add_college"),
    path("delete_college/<int:college_id>/", delete_college, name="delete_college"),
    path("add_user/", add_user, name="add_user"),
    path("delete_user/<int:user_id>/", delete_user, name="delete_user"),
    path("add_question/", add_question, name="add_question"),
    path("delete_question/<int:question_id>/", delete_question, name="delete_question"),
    path("add-student/", add_student, name="add_student"),
    path("delete-student/<int:student_id>/", delete_student, name="delete_student"),
    # path('manage-questions/', manage_questions, name='manage_questions'),
    path('get-subjects/', get_subjects, name='get_subjects'),
    path("update_certificate_status/", update_certificate_status, name="update_certificate_status"),
]
