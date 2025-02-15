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

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home, name='home'),
    path('signup/', signup, name='signup'),
    path('login/', user_login, name='login'),
    path('logout/', logout_page, name='logout'),
    path('compiler/', compile_code, name='compile_code'),
    path('examportol/',include('examportol.urls')),
    path('placement_stories/',include('placement_stories.urls')),
    # path('demoexam/',include('demo_exam.urls')),
    path('practice_questions/',include('practice_question.urls')),
    path('exam_registration/',include('exam_registration.urls')),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
