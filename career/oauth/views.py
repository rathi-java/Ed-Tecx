# career/oauth/views.py

import os
import random
import time
import smtplib
from datetime import date
from dotenv import load_dotenv

from django.shortcuts import render, redirect
from django.contrib import messages
from django.http import JsonResponse
from django.db import IntegrityError
from django.contrib.auth.hashers import make_password, check_password
from django.contrib.auth import logout
from django.utils.timezone import now

# If you need these (for role-based login) import them:
# from admin_portal.models import SuperAdminDB, AdminDB, ManagerDB, EmployeeDB

from oauth.models import UsersDB, Otpdb, CollegesDb

load_dotenv("secrets.env")


def home(request):
    """Basic homepage view."""
    return render(request, 'index.html')


def profile(request):
    """
    Display user profile info based on role (user/company/abroad_studies).
    """
    user_id = request.session.get('user_id')
    role = request.session.get('role')
    user = None
    company_details = None
    abroad_studies_details = None

    if user_id:
        try:
            if role == "company":
                from recruitment_portal.models import Company
                company_details = Company.objects.get(id=user_id)
            elif role == "abroad_studies":
                from abroad_studies.models import AbroadStudiesBtoB
                abroad_studies_details = AbroadStudiesBtoB.objects.get(id=user_id)
            else:
                from oauth.models import UsersDB
                user = UsersDB.objects.get(id=user_id)
        except (UsersDB.DoesNotExist, Company.DoesNotExist, AbroadStudiesBtoB.DoesNotExist):
            request.session.flush()
            messages.error(request, "Session expired. Please login again.")
            return redirect('/')
    
    return render(request, 'profile.html', {
        'user': user,
        'company': company_details,
        'abroad_studies': abroad_studies_details,
        'role': role
    })

def update_profile(request):
    """
    Update user profile fields like full_name, course, dob, email, etc.
    """
    if request.method == "POST":
        user_id = request.session.get('user_id')
        if not user_id:
            messages.error(request, "You must be logged in to update your profile.")
            return redirect('login')

        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            messages.error(request, "User not found. Please log in again.")
            return redirect('login')

        # Get form data with fallbacks to current values
        new_full_name = request.POST.get('full_name', user.full_name)
        new_course = request.POST.get('course', user.course)
        new_dob = request.POST.get('dob', user.dob)
        new_college = request.POST.get('college_name', user.college_name)
        new_gender = request.POST.get('gender', user.gender)
        new_phone_number = request.POST.get('phone_number', user.phone_number)
        new_email = request.POST.get('email', user.email)

        # Email validation
        if new_email != user.email:
            if UsersDB.objects.filter(email=new_email).exclude(id=user_id).exists():
                messages.error(request, "This email is already registered.")
                return redirect('profile')

        # Update fields
        user.full_name = new_full_name
        user.course = new_course
        user.college_name = new_college
        user.gender = new_gender
        user.phone_number = new_phone_number
        user.email = new_email

        # Handle date of birth (may be empty)
        if new_dob:
            try:
                user.dob = new_dob
            except (ValueError, TypeError):
                messages.warning(request, "Invalid date format. Date of birth was not updated.")

        try:
            user.save()
            messages.success(request, "Profile updated successfully!")
        except Exception as e:
            messages.error(request, f"Error updating profile: {str(e)}")

        return redirect('profile')
    else:
        # Redirect to profile page if not a POST request
        return redirect('profile')


def logout_page(request):
    """
    Logs the user out by clearing the session.
    """
    logout(request)  # Clears the authenticated session
    request.session.flush()  # Clears all session data
    messages.success(request, "You have been logged out successfully.", extra_tags='login')
    return redirect('/login/')


def report_issue(request):
    """
    Simple view for reporting an issue.
    """
    return render(request, 'report_issue.html')


def refer_friend(request):
    """
    Simple view for referring a friend.
    """
    return render(request, 'refer_friend.html')


def signup(request):
    """
    Create a new user account in UsersDB.
    """
    if request.method == "POST":
        full_name = request.POST.get('full_name')
        email = request.POST.get('email')
        phone_number = request.POST.get('phone_number')
        password = request.POST.get('password')
        re_password = request.POST.get('re_password')
        college_name = request.POST.get('college_name')
        dob = request.POST.get('dob')
        referral_code = request.POST.get('referral_code')

        # Check if the email is already registered
        if UsersDB.objects.filter(email=email).exists():
            messages.error(request, "This email is already registered.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup'})

        # Check if the phone number is already registered
        if UsersDB.objects.filter(phone_number=phone_number).exists():
            messages.error(request, "This phone number is already registered.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup'})

        if len(phone_number) < 10:
            messages.error(request, "Phone number must be at least 10 digits.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup'})

        if password != re_password:
            messages.error(request, "Passwords do not match.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup'})

        # Ensure the college exists in CollegesDb
        try:
            college_obj = CollegesDb.objects.get(college_name=college_name)
        except CollegesDb.DoesNotExist:
            messages.error(request, f"College '{college_name}' not found.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup'})

        # Hash the password
        hashed_password = make_password(password)

        # Save the user
        try:
            new_user = UsersDB.objects.create(
                full_name=full_name,
                email=email,
                phone_number=phone_number,
                password=hashed_password,
                college_name=college_obj.college_name,
                dob=dob,
                referral_code=referral_code
            )
        except Exception as e:
            messages.error(request, f"Error creating account: {str(e)}", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup'})

        messages.success(
            request,
            f"Account created successfully for {new_user.full_name}. Please login.",
            extra_tags='login'
        )
        return render(request, 'index.html', {'form_type': 'login'})

    # If GET, show the signup page with a list of colleges
    colleges = CollegesDb.objects.all()
    return render(request, 'signup.html', {'colleges': colleges})


def user_login(request):
    """
    Logs a user in using either email, phone_number, or username from UsersDB.
    Redirects to Abroad Studies if username starts with "ABS".
    """
    if request.method == "POST":
        user_input = request.POST.get('username')
        password = request.POST.get('password')

        user = None
        role = None
        valid_password = False

        # Check if the username starts with "ABS"
        if user_input.startswith("ABS"):
            from abroad_studies.models import AbroadStudiesBtoB
            user = AbroadStudiesBtoB.objects.filter(username=user_input).first()
            if user:
                valid_password = check_password(password, user.password)
                role = "abroad_studies"

        # Check if the username starts with "COM" (Company login)
        elif user_input.startswith("COM"):
            from recruitment_portal.models import Company
            user = Company.objects.filter(username=user_input).first()
            if user:
                valid_password = check_password(password, user.password)
                role = "company"
                # Set company-specific session details
                request.session['company_id'] = user.id
                request.session['company_name'] = user.name
                request.session['company_email'] = user.email

        # Check for normal user login
        else:
            user = (
                UsersDB.objects.filter(email=user_input).first() or
                UsersDB.objects.filter(phone_number=user_input).first() or
                UsersDB.objects.filter(username=user_input).first()
            )
            if user:
                valid_password = check_password(password, user.password)
                role = "user"

        if user and valid_password:
            # Set session variables
            request.session['user_id'] = user.id
            request.session['username'] = user.username
            request.session['role'] = role  # Store role in session

            # Update last login
            user.last_login = now()
            user.save()

            # Redirect based on role
            redirect_urls = {
                "abroad_studies": "/abroad-studies/dashboard/",  # Replace with the actual dashboard URL
                "user": "home",
                "company": "/recruitment-portal/"  # Redirect company users to their dashboard
            }
            return redirect(redirect_urls.get(role, '/'))
        else:
            messages.error(request, "Invalid username or password. Please try again.", extra_tags='login')
            return render(request, 'index.html', {'form_type': 'login'})

    # If GET, show the login form
    return render(request, 'index.html', {'form_type': 'login'})


def generate_otp(request):
    """
    Step 1: Generate an OTP for the user's email and store it in Otpdb.
    """
    if request.method == "POST":
        email = request.POST.get("email")
        try:
            user = UsersDB.objects.get(email=email)
        except UsersDB.DoesNotExist:
            return JsonResponse({"message": "User not found"}, status=404)

        otp = random.randint(100000, 999999)
        otp_entry, created = Otpdb.objects.get_or_create(user=user)
        otp_entry.update_otp(otp)

        return JsonResponse({"message": "OTP sent", "otp": otp})
    return render(request, "password_reset.html")


def verify_otp(request):
    """
    Step 2: Verify the OTP the user entered.
    """
    if request.method == "POST":
        email = request.POST.get("email")
        entered_otp = request.POST.get("otp")

        try:
            entered_otp = int(entered_otp)
        except (ValueError, TypeError):
            return JsonResponse({"message": "Invalid OTP format", "status": "error"}, status=400)

        try:
            user = UsersDB.objects.get(email=email)
            otp_entry = Otpdb.objects.get(user=user)
        except (UsersDB.DoesNotExist, Otpdb.DoesNotExist):
            return JsonResponse({"message": "Invalid OTP request", "status": "error"}, status=400)

        is_valid, message = otp_entry.verify_otp(entered_otp)
        if is_valid:
            request.session["otp_verified"] = email
            return JsonResponse({"message": message, "status": "success"})
        return JsonResponse({"message": message, "status": "error"})
    return redirect("generate_otp")


def reset_password(request):
    """
    Step 3: Reset the user's password after OTP is verified.
    """
    if request.method == "POST":
        email = request.POST.get("email")
        new_password = request.POST.get("new_password")
        confirm_password = request.POST.get("confirm_password")

        if not email or not new_password or not confirm_password:
            return JsonResponse({"message": "All fields are required."}, status=400)

        if new_password != confirm_password:
            return JsonResponse({"message": "Passwords do not match."}, status=400)

        try:
            user = UsersDB.objects.get(email=email)
            user.password = make_password(new_password)
            user.save()
            return JsonResponse({"message": "Password reset Successful"})
        except UsersDB.DoesNotExist:
            return JsonResponse({"message": "User not found."}, status=404)

    return JsonResponse({"message": "Invalid request method."}, status=405)


def send_email(request):
    """
    Sends an OTP to a given user’s email (if they exist).
    Prevents re-sending within 120 seconds using session-based throttling.
    """
    if request.method == "POST":
        recipient_email = request.POST.get("email")
        suspended_emails = request.session.get("suspended_emails", {})
        current_time = time.time()

        # Throttle check: wait 120s before resending to the same email
        if (recipient_email in suspended_emails
                and current_time - suspended_emails[recipient_email] < 120):
            remaining_time = 120 - int(current_time - suspended_emails[recipient_email])
            return JsonResponse({"error": f"Wait {remaining_time} seconds before resending OTP."}, status=429)

        sender_email = os.getenv("EMAIL_HOST_USER")
        sender_password = os.getenv("EMAIL_HOST_PASSWORD")
        sender_name = "Ed. Tech."
        smtp_server = "smtp.gmail.com"
        smtp_port = 587
        subject = "Your OTP Code"

        otp = random.randint(100000, 999999)

        # Update or create the OTP entry
        try:
            user = UsersDB.objects.get(email=recipient_email)
            otp_entry, created = Otpdb.objects.get_or_create(user=user)
            otp_entry.update_otp(otp)
        except UsersDB.DoesNotExist:
            return JsonResponse({"message": "User not found"}, status=404)

        # Email body
        body = f"Your OTP code is: {otp}"
        message = f"From: {sender_name} <{sender_email}>\nSubject: {subject}\n\n{body}"

        # Attempt to send
        try:
            server = smtplib.SMTP(smtp_server, smtp_port)
            server.starttls()
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, recipient_email, message)
            server.quit()

            # Throttle logic
            suspended_emails[recipient_email] = current_time
            request.session["suspended_emails"] = suspended_emails
            request.session.modified = True

            return JsonResponse({"message": f"OTP sent to {recipient_email} successfully!"})
        except Exception as e:
            print("Error:", str(e))
            return JsonResponse({"error": "Failed to send email."}, status=500)

    return render(request, "forgot_password.html")