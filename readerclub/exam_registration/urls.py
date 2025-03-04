from django.urls import path
from .views import *

urlpatterns=[
    path('exam_register/', exam_register, name="exam_register"),
    path('exam_home/', exam_home, name="exam_home"),
    path('exam_resisteration_success/', exam_resisteration_success, name="exam_resisteration_success"),
]