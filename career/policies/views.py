from django.shortcuts import render

# Create your views here.
def about_us(request):
    return render(request, 'about_us.html')  # Ensure this template exists

def privacy_policy(request):
    return render(request, 'privacy_policy.html') 

def terms_and_conditions(request):
    return render(request, 'terms_and_conditions.html')