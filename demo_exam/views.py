from django.shortcuts import render, redirect
from .models import *
import json
from django.db.models import Count
from django.contrib.auth.decorators import login_required

def manage_questions(request):
    if request.method == 'POST':  # If form is submitted
        category_id = request.POST.get('category')
        subject_id = request.POST.get('subject')
        question_text = request.POST.get('question_text')
        correct_answer = request.POST.get('correct_answer')
        
        answers = {}
        for letter in ['A', 'B', 'C', 'D']:
            option_text = request.POST.get(f'option_{letter}')
            if option_text:
                answers[f'option_{letter}'] = {
                    'text': option_text,
                    'is_correct': letter == correct_answer
                }
        
        DemoQuestion.objects.create(
            question_text=question_text,
            question_subject_id=subject_id,
            answers=answers
        )
        return redirect('manage_questions')
    
    categories = DemoCategory.objects.all()
    subjects = DemoSubject.objects.all()
    questions = DemoQuestion.objects.select_related('question_subject', 'question_subject__subject_category').all()
    
    return render(request, 'question_management.html', {
        'categories': categories,
        'subjects': subjects,
        'questions': questions
    })

def display_questions(request):
    category_id = request.GET.get('category')
    subject_id = request.GET.get('subject')
    
    questions = DemoQuestion.objects.select_related('question_subject', 'question_subject__subject_category')
    
    if category_id:
        questions = questions.filter(question_subject__subject_category_id=category_id)
    if subject_id:
        questions = questions.filter(question_subject_id=subject_id)
        
    categories = DemoCategory.objects.annotate(question_count=Count('subjects__questions'))
    subjects = DemoSubject.objects.annotate(question_count=Count('questions'))
    
    if category_id:
        subjects = subjects.filter(subject_category_id=category_id)
    
    context = {
        'questions': questions,
        'categories': categories,
        'subjects': subjects,
        'selected_category': int(category_id) if category_id else None,
        'selected_subject': int(subject_id) if subject_id else None,
    }
    
    return render(request, 'demo_questions_display.html', context)



