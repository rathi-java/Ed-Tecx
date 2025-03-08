from django.conf import settings
from django.shortcuts import redirect
from django.urls import resolve

class CheckReaderclubSessionMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # List of URLs that don't require authentication
        public_urls = ['home', 'about_us', 'privacy_policy', 'terms_and_conditions', 'maintenance_view']
        
        current_url = resolve(request.path_info).url_name
        
        if not request.session.get('user_id') and current_url not in public_urls:
            # Update the redirect URL to use the existing domain
            return redirect('https://career.readerclub.in' + request.path)
            
        return self.get_response(request)