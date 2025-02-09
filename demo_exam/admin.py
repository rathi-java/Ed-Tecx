from django.contrib import admin
from .models import *
import json

"""
Django Admin Configuration for the Models

This module registers the models Category, Subject, and Question with the Django Admin site
and customizes their display and search capabilities.

Classes:
    CategoryAdmin -- Admin configuration for the Category model.
    SubjectAdmin -- Admin configuration for the Subject model.
    QuestionAdmin -- Admin configuration for the Question model.
"""

@admin.register(DemoCategory)
class CategoryAdmin(admin.ModelAdmin):
    """
    Admin settings for the Category model.

    Attributes:
        list_display (tuple): Fields to display in the list view.
        search_fields (tuple): Fields available for searching.
    """
    list_display = ('category_code', 'category_name')
    search_fields = ('category_code', 'category_name')

@admin.register(DemoSubject)
class SubjectAdmin(admin.ModelAdmin):
    """
    Admin settings for the Subject model.

    Attributes:
        list_display (tuple): Fields to display in the list view.
        search_fields (tuple): Fields available for searching.
        list_filter (tuple): Fields available for filtering.
    """
    list_display = ('subject_code', 'subject_name', 'subject_category')
    search_fields = ('subject_code', 'subject_name')
    list_filter = ('subject_category',)

@admin.register(DemoQuestion)
class QuestionAdmin(admin.ModelAdmin):
    """
    Admin settings for the Question model.

    Attributes:
        list_display (tuple): Fields to display in the list view.
        search_fields (tuple): Fields available for searching.
        list_filter (tuple): Fields available for filtering.
    """
    list_display = ('question_code', 'question_text', 'question_subject')
    search_fields = ('question_code', 'question_text')
    list_filter = ('question_subject',)
    
