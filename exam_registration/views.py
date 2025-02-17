from django.shortcuts import render, redirect
from django.contrib import messages
from .models import StudentsDB
from examportol.models import Category, Subject
from oauth.views import UsersDB
from django.core.exceptions import ObjectDoesNotExist
from django.http import HttpResponseRedirect

def exam_home(request):
    return render(request, "exam_home.html")

def exam_register(request):
    user_id = request.session.get('user_id')
    user = None

    if not user_id:
        messages.error(request, "You need to log in to register for an exam.")
        return redirect('/login/')

    try:
        user = UsersDB.objects.get(id=user_id)
    except ObjectDoesNotExist:
        request.session.flush()
        messages.error(request, "Session expired. Please login again.")
        return redirect('/login/')

    categories = Category.objects.all()
    subjects = Subject.objects.all()

    if request.method == "POST":
        username = request.POST.get("username").strip()
        full_name = request.POST.get("full_name").strip()
        email = request.POST.get("email").strip()
        phone_number = request.POST.get("phone_number").strip()
        domain_id = request.POST.get("domain")
        subject_ids = request.POST.getlist("subject")  # Allow multiple subjects
        date = request.POST.get("date")
        payment = "INR 999.00"

        # Check if all fields are filled
        if not all([username, full_name, email, phone_number, domain_id, subject_ids, date]):
            messages.error(request, "All fields are required.")
            return redirect("exam_register")

        if domain_id == "Select" or not subject_ids:
            messages.error(request, "Please select a valid domain and at least one subject.")
            return redirect("exam_register")

        # Check if the phone number is already registered
        if StudentsDB.objects.filter(phone_number=phone_number).exists():
            messages.error(request, "This phone number is already registered.")
            return redirect("exam_register")

        # Check if user has already registered with the same username and subject
        for subject_id in subject_ids:
            if StudentsDB.objects.filter(username=username, subject_id=subject_id).exists():
                messages.warning(request, f"You have already registered for this subject: {subject_id}.")
                return redirect("exam_register")

        try:
            domain = Category.objects.get(id=domain_id)
            selected_subjects = Subject.objects.filter(id__in=subject_ids)  # Fetch selected subjects
        except ObjectDoesNotExist:
            messages.error(request, "Invalid domain or subject selected.")
            return redirect("exam_register")

        # Create entries for each subject the user selects
        for subject in selected_subjects:
            try:
                StudentsDB.objects.create(
                    username=username,
                    full_name=full_name,
                    email=email,
                    phone_number=phone_number,
                    domain=domain,
                    subject=subject,
                    date=date,
                    payment=payment
                )
            except Exception as e:
                messages.error(request, f"An error occurred while registering: {str(e)}")
                return redirect("exam_register")

        messages.success(request, "Registration successful!")
        return redirect("exam_home")

    return render(request, "exam_registration.html", {"categories": categories, "subjects": subjects, 'user': user})

def exam_resisteration_success(request):
    # Ensure the user is logged in
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "User  not found. Please log in again.")
        return redirect('/login/')
    
    try:
        user_obj = UsersDB.objects.get(id=user_id)
    except UsersDB.DoesNotExist:
        messages.error(request, "User  not found. Please log in again.")
        return redirect('/login/')

    # Check the registration status
    registration = StudentsDB.objects.filter(email=user_obj.email).last()
    if registration and registration.subject:
        request.session['registered_subject'] = registration.subject.id
        return redirect('instructions')
    
    messages.error(request, "Registration record not found. Please register for the exam.")
    return redirect("exam_register")