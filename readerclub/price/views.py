from django.shortcuts import render
import requests
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

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import logging
import requests
from django.conf import settings

# Set up logging
logger = logging.getLogger(__name__)

@csrf_exempt
def create_cashfree_order(request):
    if request.method == 'POST':
        try:
            # Log the incoming request data
            logger.info(f"Received POST request with data: {request.POST}")

            # Get the amount from the POST request
            amount = request.POST.get('amount')

            if not amount:
                logger.error("Amount is missing from the request.")
                return JsonResponse({"error": "Amount is required"}, status=400)

            # Generate a unique order ID (you can implement your logic here)
            import uuid
            order_id = f"order_{uuid.uuid4().hex[:10]}"

            # Create the order payload for Cashfree API
            order_data = {
                "order_id": order_id,
                "order_amount": float(amount),
                "order_currency": "INR",
                "customer_details": {
                    "customer_id": "customer_123",
                    "customer_email": "customer@example.com",
                    "customer_phone": "9999999999"
                },
                "order_meta": {
                    "return_url": f"{request.build_absolute_uri('/').rstrip('/')}/pay/cashfree_payment_success/?order_id={order_id}",
                    "notify_url": f"{request.build_absolute_uri('/').rstrip('/')}/pay/cashfree_webhook/"
                }
            }

            # Headers for Cashfree API
            headers = {
                "x-client-id": settings.CASHFREE_KEY_ID,
                "x-client-secret": settings.CASHFREE_SECRET_KEY,
                "x-api-version": "2022-09-01",
                "Content-Type": "application/json"
            }

            # Make the API call to create an order
            url = "https://sandbox.cashfree.com/pg/orders"  # Use production URL in production
            
            # Log request being sent
            logger.info(f"Sending request to Cashfree API: {url}, Payload: {order_data}")
            
            response = requests.post(url, json=order_data, headers=headers)
            
            # Log the response
            logger.info(f"Cashfree API Response: {response.status_code} - {response.text}")

            if response.status_code == 200:
                response_data = response.json()
                return JsonResponse(response_data)
            else:
                logger.error(f"Cashfree API error: {response.status_code} - {response.text}")
                return JsonResponse({"error": f"Cashfree Order creation failed: {response.text}"}, status=400)
                
        except Exception as e:
            # Log the exception
            logger.error(f"Error while processing cashfree order: {str(e)}", exc_info=True)
            return JsonResponse({"error": str(e)}, status=500)
    
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
    
@csrf_exempt
def cashfree_payment_success(request):
    if request.method == "POST":
        user = request.user
        payment_id = request.POST.get("payment_id")
        order_id = request.POST.get("order_id")
        amount = request.POST.get("amount")
        plan_id = request.POST.get("plan_id")

        # Check for successful payment status and update the user's subscription
        # (You may want to validate the payment status with Cashfree)

        # Update user's subscription
        plan = get_object_or_404(SubscriptionPlan, id=plan_id)
        user.set_subscription(plan)

        # Record the payment transaction
        PaymentTransaction.objects.create(
            user=user,
            subscription_plan=plan,
            payment_gateway="cashfree",  # Indicates Cashfree as the payment gateway
            order_id=order_id,
            payment_id=payment_id,
            amount=amount,
            currency="INR",
            status="captured"
        )

        return JsonResponse({"status": "success"})
    else:
        return JsonResponse({"error": "Invalid request method"}, status=400)
