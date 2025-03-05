from oauth.models import UsersDB
from django.conf import settings
from django.shortcuts import redirect
from django.urls import reverse

class LoginRequiredMiddleware:
    """
    This middleware forces a login for any URL that isn't on the allowed list.
    Instead of checking Django's "request.user.is_authenticated",
    we look for 'user_id' in the session to determine login state.
    """
    def __init__(self, get_response):
        self.get_response = get_response
        
        public_paths = getattr(settings, 'PUBLIC_PATHS', [])
        # For the home page '/', we leave it as '/'.
        # For other paths, we strip trailing slash for consistent comparison.
        self.allowed_paths = [
            path if path == '/' else path.rstrip('/')
            for path in public_paths
        ] + [
            reverse('login').rstrip('/'),
            reverse('signup').rstrip('/'),
            settings.STATIC_URL.rstrip('/'),
            settings.MEDIA_URL.rstrip('/')
        ]

    def __call__(self, request):
        # Convert current_path to '' if it's '/', or strip trailing slash otherwise.
        # That way '/' remains '/', while '/foo/' becomes '/foo'.
        current_path = request.path if request.path == '/' else request.path.rstrip('/')

        # Check if 'user_id' is in the session to decide if user is "logged in".
        is_custom_logged_in = bool(request.session.get('user_id'))

        # If not logged in, ensure the path is public; if not public, redirect home
        if not is_custom_logged_in:
            # If current_path is not in the allowed list or does not start with an allowed prefix
            if not any(
                current_path == path or current_path.startswith(path + '/')
                for path in self.allowed_paths
            ):
                return redirect("/?form_type=login")

        return self.get_response(request)

    
class EnsureUserIdMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Get the response first
        response = self.get_response(request)

        # Check if we have user_id in session and the user is authenticated
        user_id = request.session.get('user_id')
        if hasattr(request, 'user') and request.user.is_authenticated and user_id is None:
            try:
                if request.user.email:
                    user = UsersDB.objects.get(email=request.user.email)
                    request.session['user_id'] = user.id
                    request.session.save()
            except UsersDB.DoesNotExist:
                pass

        return response