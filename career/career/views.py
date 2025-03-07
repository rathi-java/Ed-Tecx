from django.shortcuts import render
from django.http import HttpResponse

def maintenance_view(request):
    return render(request, 'maintenence.html')