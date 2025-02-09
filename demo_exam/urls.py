from django.urls import path
from .views import *
urlpatterns = [
    path('demomanage/', manage_questions, name='manage_questions'),
    path('demoquestions/',display_questions, name='demo_question_list'),
    # path('submit_exam/', submit_exam, name='submit_exam'),
    # path('instructions/', instructions, name='instructions'),
    #  path('instructions/terms/', terms, name='terms'),
    # path('instructions/privacy/', privacy, name='privacy'),

]