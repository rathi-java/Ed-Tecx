from django.shortcuts import redirect
from functools import wraps
from django.contrib import messages

def role_required(allowed_roles=['superadmin', 'admin', 'manager', 'employee']):
    def decorator(view_func):
        @wraps(view_func)
        def wrapper(request, *args, **kwargs):
            # Check if user is logged in
            # user_id = request.session.get('user_id')
            # user_role = request.session.get('role')  # Corrected session key
            
            # if not user_id or not user_role:
            #     messages.error(request, "Please log in to access this page")
            #     return redirect('login')  # Redirect to login page
            
            # Check if user has the required role
            # if user_role not in allowed_roles:
            #     messages.error(request, "You don't have permission to access this page")
            #     return redirect('home')  # Redirect to home or another appropriate page
            
            return view_func(request, *args, **kwargs)
        return wrapper
    return decorator