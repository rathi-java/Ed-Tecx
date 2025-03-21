from django.shortcuts import redirect
from functools import wraps
from django.contrib import messages

def role_required(allowed_roles=['btobcareercounsling']):
    def decorator(view_func):
        @wraps(view_func)
        def wrapper(request, *args, **kwargs):
            return view_func(request, *args, **kwargs)
        return wrapper
    return decorator