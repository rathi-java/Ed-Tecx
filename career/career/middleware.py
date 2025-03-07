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
            return redirect('http://127.0.0.1:8001' + request.path)
            
        return self.get_response(request)