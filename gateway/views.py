import razorpay
from django.conf import settings
from django.http import JsonResponse
from django.shortcuts import render , redirect
import json
from django.views.decorators.csrf import csrf_exempt

# Initialize Razorpay Client
client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET))

def payment_page(request):
    return render(request, "payment.html")

# Define prices for each plan
PLAN_PRICES = {
    "monthly": 29900,  # Razorpay takes amount in paise, so ₹299 = 29900 paise
    "yearly": 99900,   # ₹999 = 99900 paise
}

def create_payment(request, plan_type):
    if plan_type not in PLAN_PRICES:
        return JsonResponse({"error": "Invalid plan"}, status=400)

    amount = PLAN_PRICES[plan_type]  # Get amount for the selected plan

    # Create Razorpay Order
    order_data = {
        "amount": amount,
        "currency": "INR",
        "payment_capture": "1",  # Auto-capture payment
    }
    order = client.order.create(data=order_data)

    # Redirect to payment page with order details
    return render(request, "payment_page.html", {
        "order_id": order["id"],
        "amount": amount / 100,  # Convert back to rupees for display
        "key": settings.RAZORPAY_KEY_ID,
        "plan_type": plan_type
    })

@csrf_exempt
def razorpay_webhook(request):
    try:
        payload = json.loads(request.body)
        event = payload.get("event")

        if event == "payment.captured":
            payment_id = payload["payload"]["payment"]["entity"]["id"]
            amount = payload["payload"]["payment"]["entity"]["amount"]
            print(f"Payment Captured: ID={payment_id}, Amount={amount}")

        return JsonResponse({"status": "success"})
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=400)
