from django import forms
from .models import CounsellingEnquiry

class CounsellingEnquiryForm(forms.ModelForm):
    class Meta:
        model = CounsellingEnquiry
        fields = ['name', 'phone', 'email', 'college', 'referral_code']
        widgets = {
            'name': forms.TextInput(attrs={'placeholder': 'Enter your name'}),
            'phone': forms.TextInput(attrs={'placeholder': 'Enter your phone number'}),
            'email': forms.EmailInput(attrs={'placeholder': 'Enter your email'}),
            'college': forms.TextInput(attrs={'placeholder': 'Enter your college'}),
            'referral_code': forms.TextInput(attrs={'placeholder': 'Enter Referral Code'}),
        }
