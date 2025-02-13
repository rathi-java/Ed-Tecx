from django.urls import path
from . import views

urlpatterns = [
    path('', views.placement_stories, name='placement_stories'),
    path('story/<int:story_id>/', views.story_detail, name='story_detail'),
    path('story/edit/<int:story_id>/', views.edit_story, name='edit_story'),
    path('story/delete/<int:story_id>/', views.delete_story, name='delete_story'),
]
