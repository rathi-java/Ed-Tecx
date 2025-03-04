# oauth/context_processors.py
from .models import *

def college_list(request):
    return {'colleges': CollegesDb.objects.all()}

def current_user(request):
    user_id = request.session.get('user_id')
    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
            return {'logged_in_user': user}
        except UsersDB.DoesNotExist:
            return {'logged_in_user': None}
    return {'logged_in_user': None}