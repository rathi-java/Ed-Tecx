from django.urls import path
from .views import manage_questions, display_questions, submit_exam, instructions, terms, privacy

urlpatterns = [
    path('manage/', manage_questions, name='manage_questions'),
    path('questions/', display_questions, name='question_list'),
    path('submit_exam/', submit_exam, name='submit_exam'),
    path('instructions/', instructions, name='instructions'),
    path('instructions/terms/', terms, name='terms'),
    path('instructions/privacy/', privacy, name='privacy'),
   
]