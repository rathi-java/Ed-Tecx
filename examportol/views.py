from django.shortcuts import render, redirect
from .models import *
from django.db.models import Count
from django.contrib import messages
from django.utils import timezone
from oauth.models import UsersDB
from exam_registration.models import StudentsDB

# View to manage questions (Add new questions and display existing ones)
from django.shortcuts import render, redirect
from .models import Category, Subject, Question
from django.http import JsonResponse

def manage_questions(request):
    if request.method == 'POST':
        # Check if a new category is added
        new_category_name = request.POST.get('new_category')
        new_subject_name = request.POST.get('new_subject')
        selected_category_id = request.POST.get('category')
        
        # Handle new category creation
        if new_category_name:
            category, created = Category.objects.get_or_create(category_name=new_category_name)
            selected_category_id = category.id  # Assign new category ID
        
        # Handle new subject creation under the selected category
        if new_subject_name and selected_category_id:
            subject, created = Subject.objects.get_or_create(
                subject_name=new_subject_name, 
                subject_category_id=selected_category_id
            )

        # Proceed with adding a question
        category_id = request.POST.get('category') or selected_category_id
        subject_id = request.POST.get('subject') or (subject.id if new_subject_name else None)
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

        # Create a new question entry
        if subject_id:
            Question.objects.create(
                question_text=question_text,
                question_subject_id=subject_id,
                answers=answers
            )

        return redirect('manage_questions')

    categories = Category.objects.all()
    subjects = Subject.objects.all()
    questions = Question.objects.select_related('question_subject', 'question_subject__subject_category').all()

    return render(request, 'question_management.html', {
        'categories': categories,
        'subjects': subjects,
        'questions': questions
    })

# View to display questions based on selected category and subject
def display_questions(request):
    # Retrieve subject ID from GET parameters
    subject_id = request.GET.get('subject')
    if not subject_id:
        messages.error(request, "No subject selected. Please select a subject first.")
        return redirect('exam_home')  # Or wherever you want to redirect

    # Retrieve the custom user from session
    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            request.session.flush()  # Clear session if user not found
            messages.error(request, "Session expired. Please login again.")
            return redirect('/login/')
    
    # Use the custom user object instead of request.user
    if not StudentsDB.objects.filter(email=user.email, subject_id=subject_id).exists():
        messages.error(request, "You are not registered for this exam subject. Please register first.")
        return redirect('exam_register')  # Redirect to your registration page

    # Fetch questions related to the subject.
    questions = Question.objects.select_related(
        'question_subject', 'question_subject__subject_category'
    ).filter(question_subject_id=subject_id)
    subject_obj = Subject.objects.get(id=subject_id)

    # Get categories and subjects with question counts for sidebar/navigation.
    categories = Category.objects.annotate(question_count=Count('subjects__questions'))
    subjects = Subject.objects.annotate(question_count=Count('questions'))
    if subject_id:
        subjects = subjects.filter(id=subject_id)

    # Store the total number of exam questions in session.
    request.session['exam_total_questions'] = questions.count()

    context = {
        'questions': questions,
        'categories': categories,
        'subjects': subjects,
        'subjectname':subject_obj,
        'selected_subject': int(subject_id),
        'user': user,  # Pass the custom user object here
    }

    return render(request, 'questions_display.html', context)


def submit_exam(request):
    if request.method == 'POST':
        # Retrieve custom user from session
        user_id = request.session.get('user_id')
        if not user_id:
            messages.error(request, "You must be logged in to submit the exam.")
            return redirect('/login/')
        try:
            custom_user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            messages.error(request, "User not found. Please log in again.")
            return redirect('/login/')
        
        # Retrieve total number of exam questions from session
        total_questions = request.session.get('exam_total_questions', 0)
        print("DEBUG: total_questions =", total_questions)
        
        correct_answers = 0
        submitted_answers = {}

        # Process each POST key that starts with "question"
        for key, selected_option in request.POST.items():
            if key.startswith('question'):
                try:
                    question_id = int(key.replace('question', ''))
                    question = Question.objects.get(id=question_id)
                except (ValueError, Question.DoesNotExist):
                    continue

                # Determine the correct answer key
                correct_key = None
                for option_key, option_value in question.answers.items():
                    if option_value.get('is_correct'):
                        correct_key = option_key
                        break

                submitted_answers[str(question_id)] = {
                    'selected': selected_option,
                    'correct': correct_key
                }
                if selected_option == correct_key:
                    correct_answers += 1

        print("DEBUG: correct_answers =", correct_answers)
        score = (correct_answers / total_questions) * 100 if total_questions > 0 else 0
        print("DEBUG: score =", score)
        print("DEBUG: submitted_answers =", submitted_answers)
        print("DEBUG: custom_user =", custom_user, "with id", custom_user.pk)

        try:
            exam_result = ExamResult.objects.create(
                user=custom_user,
                total_questions=total_questions,
                correct_answers=correct_answers,
                score=score,
                submitted_answers=submitted_answers,
                submitted_at=timezone.now()
            )
            print("DEBUG: ExamResult created:", exam_result)
        except Exception as e:
            print("DEBUG: Error saving exam result:", e)
            messages.error(request, f"Error saving exam result: {e}")
            return redirect('submit_exam')

        messages.success(request, f'Exam submitted successfully! Your score is {score:.2f}%')
        return redirect('exam_results')
    
    # For GET requests, redirect to exam home or another page.
    return redirect('exam_home')

# View to display user exam results
def user_exam_results(request):
    # Retrieve the custom user from session
    user_id = request.session.get('user_id')
    if user_id:
        try:
            custom_user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            messages.error(request, "User not found. Please log in again.")
            return redirect('/login/')
    else:
        messages.error(request, "You must be logged in to view your results.")
        return redirect('/login/')
    
    # Filter exam results for the custom user
    exam_result = ExamResult.objects.filter(user=custom_user).order_by('-submitted_at').first()
    
    if exam_result:
        score = exam_result.score
        submitted_answers = exam_result.submitted_answers or {}
        results = []
        for qid, answer in submitted_answers.items():
            try:
                question = Question.objects.get(id=int(qid))
            except Question.DoesNotExist:
                continue
            is_correct = answer.get('selected') == answer.get('correct')
            results.append({
                'question': question.question_text,
                'selected_answer': answer.get('selected'),
                'correct_answer': answer.get('correct'),
                'is_correct': is_correct,
            })
    else:
        score = 0
        results = []
        exam_result = None

    return render(request, 'exam_results.html', {
        'score': score,
        'exam_result': exam_result,
        'results': results,
    })


# View to render exam instructions
def instructions(request):
    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            request.session.flush()  # Clear session if user not found
            messages.error(request, "Session expired. Please login again.")
            return redirect('/login/')
    
    # Check if user is None before proceeding
    if user is None:
        messages.error(request, "You are not logged in. Please login first.")
        return redirect('/login/')

    subject_id = request.session.get('registered_subject')

    # Check if the subject_id is valid before querying StudentsDB
    if subject_id is None:
        messages.error(request, "No subject registered. Please register for a subject.")
        return redirect('exam_register')

    # Now you can safely access user.email and perform the query
    if not StudentsDB.objects.filter(email=user.email, subject_id=subject_id).exists():
        messages.error(request, "You are not registered for this exam subject. Please register first.")
        return redirect('exam_register')  # Redirect to your registration page

    return render(request, 'instructions/new.html', {'subject_id': subject_id})

# View to render terms and conditions page
def terms(request):
    return render(request, 'instructions/terms.html')

# View to render privacy policy page
def privacy(request):
    return render(request, 'instructions/Privacy.html')
