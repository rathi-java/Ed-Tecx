from django.shortcuts import render, redirect
from django.contrib import messages
from .models import StudentsDB
from examportol.models import Category, Subject

def exam_home(request):
    return render(request, "exam_home.html")

def exam_register(request):
    categories = Category.objects.all()  # Fetch all available categories
    subjects = Subject.objects.all()  # Fetch all subjects

    if request.method == "POST":
        username = request.POST.get("username")
        email = request.POST.get("email")
        domain_id = request.POST.get("domain")  # Get selected category ID
        subject_id = request.POST.get("subject")  # Get selected subject ID
        date = request.POST.get("date")
        payment = "INR 999"

        if domain_id == "Select" or subject_id == "Select":
            messages.error(request, "Please select a valid domain and subject.")
            return redirect("exam_resisteration_success")

        domain = Category.objects.get(id=domain_id)
        subject = Subject.objects.get(id=subject_id)

        StudentsDB.objects.create(
            username=username,
            email=email,
            domain=domain,
            subject=subject,
            date=date,
            payment=payment
        )
        
        messages.success(request, "Registration successful!")
        return redirect("exam_resisteration_success")

    return render(request, "exam_registration.html", {"categories": categories, "subjects": subjects})
def exam_resisteration_success(request):
    return render(request, "exam_resisteration_success.html")
