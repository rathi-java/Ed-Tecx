from django.shortcuts import render

def maintenance_view(request):
    return render(request, 'maintenence.html')