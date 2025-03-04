from django.shortcuts import redirect
from django.contrib import messages
from django.urls import resolve

class DashboardAccessMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Get the current URL
        current_url = resolve(request.path_info).url_name
        
        # Check if the URL is dashboard-related
        if current_url and ('dashboard' in current_url or current_url in ['adm_dashboard', 'mgr_dashboard', 'emp_dashboard']):
            # Check if user is logged in and has appropriate role
            user_id = request.session.get('user_id')
            user_role = request.session.get('role')  # Correct session key

            
            if not user_id or not user_role:
                messages.error(request, "Please log in to access this page")
                return redirect('login')  # Redirect to your login URL
            
            allowed_roles = ['superadmin', 'admin', 'manager', 'employee']
            if user_role not in allowed_roles:
                messages.error(request, "You don't have permission to access this page")
                return redirect('home')  # Redirect to home
        
        response = self.get_response(request)
        return response