"""
URL configuration for edtech_django project.

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
from django.urls import path
from authentications.views import *
from compiler.views import *
from exam_backend.views import *
from practice_questions.views import *

urlpatterns = [
    path('admin/', admin.site.urls),
    #compiler
    path('compile_code/', compile_code, name="compile_code"),
    #authentication
    path('register/', register_page, name='register'),
    path('login/', login_page, name='login'),
    path('home/', home, name='home'),
    path('logout/', logout_page, name='logout'),
    #test room
    path('add', addProfessor, name='add'),
    path('add_course/', addCourse, name='add_course'),
    path('add_difficulty/', addDifficulty, name='add_difficulty'),
    path('add_exam/', addExam, name='add_exam'),
    path('update_exam/<exam_code>/', updateExam, name='update_exam'),
    path('exam_list/', examList, name='exam_list'),
    path('edit_exam/<id>/', editExam, name='edit_exam'),
    path('start_exam/<exam_code>/', start_exam, name='start_exam'),
    #practice questions
    path('python_practice', python_practice, name='python_practice'),
    path('java_practice/', java_practice, name='java_practice'),
    path('cpp_practice/', cpp_practice, name='cpp_practice'),
]
