import json
from django.shortcuts import redirect, render
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
import hashlib
import uuid
from urllib.parse import urlencode
from django.urls import reverse

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

@csrf_exempt
def cashfree_webhook(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        order_id = data.get('orderId')
        payment_status = data.get('txStatus')
        
        if payment_status == 'SUCCESS':
            # Handle successful payment
            pass
        elif payment_status == 'FAILED':
            # Handle failed payment
            pass
        elif payment_status == 'PENDING':
            # Handle pending payment
            pass
        
        return JsonResponse({"status": "received"})
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
    if request.method == "POST" or request.method == "GET":
        order_id = request.GET.get("order_id") or request.POST.get("order_id")
        payment_id = request.GET.get("payment_id") or request.POST.get("payment_id")
        amount = request.GET.get("amount") or request.POST.get("amount")
        plan_id = request.GET.get("plan_id") or request.POST.get("plan_id")

        if not (order_id and payment_id and amount and plan_id):
            return JsonResponse({"error": "Missing required parameters"}, status=400)

        # Check for successful payment status (here, you would typically validate with Cashfree)

        # Retrieve the subscription plan and update the user's subscription
        plan = get_object_or_404(SubscriptionPlan, id=plan_id)
        user = request.user
        user.set_subscription(plan)

        # Record the payment transaction
        PaymentTransaction.objects.create(
            user=user,
            subscription_plan=plan,
            payment_gateway="cashfree",
            order_id=order_id,
            payment_id=payment_id,
            amount=amount,
            currency="INR",
            status="captured"
        )

        # Redirect to the 'price.html' page, passing the order_id as a query parameter
        return redirect(f"/price/?order_id={order_id}")

    return JsonResponse({"error": "Invalid request method"}, status=400)

@csrf_exempt
def create_payu_order(request):
    """
    Create a PayU order.
    """
    if request.method == "POST":
        try:
            amount = request.POST.get('amount')
            plan_id = request.POST.get('plan_id')
            if not amount or not plan_id:
                return JsonResponse({"error": "Amount and Plan ID are required"}, status=400)

            txnid = f"txn_{uuid.uuid4().hex[:10]}"
            productinfo = f"Subscription Plan {plan_id}"
            firstname = "Customer"
            email = "customer@example.com"
            success_url = request.build_absolute_uri(reverse('payu_payment_success'))
            failure_url = request.build_absolute_uri(reverse('payu_payment_failure'))

            data = {
                'key': settings.PAYU_MERCHANT_KEY,
                'txnid': txnid,
                'amount': amount,
                'productinfo': productinfo,
                'firstname': firstname,
                'email': email,
                'surl': success_url,
                'furl': failure_url,
                'service_provider': 'payu_paisa',
                'udf1': plan_id,
                'udf2': '',
                'udf3': '',
                'udf4': '',
                'udf5': '',
            }

            # Generate hash
            hash_string = (
                f"{settings.PAYU_MERCHANT_KEY}|{txnid}|{amount}|{productinfo}|"
                f"{firstname}|{email}|{plan_id}||||||||||{settings.PAYU_SALT}"
            )
            data['hash'] = hashlib.sha512(hash_string.encode('utf-8')).hexdigest()

            return JsonResponse({
                'payment_url': settings.PAYU_BASE_URL,
                'form_data': data
            })
        except Exception as e:
            logger.error(f"Error creating PayU order: {str(e)}", exc_info=True)
            return JsonResponse({"error": "Internal server error"}, status=500)
        
@csrf_exempt
def payu_payment_success(request):
    """
    Handle successful PayU payments.
    """
    if request.method == "POST":
        try:
            txnid = request.POST.get('txnid')
            amount = request.POST.get('amount')
            status = request.POST.get('status')
            posted_hash = request.POST.get('hash')
            plan_id = request.POST.get('udf1')

            # Verify hash
            hash_string = (
                f"{settings.PAYU_SALT}|{status}||||||{request.POST.get('udf5', '')}|"
                f"{request.POST.get('udf4', '')}|{request.POST.get('udf3', '')}|"
                f"{request.POST.get('udf2', '')}|{plan_id}|{request.POST.get('email', '')}|"
                f"{request.POST.get('firstname', '')}|{request.POST.get('productinfo', '')}|"
                f"{amount}|{txnid}|{settings.PAYU_MERCHANT_KEY}"
            )
            calculated_hash = hashlib.sha512(hash_string.encode('utf-8')).hexdigest().lower()

            if posted_hash.lower() == calculated_hash and status == 'success':
                user = request.user
                plan = get_object_or_404(SubscriptionPlan, id=plan_id)
                user.set_subscription(plan)

                PaymentTransaction.objects.create(
                    user=user,
                    subscription_plan=plan,
                    payment_gateway="payu",
                    order_id=txnid,
                    payment_id=request.POST.get('mihpayid'),
                    amount=amount,
                    currency="INR",
                    status=status
                )

                return redirect(f"/price/?status=success&order_id={txnid}")
            else:
                return redirect("/price/?status=error")
        except Exception as e:
            logger.error(f"Error handling PayU success: {str(e)}", exc_info=True)
            return redirect("/price/?status=error")

@csrf_exempt
def payu_payment_failure(request):
    """
    Handle failed PayU payments.
    """
    if request.method == "POST":
        txnid = request.POST.get('txnid')
        return redirect(f"/price/?status=error&order_id={txnid}")
    return redirect("/price/")

