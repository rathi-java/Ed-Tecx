from django.urls import path
from .views import *

urlpatterns = [
    # Reader Club blog list and detail
    path("readerclub/", blog_list, {"blog_type": "readerclub"}, name="readerclub_blog_list"),
    path("readerclub/<slug:slug>/", blog_detail, {"blog_type": "readerclub"}, name="readerclub_blog_detail"),

    # Career blog list and detail
    path("career/", blog_list, {"blog_type": "career"}, name="career_blog_list"),
    path("career/<slug:slug>/", blog_detail, {"blog_type": "career"}, name="career_blog_detail"),

    # Blog creation and management
    path("form/", form, name="form"),
    path("toggle_blog_status/<int:blog_id>/", toggle_blog_status, name="toggle_blog_status"),
    path("edit_blog/<int:blog_id>/", edit_blog, name="edit_blog"),
    path("delete_blog/<int:blog_id>/", delete_blog, name="delete_blog"),
]