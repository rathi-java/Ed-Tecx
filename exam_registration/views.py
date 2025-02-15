from django.shortcuts import render, redirect
from django.contrib import messages
from .models import StudentsDB
from examportol.models import Category, Subject
from oauth.views import UsersDB

def exam_home(request):
    return render(request, "exam_home.html")

def exam_register(request):
    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            request.session.flush()  # Clear session if user not found
            messages.error(request, "Session expired. Please login again.")
            return redirect('/login/')

    categories = Category.objects.all()
    subjects = Subject.objects.all()

    if request.method == "POST":
        username = request.POST.get("username")
        full_name = request.POST.get("full_name")
        email = request.POST.get("email")
        phone_number = request.POST.get("phone_number")
        domain_id = request.POST.get("domain")
        subject_id = request.POST.get("subject")
        date = request.POST.get("date")
        payment = "INR 999"

        if domain_id == "Select" or subject_id == "Select":
            messages.error(request, "Please select a valid domain and subject.")
            return redirect("exam_registration")

        try:
            domain = Category.objects.get(id=domain_id)
            subject = Subject.objects.get(id=subject_id)

            # Save data to the database
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

        except Category.DoesNotExist:
            messages.error(request, "Invalid domain selected.")
        except Subject.DoesNotExist:
            messages.error(request, "Invalid subject selected.")

    return render(request, "exam_registration.html", {"categories": categories, "subjects": subjects, 'user': user})

def exam_resisteration_success(request):
    return render(request, "exam_resisteration_success.html")
