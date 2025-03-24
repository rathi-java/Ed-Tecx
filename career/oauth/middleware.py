from django.shortcuts import redirect
from django.conf import settings

class RoleBasedRedirectMiddleware:
    """
    Middleware to ensure users are redirected based on their role.
    """
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Exclude public paths and login/logout URLs
        public_paths = settings.PUBLIC_PATHS + [settings.LOGIN_REDIRECT_URL, settings.LOGOUT_REDIRECT_URL]
        if any(request.path.startswith(path) for path in public_paths):
            return self.get_response(request)

        user_id = request.session.get('user_id')
        role = request.session.get('role')

        # Ensure the middleware does not interfere with session handling for users logging in with "ABS" usernames
        if user_id and user_id.startswith("ABS"):
            return self.get_response(request)

        # Redirect based on role if user is logged in
        if user_id and role:
            if role == "abroad_studies" and not request.path.startswith('/abroad-studies/'):
                return redirect('/abroad-studies/dashboard/')  # Replace with actual dashboard URL
            elif role == "user" and not request.path.startswith('/home/'):
                return redirect('/home/')  # Replace with actual home URL
            elif role == "company" and not request.path.startswith('/recruitment-portal/'):
                return redirect('/recruitment-portal/')  # Redirect company users to their dashboard

        return self.get_response(request)
