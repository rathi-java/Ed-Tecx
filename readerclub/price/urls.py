from django.urls import path
from .views import *

urlpatterns = [
    path("create-order/", create_order, name="create_order"),
    path("payment-success/", payment_success, name="payment_success"),
    path('create_cashfree_order/', create_cashfree_order, name='create_cashfree_order'),
    path('cashfree_payment_success/', cashfree_payment_success, name='cashfree_payment_success'),
    path('create_payu_order/', create_payu_order, name='create_payu_order'),
    path('payu/payment-success/', payu_payment_success, name='payu_payment_success'),
    path('payu/payment-failure/', payu_payment_failure, name='payu_payment_failure'),
]
