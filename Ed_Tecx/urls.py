"""
URL configuration for Ed_Tecx project.

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
from django.urls import path,include
from compiler.views import *
from oauth.views import *
from django.conf import settings
from django.conf.urls.static import static
from practice_question.views import demo_test
from price.views import price

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home, name='home'),
    path("accounts/", include("allauth.urls")),
    path('auth/',include('oauth.urls')),
    path('compiler/',include('compiler.urls')),
    path('examportol/',include('examportol.urls')),
    path('roadmap/',include('roadmap.urls')),
    path('placement_stories/',include('placement_stories.urls')),
    # path('demoexam/',include('demo_exam.urls')),
    path('practice_questions/',include('practice_question.urls')),
    path('exam_registration/',include('exam_registration.urls')),
    path('dashboard/',include('admin_portal.urls')),
    
    #Demo Test
    path('demo_test/', demo_test, name="demo_test"),
    path('certificate_management/',include('certificate_management.urls')),
    path('price/', price ,name="price"),
    

]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
