# oauth/context_processors.py
from .models import CollegesDb

def college_list(request):
    return {'colleges': CollegesDb.objects.all()}
