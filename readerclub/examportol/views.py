from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.contrib import messages
from django.utils import timezone
from .models import *
from oauth.models import UsersDB
from exam_registration.models import StudentsDB
from examportol.forms import QuestionUploadForm
import csv
import random
from university.models import UniversityExam, UniversityQuestion, UniversityExamResult
def upload_questions(request):
    if request.method == 'POST':
        form = QuestionUploadForm(request.POST, request.FILES)
        if form.is_valid():
            category = form.cleaned_data['category']
            subject = form.cleaned_data['subject']
            file = request.FILES['file']

            # Check if file is CSV
            if not file.name.endswith('.csv'):
                messages.error(request, "Invalid file format! Please upload a CSV file.")
                return redirect('upload_questions')

            try:
                # Read CSV file with proper encoding handling
                decoded_file = file.read().decode('utf-8-sig').splitlines()
                reader = csv.DictReader(decoded_file)

                required_fields = ['Question', 'Correct Answer', 'Option A', 'Option B', 'Option C', 'Option D']
                missing_rows = []

                # Check if all required fields are present in the CSV header
                if not all(field in reader.fieldnames for field in required_fields):
                    missing_fields = [field for field in required_fields if field not in reader.fieldnames]
                    messages.error(request, f"CSV file is missing required fields: {missing_fields}")
                    return redirect('upload_questions')

                for index, row in enumerate(reader, start=1):
                    # Check for missing fields
                    missing_fields = [field for field in required_fields if not row.get(field, '').strip()]
                    if missing_fields:
                        missing_rows.append((index, missing_fields))
                        continue  # Skip this row

                    question_text = row['Question'].strip()
                    correct_answer = row['Correct Answer'].strip().upper()

                    if correct_answer not in ['A', 'B', 'C', 'D']:
                        messages.warning(request, f"Row {index}: Invalid correct answer '{correct_answer}', skipping.")
                        continue

                    answers = {}
                    for letter in ['A', 'B', 'C', 'D']:
                        option_text = row[f'Option {letter}'].strip()
                        answers[f'option_{letter}'] = {
                            'text': option_text,
                            'is_correct': letter == correct_answer
                        }

                    # Save Question
                    Question.objects.create(
                        question_text=question_text,
                        question_subject=subject,
                        answers=answers
                    )

                if missing_rows:
                    for row_index, fields in missing_rows:
                        messages.warning(request, f"Row {row_index}: Missing fields {fields}, skipping.")

                messages.success(request, "Questions uploaded successfully!")
                return redirect('upload_questions')

            except UnicodeDecodeError as e:
                messages.error(request, f"Error processing file: {e}. Please ensure the file is UTF-8 encoded.")
            except Exception as e:
                messages.error(request, f"Error processing file: {e}")

    else:
        form = QuestionUploadForm()

    return render(request, 'admin/upload_questions.html', {'form': form})
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

# def submit_exam(request):
#     if request.method == 'POST':
#         # Retrieve custom user from session
#         user_id = request.session.get('user_id')
#         if not user_id:
#             messages.error(request, "You must be logged in to submit the exam.")
#             return redirect('/login/')
#         try:
#             custom_user = UsersDB.objects.get(id=user_id)
#         except UsersDB.DoesNotExist:
#             messages.error(request, "User not found. Please log in again.")
#             return redirect('/login/')
        
#         # Retrieve total number of exam questions from session
#         total_questions = request.session.get('exam_total_questions', 0)
#         print("DEBUG: total_questions =", total_questions)
        
#         correct_answers = 0
#         submitted_answers = {}

#         # Process each POST key that starts with "question"
#         for key, selected_option in request.POST.items():
#             if key.startswith('question'):
#                 try:
#                     question_id = int(key.replace('question', ''))
#                     question = Question.objects.get(id=question_id)
#                 except (ValueError, Question.DoesNotExist):
#                     continue

#                 # Determine the correct answer key
#                 correct_key = None
#                 for option_key, option_value in question.answers.items():
#                     if option_value.get('is_correct'):
#                         correct_key = option_key
#                         break

#                 submitted_answers[str(question_id)] = {
#                     'selected': selected_option,
#                     'correct': correct_key
#                 }
#                 if selected_option == correct_key:
#                     correct_answers += 1

#         print("DEBUG: correct_answers =", correct_answers)
#         score = (correct_answers / total_questions) * 100 if total_questions > 0 else 0
#         print("DEBUG: score =", score)
#         print("DEBUG: submitted_answers =", submitted_answers)
#         print("DEBUG: custom_user =", custom_user, "with id", custom_user.pk)

#         try:
#             exam_result = ExamResult.objects.create(
#                 user=custom_user,
#                 total_questions=total_questions,
#                 correct_answers=correct_answers,
#                 score=score,
#                 submitted_answers=submitted_answers,
#                 submitted_at=timezone.now()
#             )
#             print("DEBUG: ExamResult created:", exam_result)
#         except Exception as e:
#             print("DEBUG: Error saving exam result:", e)
#             messages.error(request, f"Error saving exam result: {e}")
#             return redirect('submit_exam')

#         messages.success(request, f'Exam submitted successfully! Your score is {score:.2f}%')
#         return redirect('exam_results')
    
#     # For GET requests, redirect to exam home or another page.
#     return redirect('exam_home')

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
    # Retrieve user from session
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "You need to log in first.")
        return redirect('/login/')

    try:
        user = UsersDB.objects.get(id=user_id)
    except UsersDB.DoesNotExist:
        request.session.flush()
        messages.error(request, "Session expired. Please log in again.")
        return redirect('/login/')

    # Get the latest exam registration for this user
    registration = StudentsDB.objects.filter(user=user).order_by('-id').first()

    if not registration or not registration.exam_domain:
        messages.error(request, "You are not registered for any exam. Please register first.")
        return redirect('exam_register')

    # Extract the exam ID from the registration record
    exam_id = registration.exam_domain.id

    # Pass the exam ID to the instructions template.
    # In your template, you can then link to the take_exam view, for example:
    # <a href="{% url 'take_exam' exam_id %}" class="btn btn-primary">Start Exam</a>
    return render(request, 'instructions/new.html', {'exam_id': exam_id, 'user': user})

# View to render terms and conditions page
def terms(request):
    return render(request, 'instructions/terms.html')

# View to render privacy policy page
def privacy(request):
    return render(request, 'instructions/Privacy.html')
from django.shortcuts import render, redirect
from django.contrib import messages
from examportol.models import Category, Subject, Question, Exam
import random

def create_exam(request):
    # Fetch all categories and subjects (for filtering)
    categories = Category.objects.all()
    subjects = Subject.objects.all()
    
    # Initialize filter variables and get all questions by default
    selected_category_ids = []
    selected_subject_ids = []
    questions = Question.objects.all()
    
    # Retrieve previously selected question IDs from GET parameters
    # (These come in as strings; convert them to integers later if needed)
    selected_question_ids = request.GET.getlist('questions')
    
    if request.method == 'POST':
        # Handle form submission to create an exam
        name = request.POST.get('name')
        duration = request.POST.get('duration')
        question_ids = request.POST.getlist('questions')
        
        if not name or not duration or not question_ids:
            messages.error(request, "Please fill all required fields")
            return redirect('create_exam')
        
        # Create the exam instance
        exam = Exam.objects.create(
            name=name,
            duration=duration
        )
        
        # Add selected questions (which can come from multiple subjects/categories)
        for q_id in question_ids:
            try:
                question = Question.objects.get(id=q_id)
                exam.questions.add(question)
            except Question.DoesNotExist:
                continue
        
        messages.success(request, f"Exam '{name}' created successfully!")
        return redirect('list_exams')
    else:
        # For GET requests, use multi-select filtering
        if 'categories' in request.GET:
            selected_category_ids = request.GET.getlist('categories')
        if 'subjects' in request.GET:
            selected_subject_ids = request.GET.getlist('subjects')
        
        # Filter questions based on selected categories
        if selected_category_ids:
            questions = questions.filter(
                question_subject__subject_category_id__in=selected_category_ids
            )
            # Also update the subjects list to only those within the selected categories
            subjects = Subject.objects.filter(
                subject_category_id__in=selected_category_ids
            )
        # Further filter questions by selected subjects
        if selected_subject_ids:
            questions = questions.filter(
                question_subject_id__in=selected_subject_ids
            )
        
        # Now, if there are previously selected questions that might not be in the filtered queryset,
        # fetch them and union them with the current questions.
        if selected_question_ids:
            # Get questions that were selected (even if not matching the current filter)
            extra_questions = Question.objects.filter(id__in=selected_question_ids)
            # Combine: use a set to avoid duplicates
            questions_set = {q.id: q for q in questions}
            for q in extra_questions:
                if q.id not in questions_set:
                    questions_set[q.id] = q
            # Convert back to a list; you may sort this list as needed
            questions = list(questions_set.values())
    
    context = {
        'categories': categories,
        'subjects': subjects,
        'questions': questions,
        'selected_category_ids': selected_category_ids,
        'selected_subject_ids': selected_subject_ids,
        'selected_question_ids': selected_question_ids,
    }
    
    return render(request, 'create_exam.html', context)

def list_exams(request):
    # Retrieve the custom user from session
    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            request.session.flush()
            messages.error(request, "Session expired. Please login again.")
            return redirect('/login/')
    
    # If the user is registered (via exam_domain) then show only those exams
    if user and StudentsDB.objects.filter(email=user.email, exam_domain__isnull=False).exists():
        registered_exam_ids = StudentsDB.objects.filter(email=user.email, exam_domain__isnull=False).values_list('exam_domain_id', flat=True)
        exams = Exam.objects.filter(id__in=registered_exam_ids).distinct()
    else:
        exams = Exam.objects.all()
    
    return render(request, 'list_exams.html', {
        'exams': exams,
        'user': user,
    })
# from django.utils.timezone import make_aware
# from datetime import datetime

def take_exam(request, exam_id):
    # Retrieve the custom user from session
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "You must be logged in to take an exam.")
        return redirect('/login/')
    
    try:
        user = UsersDB.objects.get(id=user_id)
    except UsersDB.DoesNotExist:
        request.session.flush()
        messages.error(request, "Session expired. Please login again.")
        return redirect('/login/')

    # Get the exam (which may include questions from multiple subjects)
    try:
        exam = Exam.objects.get(id=exam_id)
    except Exam.DoesNotExist:
        messages.error(request, "Exam not found.")
        return redirect('list_exams')

    # Check if the user is registered for this exam via StudentsDB (registration is now exam-based)
    try:
        registration = StudentsDB.objects.get(user=user, exam_domain=exam)
    except StudentsDB.DoesNotExist:
        messages.error(request, "You are not registered for this exam. Please register first.")
        return redirect('exam_register')

    # Ensure exam start_time and end_time are timezone-aware
    exam.start_time = make_aware(exam.start_time)
    exam.end_time = make_aware(exam.end_time)

    # More robust randomization logic
    exam_session_key = f'exam_questions_order_{exam_id}'
    exam_questions_order = request.session.get(exam_session_key)

    if exam_questions_order is None:
        # Fetch all exam questions
        questions = list(exam.questions.all())
        
        # Use a seeded random generator based on user ID for consistent but randomized order
        random.seed(user.id + exam.id)
        random.shuffle(questions)
        
        # Reset the random seed to maintain Python's default behavior
        random.seed()
        
        # Save the order (list of question IDs) in session
        exam_questions_order = [q.id for q in questions]
        request.session[exam_session_key] = exam_questions_order
    else:
        # Retrieve questions in the previously stored order
        question_ids = exam_questions_order
        questions_queryset = exam.questions.filter(id__in=question_ids)
        
        # Create a mapping to enforce the saved order
        questions_dict = {q.id: q for q in questions_queryset}
        questions = [questions_dict[qid] for qid in question_ids if qid in questions_dict]

    # Dynamically fetch subjects and options for the questions
    subjects = {q.question_subject.subject_name for q in questions}
    dynamic_questions = [
        {
            'id': question.id,
            'text': question.question_text,
            'subject': question.question_subject.subject_name,
            'options': [
                {'key': key, 'text': value['text']}
                for key, value in question.answers.items()
            ]
        }
        for question in questions
    ]

    # Store exam details in session
    request.session['exam_total_questions'] = len(questions)
    request.session['exam_id'] = exam.id
    request.session['exam_duration'] = exam.duration

    context = {
        'exam': exam,
        'subjects': list(subjects),
        'questions': dynamic_questions,
        'user': user,
        'exam_type': 'examportol',  # Explicitly set the exam type for ExamPortol
    }
    return render(request, 'questions_display.html', context)

def submit_custom_exam(request):
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
        
        # Retrieve exam information from session
        exam_id = request.session.get('exam_id')
        total_questions = request.session.get('exam_total_questions', 0)
        
        try:
            exam = UniversityExam.objects.get(id=exam_id)
        except UniversityExam.DoesNotExist:
            messages.error(request, "Exam not found.")
            return redirect('list_exams')
        
        # Debugging: Log exam and user details
        print(f"DEBUG: Exam ID: {exam_id}, User: {custom_user.full_name}, Total Questions: {total_questions}")

        correct_answers = 0
        submitted_answers = {}

        # Process each POST key that starts with "question"
        for key, selected_option in request.POST.items():
            if key.startswith('question'):
                try:
                    question_id = int(key.replace('question', ''))
                    question = UniversityQuestion.objects.get(id=question_id)
                except (ValueError, UniversityQuestion.DoesNotExist):
                    print(f"DEBUG: Invalid question ID: {key}")
                    continue

                # Determine the correct answer key
                correct_key = None
                for option_key, option_value in question.answers.items():
                    if option_value.get('is_correct'):
                        correct_key = option_key[-1]  # Extract the last character (e.g., "option_B" → "B")
                        break

                submitted_answers[str(question_id)] = {
                    'selected': selected_option,
                    'correct': correct_key
                }
                if selected_option == correct_key:
                    correct_answers += 1

        # Debugging: Log submitted answers and correct answers
        print(f"DEBUG: Submitted Answers: {submitted_answers}")
        print(f"DEBUG: Correct Answers: {correct_answers}")

        score = (correct_answers / total_questions) * 100 if total_questions > 0 else 0

        try:
            # Save the exam result
            exam_result = UniversityExamResult.objects.create(
                exam=exam,
                student_name=custom_user.full_name,
                total_questions=total_questions,
                correct_answers=correct_answers,
                score=score,
                submitted_answers=submitted_answers,
                submitted_at=timezone.now()
            )
            # Debugging: Log successful result creation
            print(f"DEBUG: Exam Result Created: {exam_result}")
        except Exception as e:
            print(f"DEBUG: Error saving exam result: {e}")
            messages.error(request, f"Error saving exam result: {e}")
            return redirect('list_exams')

        messages.success(request, f'Exam submitted successfully! Your score is {score:.2f}%')
        return redirect('exam_results', exam_id=exam.id)
    
    # For GET requests, redirect to exam list
    return redirect('list_exams')

# from django.shortcuts import render, redirect
# from django.contrib import messages
# from .models import Exam

def manage_exams(request):
    if request.method == 'POST':
        # Handle exam deletion or updates
        exam_id = request.POST.get('exam_id')
        action = request.POST.get('action')
        
        try:
            exam = Exam.objects.get(id=exam_id)
            if action == 'delete':
                exam.delete()
                messages.success(request, "Exam deleted successfully!")
            elif action == 'update':
                # Update logic
                pass
        except Exam.DoesNotExist:
            messages.error(request, "Exam not found.")
    
    exams = Exam.objects.all()
    return render(request, 'manage_exams.html', {'exams': exams})

def get_questions_by_subject(request):
    subject_id = request.GET.get('subject_id')
    questions = Question.objects.filter(question_subject_id=subject_id).values('id', 'question_text')
    return JsonResponse(list(questions), safe=False)
