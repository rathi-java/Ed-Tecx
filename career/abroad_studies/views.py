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
    
    # Get organization information
    try:
        organization = AbroadStudiesBtoB.objects.get(username=username)
    except AbroadStudiesBtoB.DoesNotExist:
        organization = None
    
    # Filter enquiries by the organization's referral code
    if organization:
        enquiries = CounsellingEnquiry.objects.filter(referral_code=organization.referral_code)
    else:
        enquiries = []
    
    # Dynamically get field names from the model
    fields = []
    for field in CounsellingEnquiry._meta.get_fields():
        # Skip ManyToOneRel fields that are auto-created by Django
        if field.is_relation and not field.concrete:
            continue
        if field.name == 'id':
            continue
        fields.append(field)
    
    # Prepare headers
    headers = []
    field_names = []
    for field in fields:
        # Get field name
        field_name = field.name
        field_names.append(field_name)
        
        # Format header name (capitalize and replace underscores with spaces)
        header = field_name.replace('_', ' ').title()
        headers.append(header)
    
    # Prepare data rows
    rows = []
    for enquiry in enquiries:
        row = []
        for field_name in field_names:
            value = getattr(enquiry, field_name)
            # Format special fields
            if field_name == 'status':
                value = value.status if value else "Unknown"
            elif field_name == 'submitted_at':
                value = value.strftime("%Y-%m-%d %H:%M")
            row.append(value)
        rows.append(row)
    
    context = {
        'organization': organization,
        'headers': headers,
        'rows': rows,
        'username': username
    }
    
    return render(request, 'abroadStudiesdashboard.html', context)