from django.db import IntegrityError
from django.shortcuts import get_object_or_404, render, redirect
from django.contrib import messages
from django.http import HttpResponse
from exam_backend.models import Professor, Course, Difficulty, Exam, Question

# Create your views here.
def home(request):
    return HttpResponse("<h1>Hello this is online examination...!</h1>")

def addProfessor(request):
    if request.method == 'POST':
        professor_name = request.POST.get('professor_name')
        professor_email = request.POST.get('professor_email')
        professor_pass = request.POST.get('professor_pass')

        # Check if the email already exists in the database
        if Professor.objects.filter(email=professor_email).exists():
            messages.error(request, "Email already exists. Please use a different email.")
            return redirect('add')

        # Create and save the new professor object
        professor = Professor(name=professor_name, email=professor_email, password=professor_pass)
        professor.save()

        messages.success(request, "Professor added successfully!")
        return redirect('add')

    return render(request, 'addProfessors.html', {'page': 'Add Professors'})

def addCourse(request):
    if request.method == 'POST':
        course_name = request.POST.get('course_name').strip()
        normalized_course_name = course_name.upper()

        if Course.objects.filter(name=normalized_course_name).exists():
            messages.error(request, "Course with this name already exists!")
            return redirect('add_course')
        # Create and save the new course object (the save method will normalize and check uniqueness)
        course = Course(name=course_name)
        course.save()
        messages.success(request, "Course added successfully!")
        return redirect('add_course')

    return render(request, 'addCourse.html', {'page': 'Add Course'})

def addDifficulty(request):
    if request.method == 'POST':
        difficulty_name = request.POST.get('difficulty_level').strip()

        # Normalize the difficulty name to uppercase before saving
        normalized_difficulty_name = difficulty_name.upper()

        try:
            # Try to create and save the new difficulty object with the uppercase name
            difficulty = Difficulty(difficulty_name=normalized_difficulty_name)
            difficulty.save()
            messages.success(request, "Difficulty level added successfully!")
            return redirect('add_difficulty')
        except IntegrityError:
            # If there's an IntegrityError (duplicate difficulty_name), show an error message
            messages.error(request, "Difficulty level with this name already exists!")
            return redirect('add_difficulty')

    return render(request, 'addDifficulty.html', {'page': 'Add Difficulty'})

def examList(request):
    exams = Exam.objects.all()  # Get all exams
    return render(request, 'examList.html', {'exams': exams})

def addExam(request):
    if request.method == "POST":
        # Get data from the form
        professor_id = request.POST.get("professor")
        course_id = request.POST.get("course")
        difficulty_id = request.POST.get("difficulty")
        duration = request.POST.get("duration")
        num_questions = request.POST.get("num_questions")

        try:
            # Retrieve the related objects
            professor = Professor.objects.get(id=professor_id)
            course = Course.objects.get(id=course_id)
            difficulty = Difficulty.objects.get(id=difficulty_id)

            # Check if an exam already exists with this combination
            existing_exam = Exam.objects.filter(
                professor=professor,
                course=course,
                difficulty=difficulty
            ).first()

            if existing_exam:
                messages.error(request, f"Exam already generated with Exam ID: {existing_exam.exam_code}")
                return redirect('add_exam')

            # Create and save the new Exam
            new_exam = Exam(
                professor=professor,
                course=course,
                difficulty=difficulty,
                duration=duration,
                num_questions=num_questions
            )
            new_exam.save()

            exam_code = new_exam.exam_code
            messages.success(request, f"Exam has been successfully added! Exam ID: {exam_code}")
            return redirect('add_exam')

        except Exception as e:
            messages.error(request, f"Error: {str(e)}")

    # Fetch data for the dropdowns
    professors = Professor.objects.all()
    courses = Course.objects.all()
    difficulties = Difficulty.objects.all()

    return render(request, 'addExam.html', {
        'professors': professors,
        'courses': courses,
        'difficulties': difficulties,
        'page': 'Add Exam'
    })

def updateExam(request, exam_code):
    # Fetch the exam object
    exam = get_object_or_404(Exam, exam_code=exam_code)
    professors = Professor.objects.all()
    courses = Course.objects.all()
    difficulties = Difficulty.objects.all()

    if request.method == "POST":
        # Handle form submission
        professor_id = request.POST.get("professor")
        course_id = request.POST.get("course")
        difficulty_id = request.POST.get("difficulty")
        duration = request.POST.get("duration")
        num_questions = request.POST.get("num_questions")

        # Validation
        if not professor_id or not course_id or not difficulty_id or not duration or not num_questions:
            messages.error(request, "All fields are required.")
            return redirect('update_exam', exam_code=exam_code)

        # Update exam details
        try:
            exam.professor = Professor.objects.get(id=professor_id)
            exam.course = Course.objects.get(id=course_id)
            exam.difficulty = Difficulty.objects.get(id=difficulty_id)
            exam.duration = int(duration)
            exam.num_questions = int(num_questions)
            exam.save()
            messages.success(request, "Exam updated successfully.")
            return redirect('exam_list')  # Redirect to exam list after success
        except Exception as e:
            messages.error(request, f"An error occurred: {str(e)}")

    # Render the update exam page with pre-filled data
    context = {
        'exam': exam,
        'professors': professors,
        'courses': courses,
        'difficulties': difficulties,
    }
    return render(request, 'updateExam.html', context)

def editExam(request, id):
    exam = get_object_or_404(Exam, id=id)
    question_range = range(1, exam.num_questions + 1)
    questions = Question.objects.filter(exam=exam)  # Retrieve existing questions for the exam

    # If some questions are missing, we need to add placeholder objects
    while len(questions) < exam.num_questions:
        questions = list(questions) + [None]  # Add a placeholder None for missing questions

    if request.method == "POST":
        for i in range(1, exam.num_questions + 1):
            question_text = request.POST.get(f"question_{i}")
            options = {
                "A": request.POST.get(f"option_{i}_A"),
                "B": request.POST.get(f"option_{i}_B"),
                "C": request.POST.get(f"option_{i}_C"),
                "D": request.POST.get(f"option_{i}_D"),
            }
            correct_option = request.POST.get(f"correct_option_{i}")

            # Get the corresponding question from the database or create a new one if missing
            question = questions[i - 1]
            if question is None:
                question = Question(exam=exam)  # Create a new question if it's None

            question.question_text = question_text
            question.options = options
            question.correct_option = correct_option

            professor_code = exam.professor.professor_code
            course_code = exam.course.course_code
            difficulty_code = exam.difficulty.difficulty_code
            exam_code = exam.exam_code

            # Update the question code generation with the new structure
            question_code = f"{professor_code}-{course_code}-{difficulty_code}-{exam_code}-{i:03d}"

            question.question_code = question_code
            question.save()

        messages.success(request, f"{exam.num_questions} questions have been updated successfully!")
        return redirect('exam_list')

    return render(request, 'editExam.html', {'exam': exam, 'question_range': question_range, 'questions': questions})

def start_exam(request, exam_code):
    """
    Renders the page with all questions for a specific exam based on exam code.
    """
    exam = get_object_or_404(Exam, exam_code=exam_code)  # Get the specific exam using the code
    questions = Question.objects.filter(exam=exam)  # Get all questions for the exam

    if request.method == "POST":
        # Handle submitted answers
        submitted_data = request.POST
        correct_answers = 0
        total_questions = questions.count()

        for question in questions:
            selected_option = submitted_data.get(f'question_{question.id}')
            if selected_option == question.correct_option:
                correct_answers += 1

        # Calculate score
        score = (correct_answers / total_questions) * 100

        return render(request, 'examResult.html', {
            'exam': exam,
            'score': score,
            'correct_answers': correct_answers,
            'total_questions': total_questions
        })

    return render(request, 'exam.html', {
        'exam': exam,
        'questions': questions,
    })
