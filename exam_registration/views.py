from django.shortcuts import render, redirect
from django.contrib import messages
from .models import StudentsDB
from examportol.models import Category, Subject
from oauth.models import UsersDB  # Import from oauth.models
from django.core.exceptions import ObjectDoesNotExist

def exam_home(request):
    return render(request, "exam_home.html")

def exam_register(request):
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "You need to log in to register for an exam.")
        return redirect('/login/')

    try:
        user = UsersDB.objects.get(id=user_id)
    except ObjectDoesNotExist:
        request.session.flush()
        messages.error(request, "Session expired. Please log in again.")
        return redirect('/login/')

    categories = Category.objects.all()
    subjects = Subject.objects.all()

    if request.method == "POST":
        full_name = request.POST.get("full_name", "").strip()
        email = request.POST.get("email", "").strip()
        phone_number = request.POST.get("phone_number", "").strip()
        domain_id = request.POST.get("domain")
        subject_id = request.POST.get("subject")
        payment = "INR 999.00"

        # Validate required fields
        if not all([full_name, email, phone_number, domain_id, subject_id]):
            messages.error(request, "All fields are required.")
            return redirect("exam_register")

        if domain_id == "" or subject_id == "":
            messages.error(request, "Please select a valid domain and subject.")
            return redirect("exam_register")

        # Check if the user has already registered for the same domain-subject combination
        if StudentsDB.objects.filter(user=user, domain_id=domain_id, subject_id=subject_id).exists():
            messages.error(request, "Already registered for this domain and subject combination.")
            return redirect("exam_register")

        try:
            domain = Category.objects.get(id=domain_id)
            subject = Subject.objects.get(id=subject_id)
        except ObjectDoesNotExist:
            messages.error(request, "Invalid domain or subject selected.")
            return redirect("exam_register")

        try:
            student = StudentsDB.objects.create(
                user=user,
                username=user.username,
                full_name=full_name,
                email=email,
                phone_number=phone_number,
                domain=domain,
                subject=subject,
                payment=payment
            )
            messages.success(request, f"Registration successful! Your Student ID is {student.studentId}.")
            return redirect("exam_home")
        except Exception as e:
            messages.error(request, f"An error occurred while registering: {str(e)}")
            return redirect("exam_register")

    return render(request, "exam_registration.html", {"categories": categories, "subjects": subjects, "user": user})

def exam_resisteration_success(request):
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "User not found. Please log in again.")
        return redirect('/login/')
    
    try:
        user = UsersDB.objects.get(id=user_id)
    except UsersDB.DoesNotExist:
        messages.error(request, "User not found. Please log in again.")
        return redirect('/login/')

    # Retrieve the latest registration for the user.
    registration = StudentsDB.objects.filter(user=user).last()
    if registration and registration.subject:
        request.session['registered_subject'] = registration.subject.id
        return redirect('instructions')
    
    messages.error(request, "Registration record not found. Please register for the exam.")
    return redirect("exam_register")
