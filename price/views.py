import razorpay
from django.shortcuts import render
from django.conf import settings

def price(request):
    client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET))

    # Define plans
    plans = {
        "monthly": 29900,  # Amount in paisa (₹299.00)
        "yearly": 99900    # Amount in paisa (₹999.00)
    }

    # Create Razorpay orders for each plan
    orders = {}
    for plan, amount in plans.items():
        order = client.order.create({
            "amount": amount,
            "currency": "INR",
            "payment_capture": "1"
        })
        orders[plan] = order["id"]

    context = {
        "key": settings.RAZORPAY_KEY_ID,
        "orders": orders,
        "plans": plans,
    }

    return render(request, "price.html", context)