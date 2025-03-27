from django.urls import path
from .views import *

urlpatterns = [
    path('', recruitment_portal, name='recruitment_portal'),
    path('jobs/', jobs_view, name='jobs_view'),
    path('internships/', internship_view, name='internship_view'),
    path('companies/', company_view, name='company_view'),
    path('recruitment-portol-signup/', recruitment_portol_signup, name='recruitment_portol_signup'),
    path('company/signup/', company_signup, name='company_signup'),

]
