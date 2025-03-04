from django.shortcuts import render

# Create your views here.
def roadmap(request):
    return render(request, 'roadmap.html')

def it_page(request):
    return render(request, 'it_page.html')

def datascience(request):
    return render(request, 'datascience.html')

def development(request):
    return render(request, 'development.html')

def devops(request):
    return render(request, 'devops.html')

def management_page(request):
    return render(request, 'management_page.html')

def finance(request):
    return render(request, 'finance.html')

def digitalmarketing(request):
    return render(request, 'digitalmarketing.html')

def operationsmanagement(request):
    return render(request, 'operationsmanagement.html')

def entrepreneurship(request):
    return render(request, 'entrepreneurship.html')

