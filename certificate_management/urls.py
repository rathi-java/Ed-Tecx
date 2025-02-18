from django.urls import path
from .views import *

urlpatterns = [
    path('profile/', profile_view, name='cerificate_profile'),
    path('certificate/view/<int:certificate_id>/', view_certificate, name='view_certificate'),
    path('certificate/download/<int:certificate_id>/', download_certificate, name='download_certificate'),
    path('certificate-requests/', certificate_requests_view, name='certificate_requests_view'),
    path('update-certificate-status/<int:certificate_id>/', update_certificate_status, name='update_certificate_status'),
    path('bulk-update-status/',bulk_update_status, name='bulk_update_status'),
    path('delete-certificate/<int:certificate_id>/',delete_certificate, name='delete_certificate'),
    
]
