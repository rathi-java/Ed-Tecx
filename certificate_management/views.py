from pyexpat.errors import messages
from django.shortcuts import redirect, render, get_object_or_404
from django.http import HttpResponse
from .models import Certificate
from examportol.models import *
from PIL import Image, ImageDraw, ImageFont
from io import BytesIO
from .models import Certificate
from oauth.models import UsersDB
from django.views.decorators.http import require_POST
from django.contrib import messages



@require_POST
def bulk_update_status(request):
    action = request.POST.get('bulk_action')
    selected_certificates = request.POST.getlist('selected_certificates')

    if not selected_certificates or action == 'none':
        messages.add_message(request, messages.ERROR, "No certificates selected or action chosen.")
        return redirect('certificate_requests_view')

    if action == 'Approved':
        Certificate.objects.filter(id__in=selected_certificates).update(status='Approved')
        messages.add_message(request, messages.SUCCESS, "Selected certificates approved.")
    elif action == 'Rejected':
        Certificate.objects.filter(id__in=selected_certificates).update(status='Rejected')
        messages.add_message(request, messages.SUCCESS, "Selected certificates rejected.")
    elif action == 'Delete':
        Certificate.objects.filter(id__in=selected_certificates).delete()
        messages.add_message(request, messages.SUCCESS, "Selected certificates deleted.")

    return redirect('certificate_requests_view')

# Handle individual delete
@require_POST
def delete_certificate(request, certificate_id):
    certificate = get_object_or_404(Certificate, id=certificate_id)
    certificate.delete()
    messages.add_message(request, messages.SUCCESS, f'Certificate {certificate.unique_id} deleted.')
    return redirect('certificate_requests_view')

def certificate_requests_view(request):
    certificates = Certificate.objects.all().order_by('-created_at')
    return render(request, 'certificate_requests.html', {'certificates': certificates})


@require_POST
def update_certificate_status(request, certificate_id):
    certificate = get_object_or_404(Certificate, id=certificate_id)
    new_status = request.POST.get('status')

    if new_status in dict(Certificate.STATUS_CHOICES):
        certificate.status = new_status
        certificate.save()
        messages.add_message(request, messages.SUCCESS, f'Certificate {certificate.unique_id} status updated to {new_status}.')
    else:
        messages.add_message(request, messages.ERROR, 'Invalid status update.')

    return redirect('certificate_requests_view')


def view_certificate(request, certificate_id):
    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            request.session.flush()
            messages.error(request, "Session expired. Please login again.")
            return redirect('/login/')

    certificate = get_object_or_404(Certificate, id=certificate_id)
    college_name = user.college_name if user else "Unknown College"

    if certificate.certified_for == "Thanks for your participation":
        template_name = 'participate_certificate.html'
    elif certificate.certified_for == "Successful completion":
        template_name = 'completion_certificate.html'
    else:
        messages.error(request, "Invalid certificate type.")
        return redirect('profile_view')

    return render(request, template_name, {
        'certificate': certificate,
        'college': college_name,
        'user': user
    })

def profile_view(request):
    user_id = request.session.get('user_id')
    user = None

    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
        except UsersDB.DoesNotExist:
            request.session.flush()  # Clear session if user not found
            messages.error(request, "Session expired. Please login again.")
            return redirect('/login/') 
    exam_result = ExamResult.objects.filter(user=user).order_by('-submitted_at').first()

    certificates = Certificate.objects.filter(exam_result=exam_result)

    if exam_result and not certificates.exists():
        if exam_result.score >= 70:
            Certificate.objects.create(
                exam_result=exam_result,
                name=user.full_name,
                certified_for="Thanks for your participation",
                status="Pending"
            )
            Certificate.objects.create(
                exam_result=exam_result,
                name=user.full_name,
                certified_for="Successful completion",
                status="Pending"
            )
        else:
            Certificate.objects.create(
                exam_result=exam_result,
                name=user.full_name,
                certified_for="Thanks for your participation",
                status="Ready to download"
            )

    return render(request, 'profile_page.html', {'exam_result': exam_result, 'certificates': certificates})


def download_certificate(request, certificate_id):
    certificate = get_object_or_404(Certificate, id=certificate_id)

    if certificate.status not in ['Approved', 'Ready to download']:
        return HttpResponse("Certificate not available for download.", status=403)

    # Create a blank certificate (adjust size as needed)
    img = Image.new('RGB', (1000, 700), color=(255, 255, 255))  # White background
    draw = ImageDraw.Draw(img)

    try:
        font = ImageFont.truetype("arial.ttf", 40)  # Ensure arial.ttf is available
    except IOError:
        font = ImageFont.load_default()

    # Add certificate details dynamically
    draw.text((100, 150), f"Certificate of Achievement", fill="black", font=font)
    draw.text((100, 250), f"Presented to: {certificate.name}", fill="black", font=font)
    draw.text((100, 300), f"Father's Name: {certificate.father_name}", fill="black", font=font)
    draw.text((100, 350), f"For: {certificate.certified_for}", fill="black", font=font)
    draw.text((100, 400), f"Certificate ID: {certificate.unique_id}", fill="black", font=font)
    draw.text((100, 450), f"Date: {certificate.created_at.strftime('%B %d, %Y')}", fill="black", font=font)

    # Save the certificate to a buffer
    buffer = BytesIO()
    img.save(buffer, format="PNG")
    buffer.seek(0)

    # Serve as response
    response = HttpResponse(buffer, content_type="image/png")
    response["Content-Disposition"] = f'attachment; filename=certificate_{certificate.unique_id}.png'
    return response
