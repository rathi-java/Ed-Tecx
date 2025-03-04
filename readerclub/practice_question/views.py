from django.shortcuts import render
from django.http import Http404
from django.template import TemplateDoesNotExist

#it
def python_practice(request):
    try:
        return render(request, 'it_questions/python_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Python practice page not found")

def java_practice(request):
    try:
        return render(request, 'it_questions/java_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Java practice page not found")

def cpp_practice(request):
    try:
        return render(request, 'it_questions/cpp_practice.html')
    except TemplateDoesNotExist:
        raise Http404("C++ practice page not found")

def html_practice(request):
    try:
        return render(request, 'it_questions/html_practice.html')
    except TemplateDoesNotExist:
        raise Http404("HTML practice page not found")

def css_practice(request):
    try:
        return render(request, 'it_questions/css_practice.html')
    except TemplateDoesNotExist:
        raise Http404("CSS practice page not found")

def javascript_practice(request):
    try:
        return render(request, 'it_questions/javascript_practice.html')
    except TemplateDoesNotExist:
        raise Http404("JavaScript practice page not found")

def dsa_practice(request):
    try:
        return render(request, 'it_questions/dsa_practice.html')
    except TemplateDoesNotExist:
        raise Http404("DSA practice page not found")

def dbms_practice(request):
    try:
        return render(request, 'it_questions/dbms_practice.html')
    except TemplateDoesNotExist:
        raise Http404("DBMS practice page not found")

def sdlc_practice(request):
    try:
        return render(request, 'it_questions/sdlc_practice.html')
    except TemplateDoesNotExist:
        raise Http404("SDLC practice page not found")

def csharp_practice(request):
    try:
        return render(request, 'it_questions/csharp_practice.html')
    except TemplateDoesNotExist:
        raise Http404("C# practice page not found")
    
#base containing it, management, aptitude and coding
    
def practice_questions(request):
    try:
        return render(request, 'practice_questions/practice_questions_index.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
# Management
    
def finance_practice(request):
    try:
        return render(request, 'management_questions/finance_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def marketing_practice(request):
    try:
        return render(request, 'management_questions/marketing_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")

def operations_management_practice(request):
    try:
        return render(request, 'management_questions/operations_management_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def organizational_behaviour_practice(request):
    try:
        return render(request, 'management_questions/organizational_behaviour_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def hospital_administration_practice(request):
    try:
        return render(request, 'management_questions/hospital_administration_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def digital_marketing_practice(request):
    try:
        return render(request, 'management_questions/digital_marketing_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def decision_making_practice(request):
    try:
        return render(request, 'management_questions/decision_making_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def entrepreneurship_practice(request):
    try:
        return render(request, 'management_questions/entrepreneurship_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def corporate_law_practice(request):
    try:
        return render(request, 'management_questions/corporate_law_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def strategic_management_practice(request):
    try:
        return render(request, 'management_questions/strategic_management_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
#Aptitude
    
def abstract_reasoning_practice(request):
    try:
        return render(request, 'aptitude_questions/abstract_reasoning_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def data_interpretation_practice(request):
    try:
        return render(request, 'aptitude_questions/data_interpretation_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def data_sufficiency_practice(request):
    try:
        return render(request, 'aptitude_questions/data_sufficiency_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def general_knowledge_and_current_affairs_practice(request):
    try:
        return render(request, 'aptitude_questions/general_knowledge_and_current_affairs_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def quantitative_practice(request):
    try:
        return render(request, 'aptitude_questions/quantitative_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def reasoning_practice(request):
    try:
        return render(request, 'aptitude_questions/reasoning_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def verbal_ability_practice(request):
    try:
        return render(request, 'aptitude_questions/verbal_ability_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")
    
def coding_practice(request):
    try:
        return render(request, 'coding_questions/coding_practice.html')
    except TemplateDoesNotExist:
        raise Http404("Index page not found")

def demo_test(request):
    return render(request, 'demo_test/demo_test.html')        