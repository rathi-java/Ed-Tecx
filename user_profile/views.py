from django.shortcuts import render

# Create your views here.
def report_issue(request):
    return render(request, 'report_issue.html')

def refer_friend(request):
    return render(request, 'refer_friend.html')