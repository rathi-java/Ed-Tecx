from django.shortcuts import render, redirect
from .models import Category, Subject, Question, ExamResult

import json
from django.db.models import Count
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone

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
    category_id = request.GET.get('category')
    subject_id = request.GET.get('subject')
    
    questions = Question.objects.select_related('question_subject', 'question_subject__subject_category')
    
    if category_id:
        questions = questions.filter(question_subject__subject_category_id=category_id)
    if subject_id:
        questions = questions.filter(question_subject_id=subject_id)
        
    categories = Category.objects.annotate(question_count=Count('subjects__questions'))
    subjects = Subject.objects.annotate(question_count=Count('questions'))
    
    if category_id:
        subjects = subjects.filter(subject_category_id=category_id)
    
    # Store total number of exam questions in session
    request.session['exam_total_questions'] = questions.count()
    
    context = {
        'questions': questions,
        'categories': categories,
        'subjects': subjects,
        'selected_category': int(category_id) if category_id else None,
        'selected_subject': int(subject_id) if subject_id else None,
    }
    
    return render(request, 'questions_display.html', context)

# View to handle exam submission and calculate scorefrom django.shortcuts import render, redirect
from .models import Category, Subject, Question, ExamResult
import json
from django.db.models import Count
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone

# View to handle exam submission and calculate score
def submit_exam(request):
    if request.method == 'POST':
        user = request.user
        # Retrieve total number of exam questions from the session
        total_questions = request.session.get('exam_total_questions', 0)
        correct_answers = 0
        submitted_answers = {}

        # Process only the answered questions from POST data
        for key, selected_option in request.POST.items():
            if key.startswith('question'):
                try:
                    # Extract the question id from keys like "question5"
                    question_id = int(key.replace('question', ''))
                    question = Question.objects.get(id=question_id)
                except (ValueError, Question.DoesNotExist):
                    continue

                # Debug: print submitted answer and available options
                print(f"Question ID: {question_id}, Submitted: {selected_option}")
                print("Available options:", question.answers)

                # Determine the correct answer key
                correct_key = None
                for option_key, option_value in question.answers.items():
                    if option_value.get('is_correct'):
                        correct_key = option_key
                        break

                # Save the answer details (for review or certificate generation)
                submitted_answers[str(question_id)] = {
                    'selected': selected_option,
                    'correct': correct_key
                }

                # Count this question as correctly answered if it matches the correct option
                if selected_option == correct_key:
                    correct_answers += 1

        # Calculate score based on the total exam questions (not just the attempted ones)
        score = (correct_answers / total_questions) * 100 if total_questions > 0 else 0

        print(f"Total Questions: {total_questions}, Correct Answers: {correct_answers}, Score: {score}")

        # Save the exam result
        ExamResult.objects.create(
            user=user,
            total_questions=total_questions,
            correct_answers=correct_answers,
            score=score,
            submitted_answers=submitted_answers,
            submitted_at=timezone.now()
        )

        messages.success(request, f'Exam submitted successfully! Your score is {score:.2f}%')
        return redirect('exam_results')

    return render(request, 'examportol/submit_exam.html')


# View to display user exam results
def user_exam_results(request):
    # Get the latest exam result for the current user
    exam_result = ExamResult.objects.filter(user=request.user).order_by('-submitted_at').first()
    
    if exam_result:
        score = exam_result.score
        submitted_answers = exam_result.submitted_answers  # This is a dictionary
        results = []
        
        # Transform the submitted_answers dictionary into a list of dictionaries for the template.
        # Each key in submitted_answers is a question ID (as string) and its value is a dictionary.
        for qid, answer in submitted_answers.items():
            try:
                question = Question.objects.get(id=int(qid))
            except Question.DoesNotExist:
                continue

            # Determine if the answer was correct
            is_correct = answer.get('selected') == answer.get('correct')
            
            # Create a result dictionary for this question.
            result_item = {
                'question': question.question_text,
                'selected_answer': answer.get('selected'),
                'correct_answer': answer.get('correct'),
                'is_correct': is_correct,
            }
            results.append(result_item)
    else:
        score = 0
        results = []
        exam_result = None

    # Pass score, exam_result, and results list to the template.
    return render(request, 'exam_results.html', {
        'score': score,
        'exam_result': exam_result,
        'results': results,
    })

# View to render exam instructions
def instructions(request):
    return render(request, 'instructions/new.html')

# View to render terms and conditions page
def terms(request):
    return render(request, 'instructions/terms.html')

# View to render privacy policy page
def privacy(request):
    return render(request, 'instructions/Privacy.html')
def generate_certificate(request, exam_id):
    try:
        exam_result = ExamResult.objects.get(id=exam_id, user=request.user)
    except ExamResult.DoesNotExist:
        messages.error(request, "Exam result not found.")
        return redirect('exam_results')

    # Check if the score qualifies for a certificate (70% or above)
    if exam_result.score < 70:
        messages.error(request, "You are not eligible for a certificate as your score is below 70%.")
        return redirect('exam_results')

    # Render the certificate template with exam result details.
    return render(request, 'certificate.html', {'exam_result': exam_result})