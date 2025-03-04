from django.shortcuts import render
from .models import SubscriptionPlan
from oauth.models import  PaymentTransaction
import razorpay
from django.conf import settings
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
# price/views.py
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.shortcuts import get_object_or_404

razorpay_client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET))

@csrf_exempt
def payment_success(request):
    """
    Handles payment success. Expected POST parameters:
    - razorpay_payment_id
    - razorpay_order_id
    - razorpay_signature
    - plan_id (the subscription plan the user purchased)
    - amount (optional if not retrieved from order details)
    """
    if request.method == "POST":
        user = request.user  # Assumes the user is logged in
        plan_id = request.POST.get("plan_id")
        razorpay_payment_id = request.POST.get("razorpay_payment_id")
        razorpay_order_id = request.POST.get("razorpay_order_id")
        # razorpay_signature = request.POST.get("razorpay_signature")
        amount = request.POST.get("amount")  # amount in your desired currency units
        
        # (Optional) Validate the payment signature here if needed.

        # Retrieve the subscription plan
        plan = get_object_or_404(SubscriptionPlan, id=plan_id)

        # Update user's subscription (this method is defined on UsersDB)
        user.set_subscription(plan)

        # Record the payment transaction
        PaymentTransaction.objects.create(
            user=user,
            subscription_plan=plan,
            razorpay_order_id=razorpay_order_id,
            razorpay_payment_id=razorpay_payment_id,
            amount=amount,
            currency="INR",
            status="captured"  # You may update this based on actual response status
        )

        return JsonResponse({"status": "success"})
    else:
        return JsonResponse({"error": "Invalid request method"}, status=400)

def price(request):
    """
    View for displaying subscription pricing plans
    Fetches all active subscription plans from the database and renders them in the pricing template
    """
    # Get all active subscription plans
    subscription_plans = SubscriptionPlan.objects.filter(is_active=True).order_by('price')
    
    # Create a context dictionary to pass to the template
    context = {
        'subscription_plans': subscription_plans,
    }
    
    return render(request, 'price.html', context)

razorpay_client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET))

@csrf_exempt
def create_order(request):
    if request.method == "POST":
        amount = int(float(request.POST.get("amount")) * 100)  # Convert to paise
        currency = "INR"
        receipt = "order_rcptid_11"
        
        data = {"amount": amount, "currency": currency, "receipt": receipt, "payment_capture": 1}
        order = razorpay_client.order.create(data)

        return JsonResponse(order)