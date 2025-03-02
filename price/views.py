from django.shortcuts import render
from .models import SubscriptionPlan
import razorpay
from django.conf import settings
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

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