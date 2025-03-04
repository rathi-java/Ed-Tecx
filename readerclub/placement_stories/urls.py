from django.urls import path
from . import views

urlpatterns = [
    path('', views.placement_stories, name='placement_stories'),
    path('story/<int:story_id>/', views.story_detail, name='story_detail'),

]
