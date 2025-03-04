from django.urls import path
from .views import *

urlpatterns = [
    path('manage/', manage_questions, name='manage_questions'),

    # path('submit_exam/', submit_exam, name='submit_exam'),
    path('instructions/', instructions, name='instructions'),
    path('results/', user_exam_results, name='exam_results'),
    path('instructions/terms/', terms, name='terms'),
    path('upload-questions/', upload_questions, name='upload_questions'),
    path('instructions/privacy/', privacy, name='privacy'),
    path('manage_exams/', manage_exams, name='manage_exams'),
    path('exams/', list_exams, name='list_exams'),
    path('exams/create/', create_exam, name='create_exam'),
    path('exams/<int:exam_id>/take/', take_exam, name='take_exam'),
    path('submit-custom-exam/', submit_custom_exam, name='submit_exam'),
     path('get-questions-by-subject/',get_questions_by_subject, name='get_questions_by_subject'),
]
