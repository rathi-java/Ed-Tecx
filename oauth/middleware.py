class EnsureUserIdMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        try:
            # Get the response first
            response = self.get_response(request)
            
            # Check if we have user_id in session
            user_id = request.session.get('user_id')
            
            # If user is authenticated but no user_id in session
            if hasattr(request, 'user') and user_id is None:
                try:
                    # Try to get user by email or google_id
                    if hasattr(request, 'user') and request.user.email:
                        user = UsersDB.objects.get(email=request.user.email)
                        request.session['user_id'] = user.id
                        request.session.save()
                except UsersDB.DoesNotExist:
                    pass
                
            return response
            
        except Exception as e:
            return self.get_response(request)