from django.shortcuts import render

# Create your views here.

def recruitment_portal(request):
    return render(request, 'recruitment_portal.html')