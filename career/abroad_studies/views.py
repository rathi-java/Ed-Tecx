from django.shortcuts import render
from django.shortcuts import render, redirect
from .models import CounsellingEnquiry
from django.contrib import messages
# Create your views here.
def abroad_studies(request):
    return render(request, 'abroad_studies.html')
def enquiry_view(request):
    if request.method == 'POST':
        # Get form data
        name = request.POST.get('name')
        phone = request.POST.get('phone')
        email = request.POST.get('email')
        college = request.POST.get('college')
        referral_code = request.POST.get('referral_code', '')
        
        # Create and save a new enquiry
        enquiry = CounsellingEnquiry(
            name=name,
            phone=phone,
            email=email,
            college=college,
            referral_code=referral_code
        )
        enquiry.save()
        
        # Add a success message
        messages.success(request, "Thank you for your enquiry. We'll contact you soon!")
        
        # Redirect to a thank you page or back to the form
        return redirect('abroad_studies')  # or 'home' or wherever you want to redirect
    
    # If not POST, just render the form page
    return render(request, 'your_template.html')