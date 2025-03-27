from datetime import *
import os
from django.db import IntegrityError
from django.http import HttpResponseBadRequest, HttpResponseRedirect, JsonResponse
from django.shortcuts import render ,redirect ,get_object_or_404
from django.urls import reverse
from admin_portal.models import *
from exam_registration.models import *
from price.models import *
from oauth.models import *
from examportol.models import *
from django.contrib import messages
from django.utils import timezone
from datetime import timedelta
from certificate_management.models import *
from placement_stories.models import *
from django.core.paginator import Paginator
from admin_portal.decorators import role_required
import json

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

@role_required(['superadmin'])
def dashboard(request):
    # Fetch data from the database
    section = request.GET.get('section', 'dashboard')  # Default to 'dashboard'

    user_id = request.session.get('user_id')
    user_role = request.session.get('role')  # Use 'role' instead of 'user_role'
    user = None

    if user_id:
        try:
            if user_role == 'superadmin':
                user = SuperAdminDB.objects.get(id=user_id)
        except Exception:
            user = None
    
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
    certificates = Certificate.objects.all().order_by('-created_at')
    transactions = PaymentTransaction.objects.all().order_by('-created_at')  # Fetch transactions
    exam_results = ExamResult.objects.all().order_by('-submitted_at')  # Fetch exam results
    subscription_plans = SubscriptionPlan.objects.all()  # Fetch subscription plans
    plan_types = PlanType.objects.all()  # Fetch plan types

    # Active users (users who logged in within the last 30 days)
    active_users = UsersDB.objects.filter(last_login__gte=timezone.now() - timedelta(days=30)).count()

    # Other metrics as in your original code
    premium_users = StudentsDB.objects.count()  # Placeholder value for premium users
    total_exams = Exam.objects.count()  # Placeholder value for total exams
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
        "stories": PlacementStories.objects.all(),
        "transactions": transactions,  # Add transactions to context
        "exam_results": exam_results,  # Add exam results to context
        "subscription_plans": subscription_plans,  # Add subscription plans to context
        "plan_types": plan_types,  # Add plan types to context

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
        "total_exams": total_exams,
        "total_sales": total_sales,
        "yearly_sales": yearly_sales,
        "monthly_sales": monthly_sales,
        "weekly_sales": weekly_sales,
        "daily_sales": daily_sales,
        'section': section,
        'user': user,
        'user_role': user_role,  # Add the user role to the context
    }
    return render(request, 'dashboard.html', context)     # return to SuperAdmin Dashboard


@role_required(['superadmin', 'admin'])
def adm_dashboard(request):
    # Fetch data from the database
    section = request.GET.get('section', 'dashboard')  # Default to 'dashboard'

    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = SuperAdminDB.objects.get(id=user_id)
        except SuperAdminDB.DoesNotExist:
            user = None
    
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
    premium_users = StudentsDB.objects.count()  # Placeholder value for premium users
    # premium_users = 0  # Replace with actual logic if applicable

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
        "stories":PlacementStories.objects.all(),

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
        'section': section,
        'user': user,
     
    }
    return render(request, 'adm_dashboard.html', context)

@role_required(['superadmin', 'manager'])
def mgr_dashboard(request):
    # Fetch data from the database
    section = request.GET.get('section', 'dashboard')  # Default to 'dashboard'

    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = SuperAdminDB.objects.get(id=user_id)
        except SuperAdminDB.DoesNotExist:
            user = None
    
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
    premium_users = StudentsDB.objects.count()  # Placeholder value for premium users

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
        "stories":PlacementStories.objects.all(),

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
        'section': section,
        'user': user,
     
    }
    return render(request, 'mgr_dashboard.html', context)

@role_required(['superadmin', 'employee'])
def emp_dashboard(request):
    # Fetch data from the database
    section = request.GET.get('section', 'dashboard')  # Default to 'dashboard'

    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = SuperAdminDB.objects.get(id=user_id)
        except SuperAdminDB.DoesNotExist:
            user = None
    
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
    premium_users = StudentsDB.objects.count()  # Placeholder value for premium users

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
        "stories":PlacementStories.objects.all(),

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
        'section': section,
        'user': user,
     
    }
    return render(request, 'emp_dashboard.html', context)

def manage_admin(request):
    if request.method == "POST":
        action = request.POST.get("action")

        # Handling Add/Edit Admin
        if action == "add_edit":
            admin_id = request.POST.get("admin_id")
            full_name = request.POST.get("admin_full_name")
            email = request.POST.get("admin_email")
            phone_number = request.POST.get("admin_phone_number")
            alt_phone_number = request.POST.get("admin_alt_phone_number")
            password = request.POST.get("password")
            aadhar_number = request.POST.get("admin_aadhar_number")

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

            except IntegrityError as e:
                messages.error(request, f"Error: {e}")
                return redirect("dashboard")

        # Handling Delete Admin
        elif action == "delete":
            admin_id = request.POST.get("admin_id")
            admin = get_object_or_404(AdminDB, id=admin_id)
            admin.delete()
            messages.success(request, "Admin deleted successfully!")

        # Redirect to dashboard and open Manage Admin section
        return HttpResponseRedirect(reverse("dashboard") + "?page=manage_admin")

    return redirect("dashboard")

def manage_manager(request):
    if request.method == "POST":
        action = request.POST.get("action")

        # Handling Add/Edit Manager
        if action == "add_edit":
            manager_id = request.POST.get("manager_id", "").strip()
            full_name = request.POST.get("manager_full_name", "").strip()
            email = request.POST.get("manager_email", "").strip()
            phone_number = request.POST.get("manager_phone_number", "").strip()
            alt_phone_number = request.POST.get("manager_alt_phone_number", "").strip()
            password = request.POST.get("password", "").strip()
            aadhar_number = request.POST.get("manager_aadhar_number", "").strip()

            try:
                if manager_id.isdigit():  # Ensure manager_id is a valid number
                    manager = get_object_or_404(ManagerDB, id=int(manager_id))
                    manager.full_name = full_name
                    manager.email = email
                    manager.phone_number = phone_number
                    manager.alt_phone_number = alt_phone_number
                    manager.password = password
                    manager.aadhar_number = aadhar_number
                    manager.save()
                    messages.success(request, "Manager updated successfully!")
                else:  # Create new manager
                    ManagerDB.objects.create(
                        full_name=full_name,
                        email=email,
                        phone_number=phone_number,
                        alt_phone_number=alt_phone_number,
                        password=password,
                        aadhar_number=aadhar_number
                    )
                    messages.success(request, "Manager added successfully!")
            
            except IntegrityError as e:
                messages.error(request, f"Error: {e}")
                return redirect("dashboard")

        # Handling Delete Manager
        elif action == "delete":
            manager_id = request.POST.get("manager_id", "").strip()
            if manager_id.isdigit():
                manager = get_object_or_404(ManagerDB, id=int(manager_id))
                manager.delete()
                messages.success(request, "Manager deleted successfully!")
            else:
                messages.error(request, "Invalid manager ID!")

        # Redirect to dashboard and open Manage Manager section
        return HttpResponseRedirect(reverse("dashboard") + "?page=manage_manager")

    return redirect("dashboard")

def manage_employee(request):
    if request.method == "POST":
        action = request.POST.get("action")

        # Handling Add/Edit Employee
        if action == "add_edit":
            employee_id = request.POST.get("employee_id")
            full_name = request.POST.get("employee_full_name", "").strip()
            email = request.POST.get("employee_email", "").strip()
            phone_number = request.POST.get("employee_phone_number", "").strip()
            alt_phone_number = request.POST.get("employee_alt_phone_number", "").strip()
            password = request.POST.get("password", "").strip()
            aadhar_number = request.POST.get("employee_aadhar_number", "").strip()

            try:
                if employee_id:
                    employee = get_object_or_404(EmployeeDB, id=employee_id)
                    employee.full_name = full_name
                    employee.email = email
                    employee.phone_number = phone_number
                    employee.alt_phone_number = alt_phone_number
                    employee.password = password
                    employee.aadhar_number = aadhar_number
                    employee.save()
                    messages.success(request, "Employee updated successfully!")
                else:
                    EmployeeDB.objects.create(
                        full_name=full_name,
                        email=email,
                        phone_number=phone_number,
                        alt_phone_number=alt_phone_number,
                        password=password,
                        aadhar_number=aadhar_number
                    )
                    messages.success(request, "Employee added successfully!")
            except IntegrityError as e:
                messages.error(request, f"Error: {e}")
                return HttpResponseRedirect(reverse("dashboard") + "?page=manage_employee")

        # Handling Delete Employee
        elif action == "delete":
            employee_id = request.POST.get("employee_id")
            employee = get_object_or_404(EmployeeDB, id=employee_id)
            employee.delete()
            messages.success(request, "Employee deleted successfully!")

        # Redirect to dashboard and open Manage Employee section
        return HttpResponseRedirect(reverse("dashboard") + "?page=manage_employee")
    
    return redirect("dashboard")

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

def manage_users(request):
    if request.method == "POST":
        action = request.POST.get("action")
        user_id = request.POST.get('user_id')
        
        if action == "add_or_update":
            full_name = request.POST.get('full_name').strip()
            email = request.POST.get("email").strip()
            phone_number = request.POST.get("phone_number").strip()
            college_name = request.POST.get("college_name").strip()
            dob = request.POST.get("dob").strip()
            password = request.POST.get("password").strip()
            referral_code = request.POST.get("referral_code", "N/A").strip()
            
            try:
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
                    if UsersDB.objects.filter(email__iexact=email).exists():
                        messages.error(request, "A user with this email already exists!")
                    else:
                        UsersDB.objects.create(
                            full_name=full_name,
                            email=email,
                            phone_number=phone_number,
                            college_name=college_name,
                            dob=dob,
                            password=password,  # Ideally, hash the password
                            referral_code=referral_code
                        )
                        messages.success(request, "User added successfully!")
            except IntegrityError as e:
                messages.error(request, f"Error: {e}")
            
        elif action == "delete":
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
        student_id = request.POST.get("student_id", "").strip()
        full_name = request.POST.get("full_name", "").strip()
        email = request.POST.get("email", "").strip()
        domain_id = request.POST.get("domain", "").strip()
        subject_id = request.POST.get("subject", "").strip()
        payment = request.POST.get("payment", "").strip()

        # 🔹 Generate username if not provided
        username = request.POST.get("username", "").strip()
        if not username and full_name:
            username = full_name.lower().replace(" ", "_")  # Example: "John Doe" → "john_doe"
        elif not username:
            username = f"user_{str(uuid.uuid4())[:8]}"  # Example: "user_abc12345"

        if not full_name or not email:
            messages.error(request, "Full Name and Email are required.")
            return redirect(reverse('dashboard') + "?page=manage_student")

        domain = get_object_or_404(Category, id=domain_id) if domain_id else None
        subject = get_object_or_404(Subject, id=subject_id) if subject_id else None

        try:
            existing_student = StudentsDB.objects.filter(email__iexact=email).first()
            if existing_student and not student_id:
                messages.error(request, "A student with this email already exists!")
                return redirect(reverse('dashboard') + "?page=manage_student")

            if student_id:
                # Updating existing student
                student = get_object_or_404(StudentsDB, id=student_id)
                student.username = username  # ✅ Assign username
                student.full_name = full_name
                student.email = email
                student.domain = domain
                student.subject = subject
                student.payment = payment
                student.save()
                messages.success(request, f"Student {full_name} updated successfully!")
            else:
                # Creating a new student
                StudentsDB.objects.create(
                    username=username,  # ✅ Assign username
                    full_name=full_name,
                    email=email,
                    domain=domain,
                    subject=subject,
                    payment=payment
                )
                messages.success(request, f"Student {full_name} added successfully!")

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

def update_superadmin_profile(request):
    if request.method == "POST":
        user_id = request.session.get('user_id')
        if not user_id:
            messages.error(request, "Session expired. Please log in again.")
            return redirect('/dashboard/?section=profile')

        try:
            user = SuperAdminDB.objects.get(id=user_id)
        except SuperAdminDB.DoesNotExist:
            messages.error(request, "SuperAdmin not found.")
            return redirect('/dashboard/?section=profile')

        user.full_name = request.POST.get('full_name', user.full_name)
        user.phone_number = request.POST.get('phone_number', user.phone_number)
        user.save()

        messages.success(request, "Profile updated successfully!")
        return redirect('/dashboard/?section=profile')

    messages.error(request, "Invalid request method.")
    return redirect('/dashboard/?section=profile')

def get_superadmin_profile(request):
    user_id = request.session.get('user_id')
    if user_id:
        try:
            user = SuperAdminDB.objects.get(id=user_id)
            return JsonResponse({
                "full_name": user.full_name,
                "email": user.email,
                "phone_number": user.phone_number,
            })
        except SuperAdminDB.DoesNotExist:
            return JsonResponse({"error": "User not found"}, status=404)
    return JsonResponse({"error": "Not logged in"}, status=401)   

def add_placement_story(request):
    if request.method == "POST":
        story_id = request.POST.get("story_id", "").strip()
        name = request.POST.get("name", "").strip()
        company_name = request.POST.get("company_name", "").strip()
        designation = request.POST.get("designation", "").strip()
        package = request.POST.get("package", "").strip()
        batch = request.POST.get("batch", "").strip()
        degree = request.POST.get("degree", "").strip()
        branch = request.POST.get("branch", "").strip()
        description = request.POST.get("description", "").strip()
        user_profile_pic = request.FILES.get("user_profile_pic")
        hand_written_review = request.FILES.get("hand_written_review")

        if not name or not company_name:
            messages.error(request, "Name and Company are required.")
            return redirect(reverse('dashboard') + "?page=manage_placement_stories")

        try:
            if story_id:
                # Updating existing placement story
                story = get_object_or_404(PlacementStories, id=story_id)
                story.name = name
                story.company_name = company_name
                story.designation = designation
                story.package = package
                story.batch = batch
                story.degree = degree
                story.branch = branch
                story.description = description

                # Only update images if new ones are provided
                if user_profile_pic:
                    story.user_profile_pic = user_profile_pic
                if hand_written_review:
                    story.hand_written_review = hand_written_review
                
                story.save()
                messages.success(request, f"Placement story for {name} updated successfully!")
            else:
                # Creating a new placement story
                PlacementStories.objects.create(
                    name=name,
                    company_name=company_name,
                    designation=designation,
                    package=package,
                    batch=batch,
                    degree=degree,
                    branch=branch,
                    description=description,
                    user_profile_pic=user_profile_pic,
                    hand_written_review=hand_written_review
                )
                messages.success(request, f"Placement story for {name} added successfully!")

            return redirect(reverse('dashboard') + "?page=manage_placement_stories")

        except IntegrityError as e:
            messages.error(request, f"Error: {e}")
            return redirect(reverse('dashboard') + "?page=manage_placement_stories")

    return redirect('dashboard')

def delete_placement_story(request, story_id):
    if request.method == "POST":
        story = get_object_or_404(PlacementStories, id=story_id)
        story.delete()
        messages.success(request, "Placement story deleted successfully!")
    return redirect(reverse('dashboard') + "?page=manage_placement_stories")

def manage_subscription(request):
    if request.method == "POST":
        action = request.POST.get("action")

        if action == "add_subscription":
            plan_type_id = request.POST.get("plan_type_id")
            price = request.POST.get("price")
            duration_in_months = request.POST.get("duration_in_months")
            features = request.POST.get("features", "{}")  # Default to '{}'
            discount = request.POST.get("discount", "0")

            # Ensure features is a valid JSON object
            try:
                features = json.loads(features)  # Convert string to JSON
            except json.JSONDecodeError:
                features = {}  # Default to empty JSON if invalid

            SubscriptionPlan.objects.create(
                plan_type_id=plan_type_id,
                price=price,
                duration_in_months=duration_in_months,
                features=features,
                discount=discount,
            )
            messages.success(request, "Subscription plan added successfully!")
            return redirect("manage_subscription")

    plans = SubscriptionPlan.objects.all()
    plan_types = PlanType.objects.all()
    return render(request, "admin_portal/manage_subscription.html", {"plans": plans, "plan_types": plan_types})

def delete_subscription_plan(request, plan_id):
    """Handles deleting a subscription plan."""
    plan = get_object_or_404(SubscriptionPlan, id=plan_id)
    plan.delete()
    messages.success(request, "Subscription plan deleted successfully!")
    return redirect("manage_subscription")

def subscription_management(request):
    """Handles managing subscription plans (not user subscriptions)."""
    
    if request.method == "POST":
        action = request.POST.get("action")

        if action == "add_subscription":
            plan_type_id = request.POST.get("plan_type_id")
            price = request.POST.get("price")
            duration = request.POST.get("duration_in_months")
            features = request.POST.get("features")
            discount = request.POST.get("discount")

            if plan_type_id and price and duration:
                SubscriptionPlan.objects.create(
                    plan_type_id=plan_type_id,
                    price=price,
                    duration_in_months=duration,
                    features=features,
                    discount=discount
                )
                messages.success(request, "Subscription plan added successfully!")

        elif action == "edit_subscription":
            plan_id = request.POST.get("plan_id")
            plan = get_object_or_404(SubscriptionPlan, id=plan_id)
            plan.price = request.POST.get("price")
            plan.duration_in_months = request.POST.get("duration_in_months")
            plan.features = request.POST.get("features")
            plan.discount = request.POST.get("discount")
            plan.save()
            messages.success(request, "Subscription plan updated successfully!")

        elif action == "delete_subscription":
            plan_id = request.POST.get("plan_id")
            plan = get_object_or_404(SubscriptionPlan, id=plan_id)
            plan.delete()
            messages.success(request, "Subscription plan deleted successfully!")

        return redirect("manage_subscription")

    plans = SubscriptionPlan.objects.all()
    return render(request, "sub_templates/subscription_management.html", {"plans": plans})


def price_management(request):
    """Handles managing Subscription Plans."""
    
    if request.method == "POST":
        action = request.POST.get("action")
        
        if action == "add_price":
            plan_type_id = request.POST.get("plan_type")
            price = request.POST.get("price")
            duration_in_months = request.POST.get("duration_in_months")
            features = request.POST.get("features")  # Assuming JSON input
            discount = request.POST.get("discount")

            if plan_type_id and price:
                plan_type = get_object_or_404(PlanType, id=plan_type_id)
                SubscriptionPlan.objects.create(
                    plan_type=plan_type,
                    price=price,
                    duration_in_months=duration_in_months,
                    features=features,
                    discount=discount
                )
                messages.success(request, "Subscription Plan added successfully!")

        elif action == "edit_price":
            plan_id = request.POST.get("plan_id")
            plan = get_object_or_404(SubscriptionPlan, id=plan_id)
            plan.price = request.POST.get("price")
            plan.duration_in_months = request.POST.get("duration_in_months")
            plan.features = request.POST.get("features")
            plan.discount = request.POST.get("discount")
            plan.save()
            messages.success(request, "Subscription Plan updated successfully!")

        elif action == "delete_price":
            plan_id = request.POST.get("plan_id")
            plan = get_object_or_404(SubscriptionPlan, id=plan_id)
            plan.delete()
            messages.success(request, "Subscription Plan deleted successfully!")

        return redirect("manage_price")

    plans = SubscriptionPlan.objects.all()
    plan_types = PlanType.objects.all()
    return render(request, "sub_templates/price_management.html", {
        "plans": plans,
        "plan_types": plan_types
    })







def manage_plan_types(request):
    if request.method == "POST":
        action = request.POST.get("action")

        if action == "add_or_edit":
            plan_id = request.POST.get("plan_id")
            code = request.POST.get("code")
            display_name = request.POST.get("display_name")

            if plan_id:  # Update Existing Plan
                plan = get_object_or_404(PlanType, id=plan_id)
                plan.code = code
                plan.display_name = display_name
                plan.save()
            else:  # Create New Plan
                PlanType.objects.create(code=code, display_name=display_name)

            return redirect("manage_plan_types")

        elif action == "delete":
            plan_id = request.POST.get("plan_id")
            plan = get_object_or_404(PlanType, id=plan_id)
            plan.delete()
            return redirect("manage_plan_types")

    plan_types = PlanType.objects.all()
    return render(request, "sub_templates/manage_plan_types.html", {"plan_types": plan_types})

def manage_subscription_plans(request):
    if request.method == "POST":
        action = request.POST.get("action")

        if action == "add_or_edit":
            plan_id = request.POST.get("plan_id")
            plan_type_id = request.POST.get("plan_type_id")
            price = request.POST.get("price")
            duration_in_months = request.POST.get("duration_in_months")
            discount = request.POST.get("discount")
            features = request.POST.get("features")

            plan_type = get_object_or_404(PlanType, id=plan_type_id)

            if plan_id:  # Update Existing Plan
                plan = get_object_or_404(SubscriptionPlan, id=plan_id)
                plan.plan_type = plan_type
                plan.price = price
                plan.duration_in_months = duration_in_months
                plan.discount = discount
                plan.features = json.loads(features)  
                plan.save()
            else:  # Create New Plan
                # Find the highest order number
                max_order = SubscriptionPlan.objects.aggregate(max_order=models.Max("order"))["max_order"] or 0
                SubscriptionPlan.objects.create(
                    plan_type=plan_type,
                    price=price,
                    duration_in_months=duration_in_months,
                    discount=discount,
                    features=json.loads(features),
                    order=max_order + 1  # New plan gets the highest order
                )

            return redirect(reverse('dashboard') + "?page=manage_subscription_plans")

        elif action == "delete":
            plan_id = request.POST.get("plan_id")
            plan = get_object_or_404(SubscriptionPlan, id=plan_id)
            plan.delete()
            return redirect(reverse('dashboard') + "?page=manage_subscription_plans")

    subscription_plans = SubscriptionPlan.objects.select_related("plan_type").order_by("order")
    plan_types = PlanType.objects.all()

    return render(request, "sub_templates/manage_subscription_plan.html", {"subscription_plans": subscription_plans, "plan_types": plan_types})

def reorder_subscription_plans(request):
    if request.method == "POST":
        plan_id = request.POST.get("plan_id")
        direction = request.POST.get("direction")
        plan = get_object_or_404(SubscriptionPlan, id=plan_id)

        # Get all plans ordered by current order
        all_plans = list(SubscriptionPlan.objects.order_by("order"))

        # Find the index of the current plan
        index = all_plans.index(plan)

        if direction == "up" and index > 0:
            # Swap with the one above
            above_plan = all_plans[index - 1]
            plan.order, above_plan.order = above_plan.order, plan.order
            plan.save()
            above_plan.save()

        elif direction == "down" and index < len(all_plans) - 1:
            # Swap with the one below
            below_plan = all_plans[index + 1]
            plan.order, below_plan.order = below_plan.order, plan.order
            plan.save()
            below_plan.save()

        messages.success(request, "Subscription plan order updated successfully.")
    
    return redirect(reverse('dashboard') + "?page=manage_subscription_plans")

def toggle_subscription_status(request):
    if request.method == "POST":
        plan_id = request.POST.get("plan_id")
        current_status = request.POST.get("current_status") == "True"  # Convert to boolean
        plan = get_object_or_404(SubscriptionPlan, id=plan_id)
        plan.is_active = not current_status  # Toggle the status
        plan.save()
        messages.success(request, "Subscription plan status updated successfully.")
    # return redirect("manage_subscription_plans")  # Redirect to the same page
    return redirect(reverse('dashboard') + "?page=manage_subscription_plans")

# def create_exam(request):
#     categories = Category.objects.all()
#     subjects = Subject.objects.all()
#     questions = Question.objects.all()
    
#     selected_category_ids = []
#     selected_subject_ids = []
#     selected_question_ids = request.GET.getlist('questions')

#     if request.method == 'POST':
#         name = request.POST.get('name')
#         duration = request.POST.get('duration')
#         question_ids = request.POST.getlist('questions')
#         category_ids = request.POST.getlist('categories')
#         subject_ids = request.POST.getlist('subjects')

#         if not name or not duration or not question_ids:
#             messages.error(request, "Please fill all required fields")
#             return redirect('create_exam')

#         exam = Exam.objects.create(name=name, duration=duration)
        
#         # Assign selected questions, categories, and subjects
#         exam.questions.add(*Question.objects.filter(id__in=question_ids))
#         exam.categories.add(*Category.objects.filter(id__in=category_ids))
#         exam.subjects.add(*Subject.objects.filter(id__in=subject_ids))

#         messages.success(request, f"Exam '{name}' created successfully!")
#         return redirect('list_exams')

#     else:
#         # Apply filters if selected
#         if 'categories' in request.GET:
#             selected_category_ids = request.GET.getlist('categories')
#             questions = questions.filter(question_subject__subject_category_id__in=selected_category_ids)
#             subjects = Subject.objects.filter(subject_category_id__in=selected_category_ids)

#         if 'subjects' in request.GET:
#             selected_subject_ids = request.GET.getlist('subjects')
#             questions = questions.filter(question_subject_id__in=selected_subject_ids)

#         # Include previously selected questions in the list
#         extra_questions = Question.objects.filter(id__in=selected_question_ids)
#         questions = list(set(questions) | set(extra_questions))

#     context = {
#         'categories': categories,
#         'subjects': subjects,
#         'questions': questions,
#         'selected_category_ids': selected_category_ids,
#         'selected_subject_ids': selected_subject_ids,
#         'selected_question_ids': selected_question_ids,
#     }
    
#     return render(request, 'dashboard.html', context)

# def list_exams(request):
#     user_id = request.session.get('user_id')
#     user = None

#     if user_id:
#         try:
#             user = UsersDB.objects.get(id=user_id)
#         except UsersDB.DoesNotExist:
#             request.session.flush()
#             messages.error(request, "Session expired. Please login again.")
#             return redirect('/login/')
    
#     if user and StudentsDB.objects.filter(email=user.email, exam_domain__isnull=False).exists():
#         registered_exam_ids = StudentsDB.objects.filter(email=user.email).values_list('exam_domain_id', flat=True)
#         exams = Exam.objects.filter(id__in=registered_exam_ids)
#     else:
#         exams = Exam.objects.all()
    
#     return render(request, 'dashboard.html', {'exams': exams, 'user': user})
#         # return render(request, 'dashboard.html')

# def delete_exam(request, exam_id):
#     if request.method == "POST":
#         try:
#             exam = Exam.objects.get(id=exam_id)
#             exam.delete()
#             messages.success(request, "Exam deleted successfully.")
#         except Exam.DoesNotExist:
#             messages.error(request, "Exam not found.")
#     return redirect('list_exams')

# import logging

# logger = logging.getLogger(__name__)

# def transfer_manager(request, manager_id, new_admin_id):
#     if request.method == "POST":
#         logger.info(f"Received Manager Transfer Request: Manager ID={manager_id}, New Admin ID={new_admin_id}")
#         manager = get_object_or_404(ManagerDB, id=manager_id)
#         new_admin = get_object_or_404(AdminDB, id=new_admin_id)
#         manager.admin = new_admin
#         manager.save()
#         logger.info(f"Manager {manager.username} successfully updated to Admin {new_admin.username}")
#         messages.success(request, f"Manager {manager.username} transferred to Admin {new_admin.username} successfully!")
#     return redirect(reverse('dashboard') + "?page=manage_manager")

# def transfer_employee(request, employee_id, new_manager_id):
#     if request.method == "POST":
#         logger.info(f"Received Employee Transfer Request: Employee ID={employee_id}, New Manager ID={new_manager_id}")
#         employee = get_object_or_404(EmployeeDB, id=employee_id)
#         new_manager = get_object_or_404(ManagerDB, id=new_manager_id)
#         employee.manager = new_manager
#         employee.save()
#         logger.info(f"Employee {employee.username} successfully updated to Manager {new_manager.username}")
#         messages.success(request, f"Employee {employee.username} transferred to Manager {new_manager.username} successfully!")
#     return redirect(reverse('dashboard') + "?page=manage_employee")

# def transfer_admin(request, admin_id, new_superadmin_id):
#     if request.method == "POST":
#         logger.info(f"Received Admin Transfer Request: Admin ID={admin_id}, New SuperAdmin ID={new_superadmin_id}")
#         admin = get_object_or_404(AdminDB, id=admin_id)
#         new_superadmin = get_object_or_404(SuperAdminDB, id=new_superadmin_id)
#         admin.superadmin = new_superadmin
#         admin.save()
#         logger.info(f"Admin {admin.username} successfully updated to SuperAdmin {new_superadmin.username}")
#         messages.success(request, f"Admin {admin.username} transferred to SuperAdmin {new_superadmin.username} successfully!")
#     return redirect(reverse('dashboard') + "?page=manage_admin")

# def transfer_manager(request, manager_id, new_admin_id):
#     # Check if the manager_id is valid
#     if manager_id == 0:
#         return HttpResponseBadRequest("Invalid Manager ID")
    
#     # Check if new_admin_id is valid
#     if new_admin_id == 0:
#         return HttpResponseBadRequest("Invalid Admin ID")

#     # Fetch Manager and Admin objects safely
#     manager = get_object_or_404(ManagerDB, id=manager_id)
#     new_admin = get_object_or_404(AdminDB, id=new_admin_id)
    
#     # Transfer the manager to the new admin
#     manager.admin = new_admin
#     manager.save()

#     return redirect('manage_manager')
