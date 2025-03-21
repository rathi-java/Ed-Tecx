"""
URL configuration for career project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from job_portal.views import *
from .views import maintenance_view
from django.conf import settings
from django.conf.urls.static import static
from job_portal.views import autocomplete
urlpatterns = [
    path('admin/', admin.site.urls),
    path('job-portal/', include('job_portal.urls')),
    path('internship-portal/', include('internship_portal.urls')),
    path('abroad-studies/', include('abroad_studies.urls')),
    path('', home, name='home'),
    path('home/', home, name='home'),   
    path('maintenence/', maintenance_view, name='maintenance_view'),
    path('policies/',include('policies.urls')),
    path('auth/',include('oauth.urls')),
    path('accounts/', include('allauth.urls')),  # <-- Add this line
    path('autocomplete/', autocomplete, name='autocomplete'),
    path('oauth/', include('oauth.urls')),
    path('recruitment-portal/', include('recruitment_portal.urls')),
    path('freelancing-portal/', include('freelancing_portal.urls')),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)