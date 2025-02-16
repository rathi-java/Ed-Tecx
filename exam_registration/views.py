from django.shortcuts import render, redirect
from django.contrib import messages
from .models import StudentsDB
from examportol.models import Category, Subject
from oauth.views import UsersDB
from django.core.exceptions import ObjectDoesNotExist
from django.urls import reverse
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
        subject_id = request.POST.get("subject")
        date = request.POST.get("date")
        payment = "INR 999.00"

        if not all([username, full_name, email, phone_number, domain_id, subject_id, date]):
            messages.error(request, "All fields are required.")
            return redirect("exam_register")

        if domain_id == "Select" or subject_id == "Select":
            messages.error(request, "Please select a valid domain and subject.")
            return redirect("exam_register")

        if StudentsDB.objects.filter(username=username, subject_id=subject_id).exists():
            messages.warning(request, "You have already registered for this subject.")
            return redirect("exam_register")

        try:
            domain = Category.objects.get(id=domain_id)
            subject = Subject.objects.get(id=subject_id)
        except ObjectDoesNotExist:
            messages.error(request, "Invalid domain or subject selected.")
            return redirect("exam_register")

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

        messages.success(request, "Registration successful!")
        return redirect("exam_resisteration_success")

    return render(request, "exam_registration.html", {"categories": categories, "subjects": subjects, 'user': user})

def exam_resisteration_success(request):
    # IMPORTANT: Use the same user source as in registration!
    # If you use a custom user stored in session, use that instead of request.user.
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "User not found. Please log in again.")
        return redirect('/login/')
    try:
        user_obj = UsersDB.objects.get(id=user_id)
    except UsersDB.DoesNotExist:
        messages.error(request, "User not found. Please log in again.")
        return redirect('/login/')

    registration = StudentsDB.objects.filter(email=user_obj.email).last()
    if registration and registration.subject:
        request.session['registered_subject'] = registration.subject.id
        return redirect('instructions')
    messages.error(request, "Registration record not found. Please register for the exam.")
    return redirect("exam_register")
