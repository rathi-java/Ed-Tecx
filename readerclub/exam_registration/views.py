from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from .models import StudentsDB
from examportol.models import Exam
from oauth.models import UsersDB
import logging

logger = logging.getLogger(__name__)

def get_user_from_session(request):
    """Helper function to get user from session"""
    try:
        user_id = request.session.get('user_id')
        if user_id:
            return UsersDB.objects.get(id=user_id)
        return None
    except UsersDB.DoesNotExist:
        logger.error(f"UsersDB not found for user_id: {user_id}")
        request.session.flush()
        return None
    except Exception as e:
        logger.error(f"Error getting user from session: {str(e)}")
        return None

def exam_home(request):
    user = get_user_from_session(request)
    return render(request, "exam_home.html", {"user": user})

def exam_register(request):
    user = get_user_from_session(request)
    if not user:
        logger.warning("User not found in session during exam registration attempt")
        messages.error(request, "You need to log in to register for an exam.")
        return redirect('/login/')

    # Query all available exams for registration
    exams = Exam.objects.all()

    if request.method == "POST":
        try:
            # Collect form data
            full_name = request.POST.get("full_name", "").strip()
            email = request.POST.get("email", "").strip()
            phone_number = request.POST.get("phone_number", "").strip()
            exam_id = request.POST.get("exam_domain")  # This will hold the selected exam ID
            payment = "INR 999.00"

            # Validate required fields
            if not all([full_name, email, phone_number, exam_id]):
                messages.error(request, "All fields are required.")
                return redirect("exam_register")

            if exam_id == "":
                messages.error(request, "Please select a valid exam.")
                return redirect("exam_register")

            # Check if user is already registered for this exam
            if StudentsDB.objects.filter(user=user, exam_domain_id=exam_id).exists():
                messages.error(request, "Already registered for this exam.")
                return redirect("exam_register")

            # Retrieve the exam from the database
            exam = Exam.objects.get(id=exam_id)

            # Create a new registration
            student = StudentsDB.objects.create(
                user=user,
                username=user.username,
                full_name=full_name,
                email=email,
                phone_number=phone_number,
                exam_domain=exam,
                payment=payment
            )

            # Store registration data in session for later use
            request.session['registered_exam'] = exam.id
            request.session['student_id'] = student.studentId
            request.session.save()

            logger.info(f"Successful exam registration for user {user.username}")
            messages.success(request, f"Registration successful! Your Student ID is {student.studentId}.")
            return redirect("exam_home")

        except ObjectDoesNotExist:
            logger.error("Invalid exam selected during registration")
            messages.error(request, "Invalid exam selected.")
            return redirect("exam_register")
        except Exception as e:
            logger.error(f"Error during exam registration: {str(e)}")
            messages.error(request, f"An error occurred while registering: {str(e)}")
            return redirect("exam_register")

    return render(request, "exam_registration.html", {
        "exams": exams,
        "user": user
    })

def exam_resisteration_success(request):
    user = get_user_from_session(request)
    if not user:
        logger.warning("User not found in session during exam registration success check")
        messages.error(request, "User not found. Please log in again.")
        return redirect('/login/')

    try:
        # Get latest registration for the user
        registration = StudentsDB.objects.filter(user=user).last()
        if registration and registration.exam_domain:
            request.session['registered_exam'] = registration.exam_domain.id
            request.session.save()
            logger.info(f"Successfully retrieved registration for user {user.username}")
            return redirect('instructions')

        logger.warning(f"No registration found for user {user.username}")
        messages.error(request, "Registration record not found. Please register for the exam.")
        return redirect("exam_register")

    except Exception as e:
        logger.error(f"Error in exam registration success: {str(e)}")
        messages.error(request, "An error occurred. Please try again.")
        return redirect("exam_register")
