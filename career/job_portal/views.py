from django.shortcuts import render
from .models import Job

# Create your views here.
def job_page(request):
    if request.method == 'POST':
        # Handle form submission or filtering logic here
        pass

    jobs = Job.objects.all()
    if not jobs:
        jobs = None
    return render(request, 'job_page.html', {'jobs': jobs})

def home(request):
    return render(request, 'index.html')
