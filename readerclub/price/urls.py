from django.urls import path
from .views import *

urlpatterns = [
    path("create-order/", create_order, name="create_order"),
    path("payment-success/", payment_success, name="payment_success"),
    path('create_cashfree_order/', create_cashfree_order, name='create_cashfree_order'),
    path('cashfree_payment_success/', cashfree_payment_success, name='cashfree_payment_success'),
    path("initiate-payment/", initiate_payment, name="initiate_payment"),
]