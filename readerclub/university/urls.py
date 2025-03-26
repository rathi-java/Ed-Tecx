from django.urls import path
from . import views

urlpatterns = [
    # University
    path('', views.university, name='university'),
    
    # Referral Code
    path('referral/', views.referral_code, name='referral_code'),
    
    # Students
    path('students/', views.registered_students, name='registered_students'),
    
    # Professors
    path('professors/', views.professor_list, name='professor_list'),
    path('professor/add/', views.add_professor, name='add_professor'),
    path('professor/<int:professor_id>/edit/', views.edit_professor, name='edit_professor'),
    path('professor/<int:professor_id>/delete/', views.delete_professor, name='delete_professor'),
    
    # Courses
    path('courses/', views.course_list, name='course_list'),
    path('course/add/', views.add_course, name='add_course'),
    path('course/<int:course_id>/edit/', views.edit_course, name='edit_course'),
    path('course/<int:course_id>/delete/', views.delete_course, name='delete_course'),
    
    # Difficulty
    path('difficulty/', views.difficulty_list, name='difficulty_list'),
    path('difficulty/add/', views.add_difficulty, name='add_difficulty'),
    path('difficulty/<int:difficulty_id>/edit/', views.edit_difficulty, name='edit_difficulty'),
    path('difficulty/<int:difficulty_id>/delete/', views.delete_difficulty, name='delete_difficulty'),
    
    # Exams
    path('exams/', views.exam_list, name='exam_list'),
    path('exam/add/', views.add_exam, name='add_exam'),
    path('exam/<int:exam_id>/edit/', views.edit_exam, name='edit_exam'),
    path('exam/<int:exam_id>/delete/', views.delete_exam, name='delete_exam'),
    path('exam/<int:exam_id>/get/', views.get_exam_data, name='get_exam_data'),
    path('exam/<int:exam_id>/start/', views.start_exam, name='start_exam'),
    
    # Questions
    path('upload_questions/<int:exam_id>/', views.upload_questions, name='upload_questions'),
    path('exam/<int:exam_id>/add-questions-manually/', views.add_questions_manually, name='add_questions_manually'),
    
    # Results
    path('results/', views.result_list, name='result_list'),
    path('exam/<int:exam_id>/results/', views.exam_results, name='exam_results'),
    path('exam-results/<int:exam_id>/', views.exam_results, name='exam_results'),
    
    # New paths for exam links
    path('start-exam/<int:exam_id>/', views.start_exam, name='start_exam'),
    path('exam/access/<str:unique_code>/', views.student_exam_access, name='student_exam_access'),
    
    # API endpoints
    path('get-exam-data/<int:exam_id>/', views.get_exam_data, name='get_exam_data'),
    path('get-exam-questions/<int:exam_id>/', views.get_exam_questions, name='get_exam_questions'),
    path('delete-question/<int:question_id>/', views.delete_question, name='delete_question'),
]