from django.shortcuts import render, redirect
from django.contrib import messages
from .models import *
from django.contrib.auth.hashers import make_password, check_password
from django.db import IntegrityError
from django.contrib.auth import logout
from django.utils.timezone import now

def profile(request):
    user_id = request.session.get('user_id')  # Fetch user_id from session
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
    logout(request)  # This will clear the session
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
                return redirect('signup')

            if password != re_password:
                messages.error(request, "Passwords do not match.")
                return redirect('signup')

            if len(phone_number) < 10:
                messages.error(request, "Phone number must be at least 10 digits.")
                return redirect('signup')

            # Check if the email or phone number already exists
            if UsersDB.objects.filter(email=email).exists():
                messages.error(request, "This email is already registered.")
                return redirect('signup')

            if UsersDB.objects.filter(phone_number=phone_number).exists():
                messages.error(request, "This phone number is already registered.")
                return redirect('signup')

            try:
                college = CollegesDb.objects.get(college_name=college_name)
            except CollegesDb.DoesNotExist:
                messages.error(request, f"College '{college_name}' not found.")
                return redirect('signup')

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
                return redirect('signup')

            messages.success(request, f"Account created successfully for {new_user.full_name}. Please login.")
            return redirect('login')

        except Exception as e:
            messages.error(request, f"Error: {str(e)}")
            return redirect('signup')

    colleges = CollegesDb.objects.all()
    return render(request, 'signup.html', {'colleges': colleges})

def user_login(request):
    if request.method == "POST":
        user_input = request.POST.get('username')
        password = request.POST.get('password')

        # Try to fetch the user using email, phone number, or username
        user = None
        if UsersDB.objects.filter(email=user_input).exists():
            user = UsersDB.objects.get(email=user_input)
        elif UsersDB.objects.filter(phone_number=user_input).exists():
            user = UsersDB.objects.get(phone_number=user_input)
        elif UsersDB.objects.filter(username=user_input).exists():
            user = UsersDB.objects.get(username=user_input)

        if user and check_password(password, user.password):  # Check password
            # Set session for user login
            request.session['user_id'] = user.id

            # Update last login time
            user.last_login = now()
            user.save()

            messages.success(request, f"Welcome back, {user.full_name}!")
            return redirect('/')
        else:
            messages.error(request, "Invalid username or password. Please try again.")
            return redirect('/login/')

    return render(request, 'login.html')
