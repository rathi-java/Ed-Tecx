import json
import time
from django.shortcuts import redirect, render
import requests
from .models import SubscriptionPlan
from oauth.models import UsersDB, PaymentTransaction
import razorpay
from django.conf import settings
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.exceptions import ObjectDoesNotExist
# price/views.py
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.shortcuts import get_object_or_404
import hashlib
import uuid
from urllib.parse import urlencode
from django.http import HttpResponse
from django.urls import reverse
import hmac
import hashlib
from django.contrib import messages
from django.contrib.auth.decorators import login_required

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
    subscription_plans = SubscriptionPlan.objects.all()
    
    # Get user data if logged in
    user = None
    user_id = request.session.get('user_id')
    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            pass
    
    context = {
        'subscription_plans': subscription_plans,
        'user': user
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
def razorpay_webhook(request):
    if request.method == 'POST':
        payload = request.body
        received_signature = request.headers.get('X-Razorpay-Signature')

        # Fetch the webhook secret from settings
        webhook_secret = getattr(settings, 'RAZORPAY_WEBHOOK_SECRET', None)

        if not webhook_secret:
            return HttpResponse("Webhook secret not configured", status=500)

        expected_signature = hmac.new(webhook_secret.encode(), payload, hashlib.sha256).hexdigest()

        if received_signature == expected_signature:
            try:
                data = json.loads(payload)
                event = data.get('event')

                if event == 'payment.captured':
                    payment_id = data['payload']['payment']['entity']['id']
                    order_id = data['payload']['payment']['entity']['order_id']
                    amount = data['payload']['payment']['entity']['amount']
                    print(f"Payment captured: {payment_id}, Order ID: {order_id}, Amount: {amount}")

                elif event == 'payment.failed':
                    payment_id = data['payload']['payment']['entity']['id']
                    print(f"Payment failed: {payment_id}")

                return HttpResponse(status=200)

            except json.JSONDecodeError:
                return HttpResponse("Invalid JSON", status=400)
        else:
            return HttpResponse("Invalid signature", status=400)

    return HttpResponse(status=405)


@csrf_exempt
def payment_success(request):
    if request.method == "POST":
        plan_id = request.POST.get("plan_id")      
        
        try:
            # Get the plan
            plan = SubscriptionPlan.objects.get(id=plan_id)
            
            # Get the user
            user_id = request.session.get('user_id')
            user = UsersDB.objects.get(id=user_id)
            
            # Set the subscription
            user.set_subscription(plan)
            
            return JsonResponse({"status": "success"})
        except Exception as e:
            print(f"Payment processing error: {str(e)}")
            return JsonResponse({"status": "error", "message": str(e)})
            
    return JsonResponse({"status": "error", "message": "Invalid request method"})
    
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


# Set up logging
logger = logging.getLogger(__name__)

def generate_hash(data, salt):
    """Generate SHA-512 hash using PayU format."""
    # PayU expects a specific sequence with proper empty fields
    hash_sequence = "|".join([
        data["key"], 
        data["txnid"], 
        str(data["amount"]), 
        data["productinfo"],
        data["firstname"], 
        data["email"], 
        data.get("udf1", ""), 
        data.get("udf2", ""),
        data.get("udf3", ""), 
        data.get("udf4", ""), 
        data.get("udf5", ""),
        "", "", "", "", "",  # Empty fields for udf6-udf10
        salt
    ])

    generated_hash = hashlib.sha512(hash_sequence.encode("utf-8")).hexdigest().lower()
    
    print("\n=== DEBUG INFO ===")
    print(f"Generated Hash: {generated_hash}")
    print(f"Hash Sequence Used: {hash_sequence}")
    print("=================\n")
    
    return generated_hash

def initiate_payment(request):
    """
    Handle PayU payment initiation using direct form submission.
    """
    if request.method != "POST":
        return redirect("price")

    payu_mode = getattr(settings, 'PAYU_MODE', 'test')
    request.session.modified = True
    payu_url = "https://test.payu.in/_payment" if payu_mode == "test" else "https://secure.payu.in/_payment"
    payu_key = settings.PAYU_KEY
    payu_salt = settings.PAYU_SALT

    if not payu_key or not payu_salt:
        messages.error(request, "Payment gateway misconfiguration. Please contact support.")
        return render(request, "payment_failure.html", {"error": "PayU credentials are missing"})

    plan_id = request.POST.get("plan_id", "").strip()
    amount = request.POST.get("amount", "").strip()

    if not plan_id or not amount:
        messages.error(request, "Invalid plan selection.")
        return render(request, "payment_failure.html", {"error": "Invalid plan selection"})

    try:
        amount = "{:.2f}".format(float(amount))
    except ValueError:
        messages.error(request, "Invalid amount format.")
        return render(request, "payment_failure.html", {"error": "Invalid amount format"})

    txnid = f"TXN{int(time.time())}"
    firstname = request.POST.get("firstname", "Guest").strip()
    email = request.POST.get("email", "guest@example.com").strip()
    phone = request.POST.get("phone", "9876543210").strip()
    productinfo = "Subscription".strip()  

    scheme = request.is_secure() and "https" or "http"
    host = request.get_host()
    success_url = f"{scheme}://{host}/payu_success/"
    failure_url = f"{scheme}://{host}/payu_failure/"

    payu_data = {
        "key": payu_key,
        "txnid": txnid,
        "amount": amount,
        "productinfo": productinfo,
        "firstname": firstname,
        "email": email,
        "phone": phone,
        "surl": success_url,
        "furl": failure_url,
        "udf1": plan_id,
        "udf2": "",
        "udf3": "",
        "udf4": "",
        "udf5": ""
    }

    # Generate hash
    payu_data["hash"] = generate_hash(payu_data, payu_salt)

    # **Log the full request payload**
    request_payload_json = json.dumps(payu_data, indent=4)  # Pretty print JSON
    logger.info("=== PayU Request Payload ===")
    logger.info(request_payload_json)
    print("\n=== PayU Request Payload ===")
    print(request_payload_json)
    print("============================\n")

    return render(request, "redirect_to_payu.html", {
        "payu_url": payu_url,
        "payu_data": payu_data
    })

def verify_hash(data, salt):
    """
    Verify hash from PayU callback with detailed logging.
    """
    received_hash = data.get('hash', '').lower()
    status = data.get('status', '')
    
    # Convert all POST parameters to string and handle None values
    post_params = {key: '' if value is None else str(value) 
                  for key, value in data.items()}
    
    # Different hash construction for success and failure
    if status.lower() == 'success':
        # For success, salt is appended at the end
        hash_vars_seq = ("mihpayid", "mode", "status", "key", "txnid", "amount", "addedon",
                         "productinfo", "firstname", "lastname", "address1", "address2", 
                         "city", "state", "country", "zipcode", "email", "phone",
                         "udf1", "udf2", "udf3", "udf4", "udf5", "udf6", "udf7", "udf8",
                         "udf9", "udf10", "card_no")
        
        hash_string = '|'.join([post_params.get(var, '') for var in hash_vars_seq])
        hash_string += f"|{salt}"
    else:
        # For failure, salt is prepended at the beginning
        hash_vars_seq = ("key", "txnid", "amount", "productinfo", "firstname", "email",
                         "udf1", "udf2", "udf3", "udf4", "udf5", "udf6", "udf7", "udf8",
                         "udf9", "udf10")
        
        hash_string = f"{salt}|"
        hash_string += '|'.join([post_params.get(var, '') for var in hash_vars_seq])
    
    # Calculate hash
    calculated_hash = hashlib.sha512(hash_string.encode('utf-8')).hexdigest().lower()
    
    # Debug output
    print(f"\nHash Verification:")
    print(f"Received hash: {received_hash}")
    print(f"Calculated hash: {calculated_hash}")
    print(f"Hash string: {hash_string}")
    
    return calculated_hash == received_hash

from functools import wraps
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt

def exempt_from_session_checks(view_func):
    """
    Custom decorator to exempt a view from session authentication checks.
    This is especially useful for webhook/callback endpoints like PayU success handler.
    """
    @wraps(view_func)
    def wrapped_view(request, *args, **kwargs):
        # Store original authentication status
        original_authenticated = request.user.is_authenticated
        
        # Force authentication bypass for this request only
        # This doesn't actually authenticate the user, but prevents middleware
        # from redirecting to login pages
        request.payu_exempt = True
        
        # Execute the view
        response = view_func(request, *args, **kwargs)
        
        return response
    return wrapped_view


@csrf_exempt
@exempt_from_session_checks
def payu_success(request):
    if request.method == "POST":
        # Log the request
        logger.info("Received PayU success callback")
        logger.info(f"PayU Callback Data: {request.POST}")

        # Verify the hash
        if 'hash' in request.POST:
            hash_valid = verify_hash(request.POST, settings.PAYU_SALT)

            if not hash_valid:
                logger.warning(f"Hash verification failed for transaction: {request.POST.get('txnid')}")
                if request.POST.get('status', '').lower() != 'success':
                    messages.error(request, "Payment verification failed.")
                    return HttpResponse("Hash verification failed.")

            # Process the payment
            try:
                txnid = request.POST.get('txnid')
                amount = request.POST.get("amount", "").strip()
                status = request.POST.get('status')
                mihpayid = request.POST.get('mihpayid')
                plan_id = request.POST.get('udf1')

                # Debugging statements
                logger.info(f"Transaction ID: {txnid}")
                logger.info(f"Amount: {amount}")
                logger.info(f"Status: {status}")
                logger.info(f"Payment ID: {mihpayid}")
                logger.info(f"Plan ID: {plan_id}")

                if status.lower() == 'success' and plan_id:
                    try:
                        plan = SubscriptionPlan.objects.get(id=plan_id)
                    except ObjectDoesNotExist:
                        return HttpResponse("Plan ID is invalid. Please check the plan ID.")

                    user_id = request.session.get('user_id')
                    if user_id:
                        try:
                            user = UsersDB.objects.get(id=user_id)
                        except ObjectDoesNotExist:
                            return HttpResponse("User not found. Please log in again.")

                        # Set the subscription
                        user.set_subscription(plan)

                        # Record the payment transaction
                        PaymentTransaction.objects.create(
                            user=user,
                            subscription_plan=plan,
                            payment_gateway="payu",
                            order_id=txnid,
                            payment_id=mihpayid,
                            amount=amount,
                            currency="INR",
                            status=status.lower()
                        )

                        messages.success(request, "Your payment was successful!")
                        return render(request, "payment_success.html")
                    else:
                        messages.error(request, "User session not found.")
                        return HttpResponse("Login Session not found.")
                else:
                    messages.error(request, f"Payment status: {status}")
                    return HttpResponse("Status is not success.")
            except Exception as e:
                logger.error(f"Error processing payment: {str(e)}", exc_info=True)
                messages.error(request, "Error processing payment. Please contact support.")
                return HttpResponse(f"Payment Not Processed: {str(e)}")
        else:
            logger.warning("Missing hash in PayU callback")
            messages.error(request, "Incomplete payment data received.")
            return HttpResponse("hash is missing")
    else:
        return redirect("price")
    
@csrf_exempt
def payu_failure(request):
    """Handle failed payment callbacks from PayU."""
    # Log request method and all data for debugging
    print("\n=== PayU Failure Callback ===")
    print(f"Request Method: {request.method}")
    if request.method == "POST":
        print("POST Data:")
        for key, value in request.POST.items():
            print(f"  {key}: {value}")
    print("============================\n")
    
    print(f"PayU Failure Response: {request.POST}")

    if request.method == "POST":
        # Verify the hash only if we have sufficient data
        if 'hash' in request.POST and len(request.POST) > 3:
            hash_valid = verify_hash(request.POST, settings.PAYU_SALT)
            print(f"Hash verification result: {hash_valid}")
        
        error_message = request.POST.get('error_Message', 'Payment failed')
        txnid = request.POST.get('txnid', 'Unknown')
        
        print(f"Failed payment: txnid={txnid}, error={error_message}")
        
        messages.error(request, f"Payment failed: {error_message}")
        return render(request, "payment_failure.html", {
            "error": error_message,
            "txnid": txnid
        })
    else:
        # Handle direct access to failure page (correct the missing request parameter)
        messages.error(request, "Payment process was interrupted or cancelled.")
        return render(request, "payment_failure.html", {"error": "Payment process interrupted"})