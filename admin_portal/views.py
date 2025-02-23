
from datetime import *
import json
import os
from django.db import IntegrityError
from django.http import HttpResponseRedirect, JsonResponse
from django.shortcuts import render ,redirect ,get_object_or_404
from django.urls import reverse
from admin_portal.models import *
from exam_registration.models import *
from oauth.models import *
from examportol.models import *
from django.contrib import messages
from django.utils import timezone
from datetime import timedelta
from certificate_management.models import *
from jobportol.models import *

# def dashboard(request):
#     certificates = Certificate.objects.all()  # Fetch all certificate requests
#     return render(request, "dashboard.html", {"certificates": certificates})

def update_certificate_status(request):
    if request.method == "POST":
        selected_certificates = request.POST.getlist("selected_certificates")
        new_status = request.POST.get("certificate_status_action")

        if not selected_certificates:
            messages.error(request, "Please select at least one certificate.")
            return redirect("dashboard")  # Redirect to dashboard.html

        if new_status not in ["approve", "reject"]:
            messages.error(request, "Please select a valid status action.")
            return redirect("dashboard")

        # Mapping status values
        status_value = "Approved" if new_status == "approve" else "Rejected"

        # Updating status for selected certificates
        Certificate.objects.filter(id__in=selected_certificates).update(status=status_value)

        messages.success(request, f"Selected certificates have been {status_value.lower()} successfully.")
        return redirect("dashboard")  # Redirect back to dashboard.html

def dashboard(request):
    # Fetch data from the database
    
    total_super_admins = SuperAdminDB.objects.count()
    total_admins = AdminDB.objects.count()
    total_managers = ManagerDB.objects.count()
    total_employees = EmployeeDB.objects.count()
    total_students = StudentsDB.objects.count()
    total_users = UsersDB.objects.count()
    total_colleges = CollegesDb.objects.count()
    total_questions = Question.objects.count()
    total_subjects = Subject.objects.count()
    total_categories = Category.objects.count()
    certificates = Certificate.objects.all().order_by('-created_at')  # Fetch certificates if required

    # Active users (users who logged in within the last 30 days)
    active_users = UsersDB.objects.filter(last_login__gte=timezone.now() - timedelta(days=30)).count()

    # Premium users (assuming premium users have a specific field or condition)
    # Example: If premium users have a field `is_premium=True`
    # premium_users = UsersDB.objects.filter(is_premium=True).count()
    premium_users = 0  # Replace with actual logic if applicable

    # Sales data (assuming you have a Sales model)
    # Example: If you have a Sales model with an `amount` field
    # total_sales = Sale.objects.aggregate(total_sales=Sum('amount'))['total_sales'] or 0
    # yearly_sales = Sale.objects.filter(date__year=timezone.now().year).aggregate(total_sales=Sum('amount'))['total_sales'] or 0
    # monthly_sales = Sale.objects.filter(date__month=timezone.now().month, date__year=timezone.now().year).aggregate(total_sales=Sum('amount'))['total_sales'] or 0
    # weekly_sales = Sale.objects.filter(date__gte=timezone.now() - timedelta(days=7)).aggregate(total_sales=Sum('amount'))['total_sales'] or 0
    # daily_sales = Sale.objects.filter(date=timezone.now().date()).aggregate(total_sales=Sum('amount'))['total_sales'] or 0

    # Placeholder values for sales (replace with actual logic if applicable)
    total_sales = 0
    yearly_sales = 0
    monthly_sales = 0
    weekly_sales = 0
    daily_sales = 0

    context = {
        "admins": AdminDB.objects.all(),
        "managers": ManagerDB.objects.all(),
        "employees": EmployeeDB.objects.all(),
        "colleges": CollegesDb.objects.all(),
        "users": UsersDB.objects.all(),
        "questions": Question.objects.all(),
        "subjects": Subject.objects.all(),
        "categories": Category.objects.all(),
        "students": StudentsDB.objects.all(),
        "certificates": certificates,
        "jobs":Job.objects.all(),

        # Dashboard metrics
        "total_super_admins": total_super_admins,
        "total_admins": total_admins,
        "total_managers": total_managers,
        "total_employees": total_employees,
        "total_students": total_students,
        "total_users": total_users,
        "total_colleges": total_colleges,
        "total_questions": total_questions,
        "total_subjects": total_subjects,
        "total_categories": total_categories,
        "active_users": active_users,
        "premium_users": premium_users,
        "total_sales": total_sales,
        "yearly_sales": yearly_sales,
        "monthly_sales": monthly_sales,
        "weekly_sales": weekly_sales,
        "daily_sales": daily_sales,
    }
    return render(request, 'dashboard.html', context)

def add_admin(request):
    if request.method == "POST":
        admin_id = request.POST.get('admin_id')  
        full_name = request.POST.get('full_name')
        email = request.POST.get("email")
        phone_number = request.POST.get("phone_number")
        alt_phone_number = request.POST.get("alt_phone_number")
        password = request.POST.get("password")
        aadhar_number = request.POST.get("aadhar_number")

        try:
            if admin_id:  
                admin = get_object_or_404(AdminDB, id=admin_id)
                admin.full_name = full_name
                admin.email = email
                admin.phone_number = phone_number
                admin.alt_phone_number = alt_phone_number
                admin.password = password
                admin.aadhar_number = aadhar_number
                admin.save()
                messages.success(request, "Admin updated successfully!")
            else:  
                admin = AdminDB(
                    full_name=full_name,
                    email=email,
                    phone_number=phone_number,
                    alt_phone_number=alt_phone_number,
                    password=password,
                    aadhar_number=aadhar_number
                )
                admin.save()
                messages.success(request, "Admin added successfully!")

            # Redirect to dashboard and open Manage Admin section
            url = reverse('dashboard') + "?page=manage_admin"
            return HttpResponseRedirect(url)  

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")  
            return redirect('add_admin')

    return redirect('dashboard')

def delete_admin(request, admin_id):
    if request.method == "POST":
        admin = get_object_or_404(AdminDB, id=admin_id)
        admin.delete()
        messages.success(request, "Admin deleted successfully!")

    # Redirect to dashboard and open Manage Admin section
    url = reverse('dashboard') + "?page=manage_admin"
    return HttpResponseRedirect(url)

def add_manager(request):
    if request.method == "POST":
        manager_id = request.POST.get('manager_id')  # Fetch manager ID if editing an existing entry
        full_name = request.POST.get('full_name').strip()
        email = request.POST.get("email").strip()
        phone_number = request.POST.get("phone_number").strip()
        alt_phone_number = request.POST.get("alt_phone_number").strip()
        password = request.POST.get("password")
        aadhar_number = request.POST.get("aadhar_number")

        try:
            # Check if a manager with the same email already exists
            existing_manager = ManagerDB.objects.filter(email__iexact=email).first()
            
            if existing_manager:
                messages.error(request, "Manager with this email already exists!")
                return redirect(reverse('dashboard') + "?page=manage_manager")

            if manager_id:  # If manager_id exists, update the existing entry
                manager = get_object_or_404(ManagerDB, id=manager_id)
                manager.full_name = full_name
                manager.email = email
                manager.phone_number = phone_number
                manager.alt_phone_number = alt_phone_number
                manager.password = password
                manager.aadhar_number = aadhar_number
                manager.save()
                messages.success(request, "Manager updated successfully!")
            else:  # Otherwise, create a new entry
                manager = ManagerDB(
                    full_name=full_name,
                    email=email,
                    phone_number=phone_number,
                    alt_phone_number=alt_phone_number,
                    password=password,
                    aadhar_number=aadhar_number
                )
                manager.save()
                messages.success(request, "Manager added successfully!")

            # Redirect to the dashboard and open Manage Manager section
            return HttpResponseRedirect(reverse('dashboard') + "?page=manage_manager")

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")  # Log actual error
            return redirect(reverse('dashboard') + "?page=manage_manager")

    return redirect('dashboard')

def delete_manager(request, manager_id):
    if request.method == "POST":
        try:
            manager = get_object_or_404(ManagerDB, id=manager_id)
            manager.delete()
            messages.success(request, "Manager deleted successfully!")
        except ManagerDB.DoesNotExist:
            messages.error(request, "Manager not found!")
    
        # Redirect to the dashboard and open Manage Manager section
        return HttpResponseRedirect(reverse('dashboard') + "?page=manage_manager")
    
    return redirect('dashboard')

def add_employee(request):
    if request.method == "POST":
        employee_id = request.POST.get('employee_id')
        full_name = request.POST.get('full_name').strip()
        email = request.POST.get("email").strip()
        phone_number = request.POST.get("phone_number").strip()
        alt_phone_number = request.POST.get("alt_phone_number").strip()
        aadhar_number = request.POST.get("aadhar_number").strip()

        try:
            existing_employee = EmployeeDB.objects.filter(
                email__iexact=email, phone_number__iexact=phone_number
            ).first()

            if existing_employee:
                messages.error(request, "Employee with this email or phone number already exists!")
                return redirect(reverse('dashboard') + "?page=manage_employee")

            if employee_id:
                employee = get_object_or_404(EmployeeDB, id=employee_id)
                employee.full_name = full_name
                employee.email = email
                employee.phone_number = phone_number
                employee.alt_phone_number = alt_phone_number
                employee.aadhar_number = aadhar_number
                employee.save()
                messages.success(request, "Employee updated successfully!")
            else:
                employee = EmployeeDB(
                    full_name=full_name,
                    email=email,
                    phone_number=phone_number,
                    alt_phone_number=alt_phone_number,
                    aadhar_number=aadhar_number
                )
                employee.save()
                messages.success(request, "Employee added successfully!")

            return redirect(reverse('dashboard') + "?page=manage_employee")

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")
            return redirect(reverse('dashboard') + "?page=manage_employee")

    return redirect('dashboard')

def delete_employee(request, employee_id):
    if request.method == "POST":
        employee = get_object_or_404(EmployeeDB, id=employee_id)
        employee.delete()
        messages.success(request, "Employee deleted successfully!")
        return redirect(reverse('dashboard') + "?page=manage_employee")
    
    return redirect('dashboard')

def add_college(request):
    if request.method == "POST":
        college_id = request.POST.get('college_id')
        college_name = request.POST.get('college_name').strip()
        college_location = request.POST.get('college_location').strip()

        try:
            # Check if a college with the same name (case-insensitive) and location already exists
            existing_college = CollegesDb.objects.filter(
                college_name__iexact=college_name, college_location__iexact=college_location
            ).first()

            if existing_college:
                messages.error(request, "College Already Exists!")
                return redirect(reverse('dashboard') + "?page=manage_college")

            if college_id:  # Update existing college
                college = get_object_or_404(CollegesDb, id=college_id)
                college.college_name = college_name
                college.college_location = college_location
                college.save()
                messages.success(request, "College updated successfully!")
            else:  # Add new college
                college = CollegesDb(
                    college_name=college_name,
                    college_location=college_location
                )
                college.save()
                messages.success(request, "College added successfully!")

            # Redirect to dashboard and open Manage College section
            return HttpResponseRedirect(reverse('dashboard') + "?page=manage_college")

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")
            return redirect(reverse('dashboard') + "?page=manage_college")

    return redirect('dashboard')

def delete_college(request, college_id):
    if request.method == "POST":
        college = get_object_or_404(CollegesDb, id=college_id)
        college.delete()
        messages.success(request, "College deleted successfully!")

        # Redirect to dashboard and open Manage College section
        url = reverse('dashboard') + "?page=manage_college"  # Using reverse to get the URL
        return HttpResponseRedirect(url)  # Proper way to redirect with query params
    
    return redirect('dashboard')

def add_user(request):
    if request.method == "POST":
        user_id = request.POST.get('user_id')
        full_name = request.POST.get('full_name').strip()
        email = request.POST.get("email").strip()
        phone_number = request.POST.get("phone_number").strip()
        college_name = request.POST.get("college_name").strip()
        dob = request.POST.get("dob").strip()
        password = request.POST.get("password").strip()
        referral_code = request.POST.get("referral_code", "N/A").strip()

        try:
            existing_user = UsersDB.objects.filter(email__iexact=email).first()
            if existing_user and not user_id:
                messages.error(request, "A user with this email already exists!")
                return redirect(reverse('dashboard') + "?page=manage_user")

            if user_id:
                # Updating existing user
                user = get_object_or_404(UsersDB, id=user_id)
                user.full_name = full_name
                user.email = email
                user.phone_number = phone_number
                user.college_name = college_name
                user.dob = dob
                user.password = password  # Ideally, hash the password
                user.referral_code = referral_code
                user.save()
                messages.success(request, "User updated successfully!")
            else:
                # Creating a new user
                user = UsersDB(
                    full_name=full_name,
                    email=email,
                    phone_number=phone_number,
                    college_name=college_name,
                    dob=dob,
                    password=password,  # Ideally, hash the password
                    referral_code=referral_code
                )
                user.save()
                messages.success(request, "User added successfully!")

            return redirect(reverse('dashboard') + "?page=manage_user")

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")
            return redirect(reverse('dashboard') + "?page=manage_user")

    return redirect('dashboard')

def delete_user(request, user_id):
    if request.method == "POST":
        user = get_object_or_404(UsersDB, id=user_id)
        user.delete()
        messages.success(request, "User deleted successfully!")
    return redirect(reverse('dashboard') + "?page=manage_user")

def get_subjects(request):
    category_id = request.GET.get('category_id')
    subjects = Subject.objects.filter(subject_category_id=category_id).values('id', 'subject_name')
    return JsonResponse({'subjects': list(subjects)})

def delete_question(request, question_id):
    if request.method == 'POST':
        question = get_object_or_404(Question, id=question_id)
        question.delete()
        messages.success(request, "Question deleted successfully!")
    return redirect('manage_questions')

def add_question(request):
    if request.method == "POST":
        question_id = request.POST.get('question_id')
        question_text = request.POST.get('question_text')
        question_subject_id = request.POST.get('question_subject')

        if not question_text or not question_subject_id:
            messages.error(request, "All fields are required.")
            return redirect('add_question')

        question_subject = get_object_or_404(Subject, id=question_subject_id)

        try:
            if question_id:
                # Update existing question
                question = get_object_or_404(Question, id=question_id)
                question.question_text = question_text
                question.question_subject = question_subject
                question.save()
                messages.success(request, "Question updated successfully!")
            else:
                # Create new question
                question = Question(
                    question_text=question_text,
                    question_subject=question_subject
                )
                question.save()
                messages.success(request, "Question added successfully!")

            return redirect('manage_questions')

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")
            return redirect('add_question')

    return redirect('manage_questions')

def add_student(request):
    if request.method == "POST":
        student_id = request.POST.get("student_id")
        username = request.POST.get("username").strip()
        email = request.POST.get("email").strip()
        domain_id = request.POST.get("domain")
        subject_id = request.POST.get("subject")
        date = request.POST.get("date").strip()
        payment = request.POST.get("payment").strip()

        domain = get_object_or_404(Category, id=domain_id)
        subject = get_object_or_404(Subject, id=subject_id)

        try:
            existing_student = StudentsDB.objects.filter(email__iexact=email).first()
            if existing_student and not student_id:
                messages.error(request, "A student with this email already exists!")
                return redirect(reverse('dashboard') + "?page=manage_student")

            if student_id:
                # Updating existing student
                student = get_object_or_404(StudentsDB, id=student_id)
                student.username = username
                student.email = email
                student.domain = domain
                student.subject = subject
                student.date = date
                student.payment = payment
                student.save()
                messages.success(request, f"Student {username} updated successfully!")
            else:
                # Creating a new student
                StudentsDB.objects.create(
                    username=username,
                    email=email,
                    domain=domain,
                    subject=subject,
                    date=date,
                    payment=payment
                )
                messages.success(request, f"Student {username} added successfully!")

            return redirect(reverse('dashboard') + "?page=manage_student")

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")
            return redirect(reverse('dashboard') + "?page=manage_student")

    return redirect('dashboard')

def delete_student(request, student_id):
    if request.method == "POST":
        student = get_object_or_404(StudentsDB, id=student_id)
        student.delete()
        messages.success(request, "Student deleted successfully!")
    return redirect(reverse('dashboard') + "?page=manage_student")

def add_jobs(request):
    if request.method == "POST":
        print("✅ Form submitted!")  # Debugging
        print("Received Data:", request.POST)  # Check what data is sent

        job_id = request.POST.get('job_id')
        profile = request.POST.get('profile', '').strip()
        company_name = request.POST.get("company_name", "").strip()
        state = request.POST.get("state", "").strip()
        city = request.POST.get("city", "").strip()
        min_experience = request.POST.get("experience_min", "").strip()
        max_experience = request.POST.get("experience_max", "").strip()
        package_min = request.POST.get("package_min", "").strip()
        package_max = request.POST.get("package_max", "").strip()
        employment_types_raw = request.POST.get("employment_types", "").strip()
        about_job = request.POST.get("about_job", "").strip()
        qualification = request.POST.get("qualification", "").strip()
        company_logo = request.FILES.get('company_logo', None)

        print("Profile:", profile)
        print("Company Name:", company_name)
        print("Employment Types:", employment_types_raw)

        if employment_types_raw:
            employment_types = [t.strip() for t in employment_types_raw.split(",")]
        else:
            employment_types = []

        if company_logo:
            valid_extensions = ['.jpg', '.jpeg', '.png', '.gif']
            ext = os.path.splitext(company_logo.name)[1].lower()
            if ext not in valid_extensions:
                messages.error(request, "Invalid file type for logo. Only images are allowed.")
                return redirect(reverse('dashboard') + "?page=manage_jobs")

        try:
            if job_id:
                job = get_object_or_404(Job, id=job_id)
                job.profile = profile
                job.company_name = company_name
                job.location_state = state
                job.location_city = city
                job.min_experience = min_experience
                job.max_experience = max_experience
                job.package_min = package_min
                job.package_max = package_max
                job.employment_types = employment_types
                job.about_job = about_job
                job.qualification = qualification
                if company_logo:
                    job.company_logo = company_logo
                job.save()
                messages.success(request, "Job updated successfully!")
            else:
                Job.objects.create(
                    profile=profile,
                    company_name=company_name,
                    location_state=state,
                    location_city=city,
                    min_experience=min_experience,
                    max_experience=max_experience,
                    package_min=package_min,
                    package_max=package_max,
                    employment_types=employment_types,
                    about_job=about_job,
                    qualification=qualification,
                    company_logo=company_logo
                )
                messages.success(request, "Job added successfully!")

            return redirect(reverse('dashboard') + "?page=manage_jobs")

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")
            print("IntegrityError:", e)  # Debugging
            return redirect(reverse('dashboard') + "?page=manage_jobs")

    return redirect('dashboard')

def delete_job(request, job_id):
    job = get_object_or_404(Job, id=job_id)
    job.delete()
    messages.success(request, "Job deleted successfully!")
    return redirect(reverse('dashboard') + "?page=manage_jobs")