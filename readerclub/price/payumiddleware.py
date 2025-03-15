# Now modify your middleware to check for this flag
# Create a new file like payumiddleware.py in your app directory

class PayUExemptMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Check if this request should bypass session checks
        if getattr(request, 'payu_exempt', False):
            # Skip authentication checks for this request
            pass
        
        response = self.get_response(request)
        return response
