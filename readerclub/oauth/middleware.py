from oauth.models import UsersDB
from django.conf import settings
from django.shortcuts import redirect
from django.urls import reverse

class LoginRequiredMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        
        public_paths = getattr(settings, 'PUBLIC_PATHS', [])
        restricted_subpaths = getattr(settings, 'RESTRICTED_SUBPATHS', [])
        
        self.allowed_paths = [
            path if path == '/' else path.rstrip('/')
            for path in public_paths
        ] + [
            '/login',
            '/signup',
            settings.STATIC_URL.rstrip('/'),
            settings.MEDIA_URL.rstrip('/'),
            '/accounts/google',
            '/accounts/github',
            '/accounts/social-auth',
            '/complete',
            '/admin',
        ]
        
        self.restricted_subpaths = [
            path.rstrip('/') for path in restricted_subpaths
        ]

    def __call__(self, request):
        # Skip middleware logic for authentication-related paths
        auth_paths = ['/auth/login/', '/auth/', '/login/']
        if any(request.path.startswith(path) for path in auth_paths):
            return self.get_response(request)

        # Existing path checking logic
        if request.path.startswith('/accounts/') or request.path.startswith('/social-auth/'):
            return self.get_response(request)

        current_path = request.path if request.path == '/' else request.path.rstrip('/')
        is_custom_logged_in = bool(request.session.get('user_id'))

        # Debug check - log the session data
        if request.session.get('user_id'):
            print(f"User ID in session: {request.session.get('user_id')}")
        
        # If user is already logged in, don't redirect to login
        if is_custom_logged_in:
            return self.get_response(request)
            
        # Check if path is in restricted subpaths for unauthenticated users
        for restricted in self.restricted_subpaths:
            if current_path == restricted or current_path.startswith(restricted + '/'):
                if not is_custom_logged_in:
                    return redirect("/?form_type=login")

        # Only redirect unauthenticated users away from protected paths
        if not is_custom_logged_in:
            if not any(
                current_path == path or current_path.startswith(path + '/')
                for path in self.allowed_paths
            ):
                return redirect("/?form_type=login")
                
        # Ensure session is not flushed unless explicitly logged out
        if not request.session.session_key:
            request.session.create()

        return self.get_response(request)

class EnsureUserIdMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)

        user_id = request.session.get('user_id')
        if hasattr(request, 'user') and request.user.is_authenticated and user_id is None:
            try:
                if request.user.email:
                    user, created = UsersDB.objects.get_or_create(
                        email=request.user.email,
                        defaults={
                            'username': request.user.username,
                            # Add any other fields you need for new users
                        }
                    )
                    request.session['user_id'] = user.id
                    request.session.save()
            except Exception as e:
                # Log the error for debugging
                print(f"Error in EnsureUserIdMiddleware: {e}")
                pass

        return response