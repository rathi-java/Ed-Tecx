from django.contrib import admin
from .models import Category, Subject, Question, ExamResult
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

class CategoryAdmin(admin.ModelAdmin):
    """
    Admin settings for the Category model.

    Attributes:
        list_display (tuple): Fields to display in the list view.
        search_fields (tuple): Fields available for searching.
    """
    list_display = ('category_code', 'category_name')
    search_fields = ('category_code', 'category_name')
    list_filter = ('category_name',)
    ordering = ('category_code',)

class SubjectAdmin(admin.ModelAdmin):
    """
    Admin settings for the Subject model.

    Attributes:
        list_display (tuple): Fields to display in the list view.
        search_fields (tuple): Fields available for searching.
        list_filter (tuple): Fields available for filtering.
    """
    list_display = ('subject_code', 'subject_name', 'subject_category')
    search_fields = ('subject_code', 'subject_name', 'subject_category__category_name')
    list_filter = ('subject_category',)
    ordering = ('subject_code',)

class QuestionAdmin(admin.ModelAdmin):
    """
    Admin settings for the Question model.

    Attributes:
        list_display (tuple): Fields to display in the list view.
        search_fields (tuple): Fields available for searching.
        list_filter (tuple): Fields available for filtering.
    """
    list_display = ('question_code', 'question_text', 'question_subject')
    search_fields = ('question_code', 'question_text', 'question_subject__subject_name')
    list_filter = ('question_subject',)
    ordering = ('question_code',)
    
    def formatted_answers(self, obj):
        """Display answers in a readable format."""
        return json.dumps(obj.answers, indent=4)
    
    formatted_answers.allow_tags = True
    formatted_answers.short_description = "Answers"

class ExamResultAdmin(admin.ModelAdmin):
    list_display = ('user', 'session_id', 'total_questions', 'correct_answers', 'score', 'submitted_at')
    search_fields = ('user__username', 'session_id')
    list_filter = ('submitted_at',)
    ordering = ('-submitted_at',)

admin.site.register(Category, CategoryAdmin)
admin.site.register(Subject, SubjectAdmin)
admin.site.register(Question, QuestionAdmin)
admin.site.register(ExamResult, ExamResultAdmin)