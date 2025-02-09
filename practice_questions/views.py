from django.shortcuts import render

# Create your views here.
def python_practice(request):
    return render(request, 'questions/python_practice.html')

def java_practice(request):
    return render(request, 'questions/java_practice.html')

def cpp_practice(request):
    return render(request, 'questions/cpp_practice.html')