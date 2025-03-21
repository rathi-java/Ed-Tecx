from django.shortcuts import render

# Create your views here.
def freelancing_landing_page(request):
    return render(request, 'freelancing_landing.html')