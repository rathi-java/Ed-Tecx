# career/middleware.py

from django.conf import settings
from django.shortcuts import redirect
from django.urls import reverse
from oauth.models import UsersDB

class LoginRequiredMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

        public_paths = getattr(settings, 'PUBLIC_PATHS', [])
        restricted_subpaths = getattr(settings, 'RESTRICTED_SUBPATHS', [])
        
        self.allowed_paths = [
            path if path == '/' else path.rstrip('/')
            for path in public_paths
        ] + [
            reverse('login').rstrip('/'),
            reverse('signup').rstrip('/'),
            settings.STATIC_URL.rstrip('/'),
            settings.MEDIA_URL.rstrip('/'),
            '/accounts/google',
            '/accounts/github',
            '/accounts/social-auth',
            '/complete',
            '/home'
        ]
        
        self.restricted_subpaths = [
            path.rstrip('/') for path in restricted_subpaths
        ]

    def __call__(self, request):
        if request.path.startswith('/accounts/') or request.path.startswith('/social-auth/'):
            return self.get_response(request)

        current_path = request.path if request.path == '/' else request.path.rstrip('/')
        is_custom_logged_in = bool(request.session.get('user_id'))

        # Check if path is in restricted subpaths
        for restricted in self.restricted_subpaths:
            if current_path == restricted or current_path.startswith(restricted + '/'):
                if not is_custom_logged_in:
                    return redirect("/?form_type=login")

        if not is_custom_logged_in:
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
        response = self.get_response(request)
        user_id = request.session.get('user_id')
        
        # If using django.contrib.auth, request.user might be set by other methods (allauth, etc.)
        if hasattr(request, 'user') and request.user.is_authenticated and user_id is None:
            try:
                if request.user.email:
                    user, created = UsersDB.objects.get_or_create(
                        email=request.user.email,
                        defaults={
                            'username': request.user.username,
                            # Populate more fields if needed
                        }
                    )
                    request.session['user_id'] = user.id
                    request.session.save()
            except Exception as e:
                print(f"Error in EnsureUserIdMiddleware: {e}")
                pass
        return response
