from django.shortcuts import render

# Create your views here.
def job_page(request):
    return render(request, 'job_page.html')

def home(request):
    return render(request, 'index.html')
