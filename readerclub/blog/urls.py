from django.urls import path
from . import views

urlpatterns = [
    # Reader Club blog list and detail
    path("readerclub/", views.blog_list, {"blog_type": "readerclub"}, name="readerclub_blog_list"),
    path("readerclub/<slug:slug>/", views.blog_detail, {"blog_type": "readerclub"}, name="readerclub_blog_detail"),

    # Career blog list and detail
    path("career/", views.blog_list, {"blog_type": "career"}, name="career_blog_list"),
    path("career/<slug:slug>/", views.blog_detail, {"blog_type": "career"}, name="career_blog_detail"),

    # Blog creation and management
    path("form/", views.form, name="form"),
    path("toggle_blog_status/<int:blog_id>/", views.toggle_blog_status, name="toggle_blog_status"),
    path("edit_blog/<int:blog_id>/", views.edit_blog, name="edit_blog"),
    path("delete_blog/<int:blog_id>/", views.delete_blog, name="delete_blog"),
]
