from django.urls import path
from .views import *

urlpatterns = [
    path("create-payment/<str:plan_type>/", create_payment, name="create_payment"),
    path("webhook/", razorpay_webhook, name="razorpay_webhook"),
    path("payment/", payment_page, name="payment_page"),
]
