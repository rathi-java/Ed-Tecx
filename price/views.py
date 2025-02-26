from django.shortcuts import render

# Create your views here.
from .models import SubscriptionPlan

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