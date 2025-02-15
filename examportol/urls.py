from django.urls import path
from .views import *

urlpatterns = [
    path('manage/', manage_questions, name='manage_questions'),
    path('questions/', display_questions, name='question_list'),
    path('submit_exam/', submit_exam, name='submit_exam'),
    path('instructions/', instructions, name='instructions'),
    path('results/',user_exam_results, name='exam_results'),
    path('instructions/terms/', terms, name='terms'),
    path('certificate/<int:exam_id>/', generate_certificate, name='generate_certificate'),

    path('instructions/privacy/', privacy, name='privacy'),
   
]