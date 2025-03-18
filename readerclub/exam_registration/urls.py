from django.urls import path
from .views import *

urlpatterns=[
    path('exam-register/', exam_register, name="exam_register"),
    path('exam-home/', exam_home, name="exam_home"),
    path('exam-resisteration-success/', exam_resisteration_success, name="exam_resisteration_success"),
    path('create-exam-order/', create_exam_order, name='create_exam_order'),
    path('handle-exam-payment-success/', handle_exam_payment_success, name='handle_exam_payment_success'),
]