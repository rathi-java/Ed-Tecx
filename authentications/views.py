from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required #only authorised user can access home page
from django.contrib import messages

# Create your views here.
def landing(request):
    return HttpResponse("<h1>This is landing page...! </h1>")

def register_page(request):
    if request.method == "POST":
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        username = request.POST.get('username')
        password = request.POST.get('password')

        #cheack user already exist or not
        user = User.objects.filter(username = username)
        if user.exists():
            messages.info(request, "Username already exist...!")
            return redirect('/register/')

        user = User.objects.create(
            first_name = first_name,
            last_name = last_name,
            username = username  
        )

        # password encreption... for security reason
        user.set_password(password)
        user.save()
        messages.info(request, "Account created successfully...!")
        return redirect('/register/')

    return render(request, 'register.html', context= {'page' : 'Register User'})

def login_page(request):
    if request.method == "POST":
        username = request.POST.get('username')
        password = request.POST.get('password')

        #if username not exist or invalid
        if not User.objects.filter(username = username).exists():
            messages.info(request, "Username not exist...!")
            return redirect('/login/')
        
        #invalid password or invalid credentials
        # agar id and pass correct hai to ye object return krega varna None return krega ye function
        user = authenticate(username = username, password = password)
        if user is None:
            messages.info(request, "Invalid credentials...!")
            return redirect('/login/')
        #if everthing is fine... we need to store in session
        else:
            login(request, user)
            return redirect('/home/')

    return render(request, 'login.html', context={'page' : 'Login User'})

@login_required(login_url='/login/')
def home(request):
    return render(request, 'home.html', context={'page' : 'Home'})

def logout_page(request):
    logout(request)
    return redirect('/login/')