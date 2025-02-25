from django.urls import path
from . import views

urlpatterns = [
    path('report/', views.report_issue, name='report_issue'),
    path('refer/', views.refer_friend, name='refer_friend'),
]
