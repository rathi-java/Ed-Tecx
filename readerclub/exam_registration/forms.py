from django import forms
from .models import Exam

class ExamForm(forms.ModelForm):
    class Meta:
        model = Exam
        fields = ['exam_name', 'exam_date', 'exam_time', 'exam_duration', 'exam_subjects', 'exam_category', 'exam_fee']