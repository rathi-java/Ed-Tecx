from django.shortcuts import render, redirect
from django.contrib import messages
from .models import UsersDB, CollegesDb
from django.contrib.auth.hashers import make_password, check_password
from django.db import IntegrityError
from django.contrib.auth import logout, login as auth_login
from django.utils.timezone import now
import logging

logger = logging.getLogger(__name__)
def home(request):
    return render(request, 'index.html')

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

        new_full_name = request.POST.get('full_name')
        new_course = request.POST.get('course')
        new_dob = request.POST.get('dob')
        new_college = request.POST.get('college_name')
        new_gender = request.POST.get('gender')

        if new_full_name:
            user.full_name = new_full_name
        if new_course:
            user.course = new_course
        if new_dob:
            user.dob = new_dob
        if new_college:
            user.college_name = new_college
        if new_gender:
            user.gender = new_gender

        user.save()
        messages.success(request, "Profile updated successfully!")
        return redirect('profile')
    else:
        messages.error(request, "Invalid request method.")
        return redirect('profile')


def profile(request):
    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            request.session.flush()  # Clear session if user not found
            messages.error(request, "Session expired. Please login again.")
            return redirect('/login/')

    return render(request, 'profile.html', {'user': user})


def home(request):
    return render(request, 'index.html')


def logout_page(request):
    logout(request)
    messages.success(request, "You have been logged out successfully.")
    return redirect('/')


def signup(request):
    if request.method == "POST":
        try:
            full_name = request.POST.get('full_name')
            email = request.POST.get('email')
            phone_number = request.POST.get('phone_number')
            password = request.POST.get('password')
            re_password = request.POST.get('re_password')
            college_name = request.POST.get('college_name')
            dob = request.POST.get('dob')
            referral_code = request.POST.get('referral_code')

            if not all([full_name, email, phone_number, password, re_password, college_name, dob]):
                messages.error(request, "All fields are required.")
                return render(request, 'index.html', {'form_type': 'signup'})

            if password != re_password:
                messages.error(request, "Passwords do not match.")
                return render(request, 'index.html', {'form_type': 'signup'})

            if len(phone_number) < 10:
                messages.error(request, "Phone number must be at least 10 digits.")
                return render(request, 'index.html', {'form_type': 'signup'})

            if UsersDB.objects.filter(email=email).exists():
                messages.error(request, "This email is already registered.")
                return render(request, 'index.html', {'form_type': 'signup'})

            if UsersDB.objects.filter(phone_number=phone_number).exists():
                messages.error(request, "This phone number is already registered.")
                return render(request, 'index.html', {'form_type': 'signup'})

            try:
                college = CollegesDb.objects.get(college_name=college_name)
            except CollegesDb.DoesNotExist:
                messages.error(request, f"College '{college_name}' not found.")
                return render(request, 'index.html', {'form_type': 'signup'})

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
            except IntegrityError as e:
                if 'email' in str(e):
                    messages.error(request, "This email is already registered.")
                elif 'phone_number' in str(e):
                    messages.error(request, "This phone number is already registered.")
                else:
                    messages.error(request, "A user with this username already exists.")
                return render(request, 'index.html', {'form_type': 'signup'})

            # Show success & automatically open login pop-up for best UX
            messages.success(request, f"Account created successfully for {new_user.full_name}. Please login.")
            return render(request, 'index.html', {'form_type': 'login'})

        except Exception as e:
            messages.error(request, f"Error: {str(e)}")
            return render(request, 'index.html', {'form_type': 'signup'})

    # If GET, show a full separate signup page, if you want
    colleges = CollegesDb.objects.all()
    return render(request, 'signup.html', {'colleges': colleges})

def user_login(request):
    if request.method == "POST":
        user_input = request.POST.get('username')
        password = request.POST.get('password')

        user = None
        if UsersDB.objects.filter(email=user_input).exists():
            user = UsersDB.objects.get(email=user_input)
        elif UsersDB.objects.filter(phone_number=user_input).exists():
            user = UsersDB.objects.get(phone_number=user_input)
        elif UsersDB.objects.filter(username=user_input).exists():
            user = UsersDB.objects.get(username=user_input)

        if user and check_password(password, user.password):
            user.backend = 'django.contrib.auth.backends.ModelBackend'  # Specify the backend
            auth_login(request, user)
            request.session['user_id'] = user.id
            request.session.save()
            logger.info(f"User {user.id} logged in, session saved")
            user.last_login = now()
            user.save()
            messages.success(request, f"Welcome back, {user.full_name}!")
            return redirect('/')
        else:
            messages.error(request, "Invalid username or password. Please try again.")
            return render(request, 'index.html', {'form_type': 'login'})

    return render(request, 'login.html')