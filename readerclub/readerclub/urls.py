"""
URL configuration for readerclub project.

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
from price.views import *
from exam_registration.views import *
from admin_portal.views import adm_dashboard, mgr_dashboard, emp_dashboard
from .views import maintenance_view
from university import views as university_views
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
    path('practice-questions/',include('practice_question.urls')),
    path('exam-registration/',include('exam_registration.urls')),
    path('dashboard/',include('admin_portal.urls')),
    path('blog/',include('blog.urls')),
    
    #Demo Test
    path('demo-test/', demo_test, name="demo_test"),
    path('certificate-management/',include('certificate_management.urls')),
    path('price/', price ,name="price"),
    path('policies/',include('policies.urls')),

    # Payment gateway
    path('pay/',include('price.urls')),
    path("payu_success/", payu_success, name="payu_success"),
    path("payu_failure/", payu_failure, name="payu_failure"),
    path("payu_exam_success/", payu_exam_success, name="payu_exam_success"),
    path("payu_exam_failure/", payu_exam_failure, name="payu_exam_failure"),
    path('maintenence/', maintenance_view, name='maintenance_view'),
    path('adm_dashboard/', adm_dashboard, name='adm_dashboard'),
    path('mgr_dashboard/', mgr_dashboard, name='mgr_dashboard'),
    path('emp_dashboard/', emp_dashboard, name='emp_dashboard'),
    path('university/',include('university.urls')),
    path('upload_questions/<int:exam_id>/', university_views.upload_questions, name='upload_questions_direct'),


]
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
