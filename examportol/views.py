from django.shortcuts import render, redirect
from .models import Category, Subject, Question, ExamResult
import json
from django.db.models import Count
from django.contrib.auth.decorators import login_required

# View to manage questions (Add new questions and display existing ones)
def manage_questions(request):
    if request.method == 'POST':  # If form is submitted
        category_id = request.POST.get('category')  # Get category ID from form
        subject_id = request.POST.get('subject')  # Get subject ID from form
        question_text = request.POST.get('question_text')  # Get question text
        correct_answer = request.POST.get('correct_answer')  # Get correct answer option
        
        answers = {}  # Dictionary to store answer options
        for letter in ['A', 'B', 'C', 'D']:  # Iterate over answer choices
            option_text = request.POST.get(f'option_{letter}')  # Get option text
            if option_text:
                answers[f'option_{letter}'] = {
                    'text': option_text,  # Store option text
                    'is_correct': letter == correct_answer  # Mark correct option
                }
        
        # Create a new question entry in the database
        Question.objects.create(
            question_text=question_text,
            question_subject_id=subject_id,
            answers=answers
        )
        return redirect('manage_questions')  # Redirect to manage questions page
    
    categories = Category.objects.all()  # Get all categories
    subjects = Subject.objects.all()  # Get all subjects
    questions = Question.objects.select_related('question_subject', 'question_subject__subject_category').all()  # Get all questions
    
    return render(request, 'question_management.html', {
        'categories': categories,
        'subjects': subjects,
        'questions': questions
    })

# View to display questions based on selected category and subject
def display_questions(request):
    category_id = request.GET.get('category')  # Get category filter from request
    subject_id = request.GET.get('subject')  # Get subject filter from request
    
    questions = Question.objects.select_related('question_subject', 'question_subject__subject_category')  # Query all questions
    
    if category_id:  # If category filter is applied
        questions = questions.filter(question_subject__subject_category_id=category_id)
    if subject_id:  # If subject filter is applied
        questions = questions.filter(question_subject_id=subject_id)
        
    categories = Category.objects.annotate(question_count=Count('subjects__questions'))  # Count questions per category
    subjects = Subject.objects.annotate(question_count=Count('questions'))  # Count questions per subject
    
    if category_id:
        subjects = subjects.filter(subject_category_id=category_id)  # Filter subjects by category
    
    context = {
        'questions': questions,
        'categories': categories,
        'subjects': subjects,
        'selected_category': int(category_id) if category_id else None,
        'selected_subject': int(subject_id) if subject_id else None,
    }
    
    return render(request, 'questions_display.html', context)  # Render questions display page

# View to handle exam submission and calculate score
def submit_exam(request):
    if request.method == 'POST':  # If exam is submitted
        submitted_answers = request.POST  # Get submitted answers
        correct_answers = 0  # Counter for correct answers
        results = []  # Store individual question results

        total_questions = Question.objects.count()  # Get total number of questions in the exam

        for key, value in submitted_answers.items():  # Iterate through submitted answers
            if key.startswith("question"):  # Identify question keys
                question_id = key.replace("question", "")  # Extract question ID
                question = Question.objects.get(id=question_id)  # Fetch question from DB
                selected_option = value  # Get selected answer option

                answers = question.answers  # Get answer choices from question
                correct_option = None

                for option_key, option_data in answers.items():  # Find correct answer
                    if option_data['is_correct']:
                        correct_option = option_key

                is_correct = selected_option == correct_option  # Check if selected answer is correct
                if is_correct:
                    correct_answers += 1  # Increment correct answer count

                results.append({  # Store question result details
                    "question": question.question_text,
                    "selected_answer": answers.get(selected_option, {}).get("text", "Unknown"),
                    "correct_answer": answers[correct_option]["text"] if correct_option else "Not found",
                    "is_correct": is_correct,
                })

        score = (correct_answers / total_questions) * 100 if total_questions > 0 else 0  # Calculate percentage score

        # Save exam result in database
        ExamResult.objects.create(
            score=score,
            total_questions=total_questions,
            correct_answers=correct_answers,
            submitted_answers=results,
        )

        return render(request, 'exam_results.html', {
            'results': results,
            'score': score
        })  # Render exam results page
    return redirect('display_questions')  # Redirect to display questions page if not POST

# View to display user exam results
def user_exam_results(request):
    results = ExamResult.objects.order_by('-submitted_at')  # Get all exam results sorted by submission date
    return render(request, 'user_results.html', {'results': results})  # Render user results page

# View to render exam instructions
def instructions(request):
    return render(request, 'instructions/new.html')

# View to render terms and conditions page
def terms(request):
    return render(request, 'instructions/terms.html')

# View to render privacy policy page
def privacy(request):
    return render(request, 'instructions/Privacy.html')

