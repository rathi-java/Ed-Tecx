from oauth.models import UsersDB

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