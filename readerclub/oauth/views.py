from django.shortcuts import render, redirect
from django.contrib import messages
from .models import UsersDB, CollegesDb
from django.contrib.auth.hashers import make_password, check_password
from django.db import IntegrityError
from django.contrib.auth import logout, login as auth_login
from django.utils.timezone import now
import logging
from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.contrib.auth.hashers import make_password
from django.utils.timezone import now
import random, time, smtplib
from django.db.models.functions import Lower
from oauth.models import UsersDB, Otpdb
from university.models import University
from django.db.models.functions import Lower  # Add this import

import os
from django.conf import settings
from admin_portal.models import *
# Load environment variables from secrets.env
from topachivers.models import TopAchiever

def home(request):

    colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
    achievers = TopAchiever.objects.all().order_by('name')  # Fetch achievers alphabetically
    context = {
      
        "CAREER_URL": settings.CAREER_URL,
        "achievers": achievers,
        "colleges": colleges
    }
    return render(request, 'index.html', context)

def update_profile(request):
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
        new_college_name = request.POST.get('college_name')
        new_gender = request.POST.get('gender', user.gender)
        new_phone_number = request.POST.get('phone_number', user.phone_number)
        new_email = request.POST.get('email', user.email)

        # Email validation
        if new_email != user.email:
            if UsersDB.objects.filter(email=new_email).exclude(id=user_id).exists():
                messages.error(request, "This email is already registered.")
                return redirect('profile')
        
        if new_college_name:
            try:
                #get the college object based on the name
                new_college = CollegesDb.objects.get(college_name=new_college_name)
                user.college_name = new_college
            except CollegesDb.DoesNotExist:
                # If college doesn't exist, get or create "Not Specified"
                new_college, created = CollegesDb.objects.get_or_create(
                    college_name="Not Specified",
                    defaults={'college_location': 'N/A'}
                )
                user.college_name = new_college

        # Update fields
        user.full_name = new_full_name
        user.course = new_course
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

def profile(request):
    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            # Do not flush the session; instead, redirect to login
            messages.error(request, "Session expired. Please login again.")
            return redirect('/')

    # Use case-insensitive sorting for colleges
    colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
    return render(request, 'profile.html', {'user': user, 'colleges': colleges})

def logout_page(request):
    logout(request)
    messages.success(request, "You have been logged out successfully.", extra_tags='login')
    return redirect('/login/')

def signup(request):
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
            colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
            messages.error(request, "This email is already registered.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup', 'colleges': colleges})

        # Check if the phone number is already registered
        if UsersDB.objects.filter(phone_number=phone_number).exists():
            colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
            messages.error(request, "This phone number is already registered.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup', 'colleges': colleges})

        if len(phone_number) < 10:
            colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
            messages.error(request, "Phone number must be at least 10 digits.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup', 'colleges': colleges})

        if password != re_password:
            colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
            messages.error(request, "Passwords do not match.", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup', 'colleges': colleges})

        # Handle empty college_name
        college = None
        if college_name:
            try:
                college = CollegesDb.objects.get(college_name=college_name)
            except CollegesDb.DoesNotExist:
                colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
                messages.error(request, f"College '{college_name}' not found.", extra_tags='signup')
                return render(request, 'index.html', {'form_type': 'signup', 'colleges': colleges})

        else:
            college, created = CollegesDb.objects.get_or_create(
                college_name="Not Specified",
                defaults={'college_location': 'N/A'}
            )

        hashed_password = make_password(password)
        try:
            new_user = UsersDB.objects.create(
                full_name=full_name,
                email=email,
                phone_number=phone_number,
                password=hashed_password,
                college_name=college,
                dob=dob,
                referral_code=referral_code
            )
        except Exception as e:
            colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
            messages.error(request, f"Error creating account: {str(e)}", extra_tags='signup')
            return render(request, 'index.html', {'form_type': 'signup', 'colleges': colleges})

        colleges = CollegesDb.objects.all().order_by(Lower('college_name'))
        messages.success(request, f"Account created successfully for {new_user.full_name}. Please login.", extra_tags='login')
        return render(request, 'index.html', {'form_type': 'login', 'colleges': colleges})

    # Use case-insensitive sorting for colleges
    colleges = CollegesDb.objects.all().order_by(Lower('college_name'))

    return render(request, 'signup.html', {'colleges': colleges})

def user_login(request):
    if request.method == "POST":
        user_input = request.POST.get('username')
        password = request.POST.get('password')
        next_url = request.GET.get('next', '/')

        user = None
        role = None
        valid_password = False

        # Identify role based on username prefix
        if user_input.startswith("SAD"):
            user = SuperAdminDB.objects.filter(username=user_input).first()
            if user:
                valid_password = check_password(password, user.password)
                role = "superadmin"
            
        elif user_input.startswith("ADM"):
            user = AdminDB.objects.filter(username=user_input).first()
            if user:
                valid_password = check_password(password, user.password)
                role = "admin"

        elif user_input.startswith("MGR"):
            user = ManagerDB.objects.filter(username=user_input).first()
            if user:
                valid_password = check_password(password, user.password)
                role = "manager"

        elif user_input.startswith("EMP"):
            user = EmployeeDB.objects.filter(username=user_input).first()
            if user:
                valid_password = check_password(password, user.password)
                role = "employee"

        elif user_input.startswith("UNI"):
            try:
                user = University.objects.get(username=user_input)
                
                # Use the model's check_password method
                valid_password = user.check_password(password)
                
                if valid_password:
                    role = "university"
                    # Set university-specific session details
                    request.session['user_id'] = user.id
                    request.session['university_id'] = user.id
                    request.session['university_name'] = user.university_name
                    request.session['university_email'] = user.university_email
                    request.session['visited_university_home'] = False
                    
                    # Ensure the session data is saved immediately
                    request.session.modified = True
                    request.session.save()
            except University.DoesNotExist:
                pass
            except Exception:
                pass
            
        else:
            user = UsersDB.objects.filter(email=user_input).first() or \
                   UsersDB.objects.filter(phone_number=user_input).first() or \
                   UsersDB.objects.filter(username=user_input).first()
            if user:
                valid_password = check_password(password, user.password)
                role = "user"

        if user and valid_password:
            # Set session variables
            request.session['user_id'] = user.id
            request.session['role'] = role
            request.session['username'] = user_input  # Store the actual username used to login
            
            # Update last_login if the model has this field
            if hasattr(user, 'last_login'):
                user.last_login = now()
                user.save()
            
            # Set welcome message based on user type
            if role == "university":
                welcome_name = user.university_name
            else:
                welcome_name = getattr(user, 'full_name', user.username)
                
            messages.success(request, f"Welcome back, {welcome_name}!")

            # Ensure session is saved before redirect
            request.session.modified = True
            request.session.save()
            
            # For university users, always redirect to university dashboard
            if role == "university":
                return redirect('/university/')
                
            # Redirect based on role or next URL for other users
            redirect_urls = {
                "superadmin": "/dashboard/",
                "admin": "/adm_dashboard/",
                "manager": "/mgr_dashboard/",
                "employee": "/emp_dashboard/",
                "user": next_url if next_url != '/' else 'home'
            }
            
            return redirect(redirect_urls.get(role, next_url))
        else:
            messages.error(request, "Invalid username or password. Please try again.", extra_tags='login')
            return render(request, 'index.html', {'form_type': 'login'})

    return render(request, 'index.html', {'form_type': 'login'})

def generate_otp(request):
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
    if request.method == "POST":
        recipient_email = request.POST.get("email")
        suspended_emails = request.session.get("suspended_emails", {})
        current_time = time.time()
        if recipient_email in suspended_emails and current_time - suspended_emails[recipient_email] < 120:
            remaining_time = 120 - int(current_time - suspended_emails[recipient_email])
            return JsonResponse({"error": f"Wait {remaining_time} seconds before resending OTP."}, status=429)
        sender_email = os.getenv("EMAIL_HOST_USER")
        sender_password = os.getenv("EMAIL_HOST_PASSWORD")
        sender_name = "Ed. Tech."
        smtp_server = "smtp.gmail.com"
        smtp_port = 587
        subject = "Your OTP Code"
        otp = random.randint(100000, 999999)
        try:
            user = UsersDB.objects.get(email=recipient_email)
            otp_entry, created = Otpdb.objects.get_or_create(user=user)
            otp_entry.update_otp(otp)
        except UsersDB.DoesNotExist:
            return JsonResponse({"message": "User not found"}, status=404)
        body = f"Your OTP code is: {otp}"
        message = f"From: {sender_name} <{sender_email}>\nSubject: {subject}\n\n{body}"
        try:
            server = smtplib.SMTP(smtp_server, smtp_port)
            server.starttls()
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, recipient_email, message)
            server.quit()
            suspended_emails[recipient_email] = current_time
            request.session["suspended_emails"] = suspended_emails
            request.session.modified = True
            return JsonResponse({"message": f"OTP sent to {recipient_email} successfully!"})
        except Exception as e:
            return JsonResponse({"error": "Failed to send email."}, status=500)
    return render(request, "forgot_password.html")

def report_issue(request):
    return render(request, 'report_issue.html')

def refer_friend(request):
    return render(request, 'refer_friend.html')