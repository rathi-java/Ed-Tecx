from django.shortcuts import render
from django.shortcuts import render, redirect
from .models import CounsellingEnquiry, AbroadStudiesBtoB
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
    return render(request, 'abroad_studies.html')

def dashboard(request):
    username = request.session.get('username', "Guest")
    
    # Check if the user is authorized
    try:
        abroad_studies_b2b = AbroadStudiesBtoB.objects.get(username=username)
    except AbroadStudiesBtoB.DoesNotExist:
        # Redirect unauthorized users to the home page
        return redirect('home')

    # Filter enquiries by the referral code
    enquiries = CounsellingEnquiry.objects.filter(referral_code=abroad_studies_b2b.referral_code)
    
    # Prepare data for stats
    total_students = len(enquiries)
    approved_students = enquiries.filter(status__status="Approved").count()
    pending_students = enquiries.filter(status__status="Pending").count()
    rejected_students = enquiries.filter(status__status="Rejected").count()

    # Prepare data for the table
    rows = [
        {
            "s_no": idx + 1,
            "name": enquiry.name,
            "email": enquiry.email,
            "phone": enquiry.phone,
            "college": enquiry.college,
            "referral_code": enquiry.referral_code,
            "status": enquiry.status.status if enquiry.status else "Unknown",
        }
        for idx, enquiry in enumerate(enquiries)
    ]

    # Pass data to the template
    context = {
        'abroad_studies_b2b': abroad_studies_b2b,
        'total_students': total_students,
        'approved_students': approved_students,
        'pending_students': pending_students,
        'rejected_students': rejected_students,
        'referral_code': abroad_studies_b2b.referral_code if abroad_studies_b2b else "N/A",
        'rows': rows,
    }
    return render(request, 'abs_dashboard.html', context)