from oauth.models import UsersDB
from django.conf import settings
from django.shortcuts import redirect
from django.urls import reverse

class LoginRequiredMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Ensure session ID is valid and user is logged in
        user_id = request.session.get('user_id')
        if not user_id:
            # Redirect to login if session is missing or expired
            if not any(request.path.startswith(path) for path in settings.PUBLIC_PATHS):
                return redirect('/login/?next=' + request.path)

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