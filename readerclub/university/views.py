from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse, HttpResponse
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from django.utils import timezone
from django.db.models import Count, Sum
import json
import csv
import io
import random
from datetime import timedelta
import traceback
from django.urls import reverse
import qrcode
import base64
import uuid  # Added missing import


from .models import (
    University, 
    UniversityProfessor, 
    UniversityCourse, 
    UniversityExamDifficulty,
    UniversityExam,
    UniversityQuestion,
    UniversityExamResult,
    ExamLink,
)

def university(request):
    """Main university view with statistics"""
    # Get the university associated with the current user
    # For simplicity, we'll assume there's only one university for now
    university = University.objects.first()
    
    # Get real counts or generate dummy data if needed
    exam_results = UniversityExamResult.objects.all()
    total_students = exam_results.values('student_name').distinct().count()
    
    # For demonstration - in real app you would have status fields
    stats = {
        'total_students': total_students or 543,  # Fallback to dummy data
        'approved_students': int(total_students * 0.8) if total_students else 428,
        'rejected_students': int(total_students * 0.1) if total_students else 54,
        'pending_students': int(total_students * 0.1) if total_students else 61,
    }
    
    context = {
        'stats': stats,
        'university': university,
        'active_page': 'university'
    }
    return render(request, 'university.html', context)

def referral_code(request):
    """Display university referral code"""
    university = University.objects.first()
    
    # Generate a referral code if it doesn't exist
    if not university:
        university = University.objects.create(
            university_name="SGT University",
            university_location="Gurgaon, Haryana"
        )
    
    context = {
        'referral_code': university.university_code,
        'university': university,
        'active_page': 'referral'
    }
    return render(request, 'university.html', context)

def registered_students(request):
    """List registered students"""
    university = University.objects.first()
    
    # Get real students or generate dummy data
    exam_results = UniversityExamResult.objects.all()
    unique_students = exam_results.values('student_name').distinct()
    
    # If no students, create dummy data
    if not unique_students:
        student_list = [
            {
                'id': 1,
                'name': 'John Smith',
                'email': 'john.smith@example.com',
                'phone': '9876543210',
                'college': 'Engineering College',
                'referral_code': university.university_code if university else 'username100FF',
                'status': 'Pending'
            },
            {
                'id': 2,
                'name': 'Jane Doe',
                'email': 'jane.doe@example.com',
                'phone': '9876543211',
                'college': 'Medical College',
                'referral_code': university.university_code if university else 'username100FF',
                'status': 'Approved'
            },
            {
                'id': 3,
                'name': 'Robert Johnson',
                'email': 'robert.johnson@example.com',
                'phone': '9876543212',
                'college': 'Business School',
                'referral_code': university.university_code if university else 'username100FF',
                'status': 'Rejected'
            }
        ]
    else:
        # Process real student data
        student_list = []
        statuses = ["Pending", "Approved", "Rejected"]
        
        for i, student in enumerate(unique_students):
            student_list.append({
                'id': i + 1,
                'name': student['student_name'],
                'email': f"{student['student_name'].lower().replace(' ', '')}@example.com",
                'phone': f"98765{i}3210",
                'college': f"College {i+1}",
                'referral_code': university.university_code if university else 'username100FF',
                'status': statuses[i % 3]  # Cycle through statuses
            })
    
    context = {
        'students': student_list,
        'university': university,
        'active_page': 'students'
    }
    return render(request, 'university.html', context)

def professor_list(request):
    """Display list of professors"""
    university = University.objects.first()
    professors = UniversityProfessor.objects.filter(university=university) if university else []
    
    context = {
        'professors': professors,
        'university': university,
        'active_page': 'professors'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def add_professor(request):
    """Add a new professor"""
    university = University.objects.first()
    
    if request.method == 'POST':
        name = request.POST.get('professor_name')
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        if name and email and password:
            try:
                professor = UniversityProfessor.objects.create(
                    university=university,
                    name=name,
                    email=email,
                    password=password  # In a real app, hash this password
                )
                messages.success(request, f"Professor {name} added successfully!")
            except Exception as e:
                messages.error(request, f"Error adding professor: {str(e)}")
        else:
            messages.error(request, "All fields are required.")
        
        return redirect('professor_list')
    
    context = {
        'university': university,
        'active_page': 'add_professor'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def edit_professor(request, professor_id):
    """Edit an existing professor"""
    professor = get_object_or_404(UniversityProfessor, id=professor_id)
    
    if request.method == 'POST':
        name = request.POST.get('professor_name')
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        if name and email:
            professor.name = name
            professor.email = email
            if password:  # Only update password if provided
                professor.password = password  # Hash in real app
            
            professor.save()
            messages.success(request, f"Professor {name} updated successfully!")
        else:
            messages.error(request, "Name and email are required.")
        
        return redirect('professor_list')
    
    # Return JSON for AJAX requests
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return JsonResponse({
            'id': professor.id,
            'name': professor.name,
            'email': professor.email
        })
    
    context = {
        'professor': professor,
        'university': professor.university,
        'active_page': 'edit_professor'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def delete_professor(request, professor_id):
    """Delete a professor"""
    professor = get_object_or_404(UniversityProfessor, id=professor_id)
    
    if request.method == 'POST':
        name = professor.name
        professor.delete()
        messages.success(request, f"Professor {name} deleted successfully!")
    
    # If AJAX request, return JSON response
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return JsonResponse({'status': 'success'})
    
    return redirect('professor_list')

def course_list(request):
    """Display list of courses"""
    university = University.objects.first()
    courses = UniversityCourse.objects.filter(university=university) if university else []
    
    context = {
        'courses': courses,
        'university': university,
        'active_page': 'courses'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def add_course(request):
    """Add a new course"""
    university = University.objects.first()
    
    if request.method == 'POST':
        name = request.POST.get('course_name')
        
        if name:
            try:
                course = UniversityCourse.objects.create(
                    university=university,
                    name=name
                )
                messages.success(request, f"Course {name} added successfully!")
            except Exception as e:
                messages.error(request, f"Error adding course: {str(e)}")
        else:
            messages.error(request, "Course name is required.")
        
        return redirect('course_list')
    
    context = {
        'university': university,
        'active_page': 'add_course'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def edit_course(request, course_id):
    """Edit an existing course"""
    course = get_object_or_404(UniversityCourse, id=course_id)
    
    if request.method == 'POST':
        name = request.POST.get('course_name')
        
        if name:
            course.name = name
            course.save()
            messages.success(request, f"Course {name} updated successfully!")
        else:
            messages.error(request, "Course name is required.")
        
        return redirect('course_list')
    
    # Return JSON for AJAX requests
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return JsonResponse({
            'id': course.id,
            'name': course.name
        })
    
    context = {
        'course': course,
        'university': course.university,
        'active_page': 'edit_course'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def delete_course(request, course_id):
    """Delete a course"""
    course = get_object_or_404(UniversityCourse, id=course_id)
    
    if request.method == 'POST':
        name = course.name
        course.delete()
        messages.success(request, f"Course {name} deleted successfully!")
    
    # If AJAX request, return JSON response
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return JsonResponse({'status': 'success'})
    
    return redirect('course_list')

def difficulty_list(request):
    """Display list of difficulty levels"""
    university = University.objects.first()
    difficulties = UniversityExamDifficulty.objects.filter(university=university) if university else []
    
    context = {
        'difficulties': difficulties,
        'university': university,
        'active_page': 'difficulty'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def add_difficulty(request):
    """Add a new difficulty level"""
    university = University.objects.first()
    
    if request.method == 'POST':
        name = request.POST.get('difficulty_name')
        
        if name:
            try:
                difficulty = UniversityExamDifficulty.objects.create(
                    university=university,
                    difficulty_name=name
                )
                
                if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                    return JsonResponse({
                        'status': 'success',
                        'id': difficulty.id,
                        'name': difficulty.difficulty_name
                    })
                
                messages.success(request, f"Difficulty {name} added successfully!")
            except Exception as e:
                if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                    return JsonResponse({
                        'status': 'error',
                        'message': str(e)
                    })
                messages.error(request, f"Error adding difficulty: {str(e)}")
        else:
            if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                return JsonResponse({
                    'status': 'error',
                    'message': 'Difficulty name is required.'
                })
            messages.error(request, "Difficulty name is required.")
        
        return redirect('difficulty_list')
    
    context = {
        'university': university,
        'active_page': 'add_difficulty'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def edit_difficulty(request, difficulty_id):
    """Edit an existing difficulty level"""
    difficulty = get_object_or_404(UniversityExamDifficulty, id=difficulty_id)
    
    if request.method == 'POST':
        name = request.POST.get('difficulty_name')
        
        if name:
            difficulty.difficulty_name = name
            difficulty.save()
            
            if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                return JsonResponse({
                    'status': 'success',
                    'id': difficulty.id,
                    'name': difficulty.difficulty_name
                })
            
            messages.success(request, f"Difficulty {name} updated successfully!")
        else:
            if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                return JsonResponse({
                    'status': 'error',
                    'message': 'Difficulty name is required.'
                })
            
            messages.error(request, "Difficulty name is required.")
        
        if not request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return redirect('difficulty_list')
    
    # Return JSON for AJAX requests
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return JsonResponse({
            'id': difficulty.id,
            'name': difficulty.difficulty_name
        })
    
    context = {
        'difficulty': difficulty,
        'university': difficulty.university,
        'active_page': 'edit_difficulty'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def delete_difficulty(request, difficulty_id):
    """Delete a difficulty level"""
    difficulty = get_object_or_404(UniversityExamDifficulty, id=difficulty_id)
    
    try:
        name = difficulty.difficulty_name
        difficulty.delete()
        
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return JsonResponse({'status': 'success'})
        
        messages.success(request, f"Difficulty {name} deleted successfully!")
    except Exception as e:
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return JsonResponse({'status': 'error', 'message': str(e)})
        
        messages.error(request, f"Error deleting difficulty: {str(e)})")
    
    if not request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return redirect('difficulty_list')


def exam_list(request):
    """Display list of exams"""
    university = University.objects.first()
    professors = UniversityProfessor.objects.filter(university=university) if university else []
    exams = []
    
    for professor in professors:
        exams.extend(UniversityExam.objects.filter(professor=professor))
    
    # Add all related data for template display
    context = {
        'exams': exams,
        'university': university,
        'active_page': 'exams',
        'professors': professors,
        'courses': UniversityCourse.objects.filter(university=university) if university else [],
        'difficulties': UniversityExamDifficulty.objects.filter(university=university) if university else []
    }
    return render(request, 'university.html', context)

@csrf_exempt
def add_exam(request):
    """Add a new exam"""
    university = University.objects.first()
    professors = UniversityProfessor.objects.filter(university=university) if university else []
    courses = UniversityCourse.objects.filter(university=university) if university else []
    difficulties = UniversityExamDifficulty.objects.filter(university=university) if university else []
    
    if request.method == 'POST':
        professor_id = request.POST.get('professor')
        course_id = request.POST.get('course')
        difficulty_id = request.POST.get('difficulty')
        num_questions = request.POST.get('num_questions')
        duration = request.POST.get('duration')  # In minutes
        start_time = request.POST.get('start_time')
        end_time = request.POST.get('end_time')
        
        if all([professor_id, course_id, difficulty_id, num_questions, duration, start_time, end_time]):
            try:
                professor = UniversityProfessor.objects.get(id=professor_id)
                course = UniversityCourse.objects.get(id=course_id)
                difficulty = UniversityExamDifficulty.objects.get(id=difficulty_id)
                
                exam = UniversityExam.objects.create(
                    professor=professor,
                    course=course,
                    difficulty=difficulty,
                    num_questions=num_questions,
                    duration=duration,
                    start_time=start_time,
                    end_time=end_time
                )
                messages.success(request, f"Exam {exam.exam_code} added successfully!")
            except Exception as e:
                messages.error(request, f"Error adding exam: {str(e)}")
        else:
            messages.error(request, "All fields are required.")
        
        return redirect('exam_list')
    
    context = {
        'professors': professors,
        'courses': courses,
        'difficulties': difficulties,
        'university': university,
        'active_page': 'add_exam'
    }
    return render(request, 'university.html', context)


@csrf_exempt
def edit_exam(request, exam_id):
    """Edit an existing exam"""
    exam = get_object_or_404(UniversityExam, id=exam_id)
    university = exam.professor.university
    professors = UniversityProfessor.objects.filter(university=university)
    courses = UniversityCourse.objects.filter(university=university)
    difficulties = UniversityExamDifficulty.objects.filter(university=university)
    
    if request.method == 'POST':
        professor_id = request.POST.get('professor')
        course_id = request.POST.get('course')
        difficulty_id = request.POST.get('difficulty')
        num_questions = request.POST.get('num_questions')
        duration = request.POST.get('duration')
        start_time = request.POST.get('start_time')
        end_time = request.POST.get('end_time')
        
        if all([professor_id, course_id, difficulty_id, num_questions, duration, start_time, end_time]):
            try:
                professor = UniversityProfessor.objects.get(id=professor_id)
                if hasattr(exam, 'can_edit_questions') and not exam.can_edit_questions(professor):
                    messages.error(request, "You are not authorized to edit this exam.")
                    return redirect('exam_list')
                
                exam.professor = professor
                exam.course = UniversityCourse.objects.get(id=course_id)
                exam.difficulty = UniversityExamDifficulty.objects.get(id=difficulty_id)
                exam.num_questions = num_questions
                exam.duration = duration
                exam.start_time = start_time
                exam.end_time = end_time
                exam.save()
                
                messages.success(request, f"Exam {exam.exam_code} updated successfully!")
            except Exception as e:
                messages.error(request, f"Error updating exam: {str(e)}")
        else:
            messages.error(request, "All fields are required.")
        
        return redirect('exam_list')
    
    # Return JSON for AJAX requests
    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return JsonResponse({
            'id': exam.id,
            'exam_code': exam.exam_code,
            'professor_id': exam.professor.id,
            'course_id': exam.course.id,
            'difficulty_id': exam.difficulty.id,
            'num_questions': exam.num_questions,
            'duration': exam.duration,
            'start_time': exam.start_time.strftime('%Y-%m-%dT%H:%M'),
            'end_time': exam.end_time.strftime('%Y-%m-%dT%H:%M'),
        })
    
    context = {
        'exam': exam,
        'professors': professors,
        'courses': courses,
        'difficulties': difficulties,
        'university': university,
        'active_page': 'edit_exam'
    }
    return render(request, 'university.html', context)

@csrf_exempt
def delete_exam(request, exam_id):
    """Delete an exam"""
    exam = get_object_or_404(UniversityExam, id=exam_id)
    
    if request.method == 'POST':
        exam_code = exam.exam_code
        exam.delete()
        messages.success(request, f"Exam {exam_code} deleted successfully!")
    
    return redirect('exam_list')

@csrf_exempt
def upload_questions(request, exam_id):
    """
    Upload questions via CSV file for a given exam.
    """
    try:
        exam = get_object_or_404(UniversityExam, id=exam_id)
        
        if request.method != 'POST':
            return JsonResponse({'status': 'error', 'message': 'Only POST method is allowed'}, status=405)
        
        if 'questions_csv' not in request.FILES:
            return JsonResponse({
                'status': 'error', 
                'message': 'No CSV file found. Please upload a file named "questions_csv".'
            }, status=400)
            
        csv_file = request.FILES['questions_csv']
        
        # Check that the file has a .csv extension
        if not csv_file.name.lower().endswith('.csv'):
            return JsonResponse({'status': 'error', 'message': 'File must be a CSV'}, status=400)
        
        try:
            # Read and decode CSV file content
            csv_data = csv_file.read().decode('utf-8')
            io_string = io.StringIO(csv_data)
            reader = csv.reader(io_string)
            
            # Read header row and validate its length
            header = next(reader, None)
            if not header or len(header) < 6:
                return JsonResponse({
                    'status': 'error', 
                    'message': 'CSV file must have at least 6 columns: Question Text, Option A, Option B, Option C, Option D, Correct Answer'
                }, status=400)
            
            question_count = 0
            for row in reader:
                if len(row) >= 6:
                    try:
                        # Extract values and strip extra whitespace
                        question_text = row[0].strip()
                        option_a = row[1].strip()
                        option_b = row[2].strip()
                        option_c = row[3].strip()
                        option_d = row[4].strip()
                        correct_option = row[5].strip().upper()
                        
                        # Validate that none of the required fields are empty
                        if not (question_text and option_a and option_b and option_c and option_d):
                            continue
                        # Validate the correct option
                        if correct_option not in ['A', 'B', 'C', 'D']:
                            continue
                        
                        # Auto-generate a question code
                        last_question = UniversityQuestion.objects.filter(exam=exam).order_by('id').last()
                        if last_question:
                            try:
                                last_code_number = int(''.join(filter(str.isdigit, last_question.question_code)))
                            except Exception:
                                last_code_number = 0
                            new_code_number = last_code_number + 1
                        else:
                            new_code_number = 1
                        question_code = f"Q{new_code_number:03d}"
                        
                        # Prepare options as a dictionary to store in the JSONField
                        options = {
                            "A": option_a,
                            "B": option_b,
                            "C": option_c,
                            "D": option_d
                        }
                        
                        # Create and save the question instance
                        question = UniversityQuestion(
                            exam=exam,
                            question_code=question_code,
                            question_text=question_text,
                            options=options,
                            correct_option=correct_option
                        )
                        question.save()
                        question_count += 1
                    except Exception as e:
                        continue
            
            return JsonResponse({'status': 'success', 'count': question_count})
            
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': f'Error processing CSV: {str(e)}'}, status=400)
    
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)}, status=500)

@csrf_exempt
def add_questions_manually(request, exam_id):
    """Add exam questions manually"""
    try:
        exam = get_object_or_404(UniversityExam, id=exam_id)
        
        if request.method == 'POST':
            try:
                # Parse the JSON data
                questions_data = json.loads(request.body)
                question_count = 0
                
                for q_data in questions_data:
                    # Extract data from the request
                    question_text = q_data.get('question_text', '').strip()
                    options = q_data.get('options', {})
                    correct_option = q_data.get('correct_option', '').strip().upper()
                    
                    # Basic validation
                    if not question_text:
                        continue
                    
                    if not options:
                        # If options are not in the expected format, try to extract them directly
                        options = {
                            'A': q_data.get('option_a', '').strip(),
                            'B': q_data.get('option_b', '').strip(),
                            'C': q_data.get('option_c', '').strip(),
                            'D': q_data.get('option_d', '').strip()
                        }
                    
                    # Validate correct_option
                    if correct_option not in ['A', 'B', 'C', 'D']:
                        continue
                    
                    # Generate question code
                    last_question = UniversityQuestion.objects.filter(exam=exam).order_by('id').last()
                    if last_question:
                        try:
                            last_code_number = int(''.join(filter(str.isdigit, last_question.question_code)))
                        except Exception:
                            last_code_number = 0
                        new_code_number = last_code_number + 1
                    else:
                        new_code_number = 1
                    question_code = f"Q{new_code_number:03d}"
                    
                    # Create the question
                    UniversityQuestion.objects.create(
                        exam=exam,
                        question_code=question_code,
                        question_text=question_text,
                        options=options,
                        correct_option=correct_option
                    )
                    
                    question_count += 1
                
                if question_count > 0:
                    return JsonResponse({'status': 'success', 'count': question_count})
                else:
                    return JsonResponse({'status': 'error', 'message': 'No valid questions were added'}, status=400)
                
            except json.JSONDecodeError:
                return JsonResponse({'status': 'error', 'message': 'Invalid JSON format'}, status=400)
        
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'}, status=405)
        
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)}, status=500)

def result_list(request):
    """Display list of results by exam"""
    university = University.objects.first()
    professors = UniversityProfessor.objects.filter(university=university) if university else []
    
    # Get exams with results
    exams_with_results = []
    for professor in professors:
        exams = UniversityExam.objects.filter(professor=professor)
        for exam in exams:
            result_count = UniversityExamResult.objects.filter(exam=exam).count()
            if result_count > 0:
                exams_with_results.append({
                    'id': exam.id,
                    'code': exam.exam_code,
                    'course': exam.course.name,
                    'professor': exam.professor.name,
                    'result_count': result_count
                })
    
    context = {
        'exams': exams_with_results,
        'university': university,
        'active_page': 'results'
    }
    return render(request, 'university.html', context)

def exam_results(request, exam_id):
    """View results for a specific exam"""
    exam = get_object_or_404(UniversityExam, id=exam_id)
    results = UniversityExamResult.objects.filter(exam=exam)
    
    context = {
        'exam': exam,
        'results': results,
        'university': exam.professor.university,
        'active_page': 'exam_results'
    }
    return render(request, 'university.html', context)

def start_exam(request, exam_id):
    """Start an exam and generate a shareable link"""
    exam = get_object_or_404(UniversityExam, id=exam_id)
    
    # Check if exam is already started
    current_time = timezone.now()
    
    # Validate that we're not trying to start an exam that's already ended
    if current_time > exam.end_time:
        messages.error(request, f"Cannot start exam {exam.exam_code}. The end time has already passed.")
        return redirect('exam_list')
    
    # Check if a link already exists
    exam_link = ExamLink.objects.filter(exam=exam, is_active=True).first()
    
    if not exam_link:
        # Create a new unique code for this exam
        unique_code = str(uuid.uuid4())[:8]
        
        # Create the exam link
        exam_link = ExamLink.objects.create(
            exam=exam,
            unique_code=unique_code,
            is_active=True
        )
    
    # Generate the full URL for students to access
    exam_url = request.build_absolute_uri(
        reverse('student_exam_access', kwargs={'unique_code': exam_link.unique_code})
    )
    
    # Generate QR code for the link
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(exam_url)
    qr.make(fit=True)
    
    img = qr.make_image(fill_color="black", back_color="white")
    buffer = io.BytesIO()
    img.save(buffer)
    img_str = base64.b64encode(buffer.getvalue()).decode()
    
    context = {
        'exam': exam,
        'exam_link': exam_link,
        'exam_url': exam_url,
        'qr_code': img_str,
    }
    
    # Mark exam as started if not already
    if current_time < exam.start_time:
        # If the exam wasn't scheduled to start yet, update the start time
        exam.start_time = current_time
        exam.save()
        messages.success(request, f"Exam {exam.exam_code} started early!")
    else:
        messages.success(request, f"Exam {exam.exam_code} link generated!")
    
    return render(request, 'exam_started.html', context)

def student_exam_access(request, unique_code):
    """Allow students to access exam via unique code"""
    # Find the exam link
    exam_link = get_object_or_404(ExamLink, unique_code=unique_code, is_active=True)
    exam = exam_link.exam
    
    # Check if exam is within its time window
    current_time = timezone.now()
    
    if current_time < exam.start_time:
        # Exam hasn't started yet
        time_until_start = exam.start_time - current_time
        minutes_until_start = int(time_until_start.total_seconds() / 60)
        
        context = {
            'exam': exam,
            'message': f"This exam will start in {minutes_until_start} minutes.",
            'status': 'waiting',
        }
        return render(request, 'exam_wait.html', context)
    
    if current_time > exam.end_time:
        # Exam has ended
        context = {
            'exam': exam,
            'message': "This exam has ended.",
            'status': 'ended',
        }
        return render(request, 'exam_wait.html', context)
    
    # Check if user is logged in
    user_id = request.session.get('user_id')
    if not user_id:
        # Save the exam code in session so we can redirect back after login
        request.session['pending_exam_code'] = unique_code
        messages.info(request, "Please log in to start the exam.")
        return redirect('login')
    
    # Redirect to the take_exam view in your student app
    return redirect('take_exam', exam_id=exam.id)

def get_exam_data(request, exam_id):
    """Fetch exam data for editing"""
    exam = get_object_or_404(UniversityExam, id=exam_id)
    if request.method == 'GET':
        return JsonResponse({
            'id': exam.id,
            'exam_code': exam.exam_code,
            'professor_id': exam.professor.id,
            'course_id': exam.course.id,
            'difficulty_id': exam.difficulty.id,
            'num_questions': exam.num_questions,
            'duration': exam.duration,
            'start_time': exam.start_time.strftime('%Y-%m-%dT%H:%M'),
            'end_time': exam.end_time.strftime('%Y-%m-%dT%H:%M'),
        })
    return JsonResponse({'status': 'error', 'message': 'Invalid request method'}, status=400)

def get_exam_questions(request, exam_id):
    """Get all questions for a specific exam"""
    exam = get_object_or_404(UniversityExam, id=exam_id)
    questions = UniversityQuestion.objects.filter(exam=exam)
    
    questions_list = []
    for question in questions:
        questions_list.append({
            'id': question.id,
            'question_code': question.question_code,
            'question_text': question.question_text,
            'options': question.options,
            'correct_option': question.correct_option
        })
    
    return JsonResponse({'status': 'success', 'questions': questions_list})

@csrf_exempt
def delete_question(request, question_id):
    """Delete a specific question"""
    question = get_object_or_404(UniversityQuestion, id=question_id)
    
    if request.method == 'POST':
        question.delete()
        return JsonResponse({'status': 'success'})
    
    return JsonResponse({'status': 'error', 'message': 'Invalid request method'})