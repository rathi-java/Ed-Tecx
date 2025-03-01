from django import forms
from .models import Subject, Category

class QuestionUploadForm(forms.Form):
    category = forms.ModelChoiceField(queryset=Category.objects.all(), required=True)
    subject = forms.ModelChoiceField(queryset=Subject.objects.all(), required=True)
    file = forms.FileField(required=True)
