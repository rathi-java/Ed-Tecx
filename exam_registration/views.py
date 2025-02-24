from django.shortcuts import render, redirect
from django.contrib import messages
from .models import StudentsDB
from examportol.models import Category, Subject
from oauth.models import UsersDB
from django.core.exceptions import ObjectDoesNotExist
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
    # Get user from session with improved error handling
    user = get_user_from_session(request)
    if not user:
        logger.warning("User not found in session during exam registration attempt")
        messages.error(request, "You need to log in to register for an exam.")
        return redirect('/login/')

    categories = Category.objects.all()
    subjects = Subject.objects.all()

    if request.method == "POST":
        try:
            # Form data collection
            full_name = request.POST.get("full_name", "").strip()
            email = request.POST.get("email", "").strip()
            phone_number = request.POST.get("phone_number", "").strip()
            domain_id = request.POST.get("domain")
            subject_id = request.POST.get("subject")
            payment = "INR 999.00"

            # Validation
            if not all([full_name, email, phone_number, domain_id, subject_id]):
                messages.error(request, "All fields are required.")
                return redirect("exam_register")

            if domain_id == "" or subject_id == "":
                messages.error(request, "Please select a valid domain and subject.")
                return redirect("exam_register")

            # Check for existing registration
            if StudentsDB.objects.filter(
                domain_id=domain_id,
                subject_id=subject_id
            ).exists():
                messages.error(request, "Already registered for this domain and subject combination.")
                return redirect("exam_register")

            # Get domain and subject
            domain = Category.objects.get(id=domain_id)
            subject = Subject.objects.get(id=subject_id)

            # Create registration
            student = StudentsDB.objects.create(
                username=user.username,
                full_name=full_name,
                email=email,
                phone_number=phone_number,
                domain=domain,
                subject=subject,
                payment=payment
            )

            # Store registration data in session
            request.session['registered_subject'] = subject.id
            request.session['student_id'] = student.studentId
            request.session.save()

            logger.info(f"Successful exam registration for user {user.username}")
            messages.success(request, f"Registration successful! Your Student ID is {student.studentId}.")
            return redirect("exam_home")

        except ObjectDoesNotExist:
            logger.error("Invalid domain or subject selected during registration")
            messages.error(request, "Invalid domain or subject selected.")
            return redirect("exam_register")
        except Exception as e:
            logger.error(f"Error during exam registration: {str(e)}")
            messages.error(request, f"An error occurred while registering: {str(e)}")
            return redirect("exam_register")

    return render(request, "exam_registration.html", {
        "categories": categories,
        "subjects": subjects,
        "user": user
    })

def exam_resisteration_success(request):
    # Get user from session with improved error handling
    user = get_user_from_session(request)
    if not user:
        logger.warning("User not found in session during exam registration success check")
        messages.error(request, "User not found. Please log in again.")
        return redirect('/login/')

    try:
        # Get latest registration
        registration = StudentsDB.objects.filter(user=user).last()
        if registration and registration.subject:
            # Store registration data in session
            request.session['registered_subject'] = registration.subject.id
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