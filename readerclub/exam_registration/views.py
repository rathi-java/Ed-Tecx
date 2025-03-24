from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from .models import StudentsDB
from examportol.models import Exam
from oauth.models import PaymentTransaction, UsersDB
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
import hashlib
import time
import logging

logger = logging.getLogger(__name__)

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import uuid

@csrf_exempt
def create_exam_order(request):
    """
    Create a payment order for exam registration.
    """
    if request.method == "POST":
        try:
            # Get the user from the session
            user_id = request.session.get('user_id')
            if not user_id:
                return JsonResponse({"status": "error", "message": "User not found in session."})

            user = UsersDB.objects.get(id=user_id)

            # Get the selected exam from the POST request
            exam_id = request.POST.get("exam_id")
            if not exam_id:
                return JsonResponse({"status": "error", "message": "Exam not selected."})

            exam = Exam.objects.get(id=exam_id)

            # Store the exam ID in the session for later use
            request.session['selected_exam_id'] = exam_id

            # Return success response with exam details
            return JsonResponse({
                "status": "success",
                "message": "Exam selected successfully.",
                "exam_id": exam_id,
                "exam_name": exam.name,
                "amount": exam.price,
            })

        except UsersDB.DoesNotExist:
            return JsonResponse({"status": "error", "message": "User not found."})
        except Exam.DoesNotExist:
            return JsonResponse({"status": "error", "message": "Exam not found."})
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)})

    return JsonResponse({"status": "error", "message": "Invalid request method."})


@csrf_exempt
def handle_exam_payment_success(request):
    """
    Handle successful payment for exam registration.
    """
    if request.method == "POST":
        try:
            # Extract payment details from the request
            payment_id = request.POST.get("payment_id")
            order_id = request.POST.get("order_id")
            amount = request.POST.get("amount")
            gateway = request.POST.get("gateway")

            # Get the user from the session
            user_id = request.session.get('user_id')
            if not user_id:
                return JsonResponse({"status": "error", "message": "User not found in session."})

            user = UsersDB.objects.get(id=user_id)

            # Get the selected exam from the session
            exam_id = request.session.get('selected_exam_id')
            if not exam_id:
                return JsonResponse({"status": "error", "message": "Exam not selected."})

            exam = Exam.objects.get(id=exam_id)

            # Create a new entry in StudentsDB
            student = StudentsDB(
                user=user,
                username=user.username,
                full_name=user.full_name,
                email=user.email,
                phone_number=user.phone_number,
                exam_domain=exam,
                payment=f"INR {amount}",
                registration_code=str(uuid.uuid4())[:12]  # Generate a unique registration code
            )
            student.save()

            # Store payment transaction details in the existing PaymentTransaction model
            transaction = PaymentTransaction(
                user=user,
                exam=exam,
                subscription_plan=None,  # Set to None since this is an exam payment
                order_id=order_id,
                payment_id=payment_id,
                amount=amount,
                currency="INR",
                status="success"
            )
            transaction.save()

            # Clear the selected exam ID from the session
            if 'selected_exam_id' in request.session:
                del request.session['selected_exam_id']

            # Return success response
            return JsonResponse({
                "status": "success",
                "message": "Registration successful! Proceed for the Exam.",
                "student_id": student.studentId,
                "registration_code": student.registration_code
            })

        except UsersDB.DoesNotExist:
            return JsonResponse({"status": "error", "message": "User not found."})
        except Exam.DoesNotExist:
            return JsonResponse({"status": "error", "message": "Exam not found."})
        except Exception as e:
            logger.error(f"Payment processing error: {str(e)}")
            return JsonResponse({"status": "error", "message": str(e)})

    return JsonResponse({"status": "error", "message": "Invalid request method."})

def get_user_from_session(request):
    """Helper function to get user from session"""
    try:
        user_id = request.session.get('user_id')
        if user_id:
            return UsersDB.objects.get(id=user_id)
        return None
    except UsersDB.DoesNotExist:
        logger.error(f"UsersDB not found for user_id: {user_id}")
        request.session.flush()
        return None
    except Exception as e:
        logger.error(f"Error getting user from session: {str(e)}")
        return None

def exam_home(request):
    user = get_user_from_session(request)
    return render(request, "exam_home.html", {"user": user})

def exam_register(request):
    user = get_user_from_session(request)
    if not user:
        logger.warning("User not found in session during exam registration attempt")
        messages.error(request, "You need to log in to register for an exam.")
        return redirect('/login/')

    # Query all available exams for registration
    exams = Exam.objects.all()

    if request.method == "POST":
        try:
            # Collect form data
            full_name = request.POST.get("full_name", "").strip()
            email = request.POST.get("email", "").strip()
            phone_number = request.POST.get("phone_number", "").strip()
            exam_id = request.POST.get("exam_domain")  # This will hold the selected exam ID
            payment = "INR 999.00"

            # Validate required fields
            if not all([full_name, email, phone_number, exam_id]):
                messages.error(request, "All fields are required.")
                return redirect("exam_register")

            if exam_id == "":
                messages.error(request, "Please select a valid exam.")
                return redirect("exam_register")

            # Check if user is already registered for this exam
            if StudentsDB.objects.filter(user=user, exam_domain_id=exam_id).exists():
                messages.error(request, "Already registered for this exam.")
                return redirect("exam_register")

            # Retrieve the exam from the database
            exam = Exam.objects.get(id=exam_id)

            # Create a new registration
            student = StudentsDB.objects.create(
                user=user,
                username=user.username,
                full_name=full_name,
                email=email,
                phone_number=phone_number,
                exam_domain=exam,
                payment=payment
            )

            # Store registration data in session for later use
            request.session['registered_exam'] = exam.id
            request.session['student_id'] = student.studentId
            request.session['selected_exam_id'] = exam_id
            request.session.save()

            logger.info(f"Successful exam registration for user {user.username}")
            messages.success(request, f"Registration successful! Your Student ID is {student.studentId}.")
            return redirect("exam_home")

        except ObjectDoesNotExist:
            logger.error("Invalid exam selected during registration")
            messages.error(request, "Invalid exam selected.")
            return redirect("exam_register")
        except Exception as e:
            logger.error(f"Error during exam registration: {str(e)}")
            messages.error(request, f"An error occurred while registering: {str(e)}")
            return redirect("exam_register")

    return render(request, "exam_registration.html", {
        "exams": exams,
        "user": user
    })

def exam_resisteration_success(request):
    user = get_user_from_session(request)
    if not user:
        logger.warning("User not found in session during exam registration success check")
        messages.error(request, "User not found. Please log in again.")
        return redirect('/login/')

    try:
        # Get latest registration for the user
        registration = StudentsDB.objects.filter(user=user).last()
        if registration and registration.exam_domain:
            request.session['registered_exam'] = registration.exam_domain.id
            request.session.save()
            logger.info(f"Successfully retrieved registration for user {user.username}")
            return redirect('instructions')

        logger.warning(f"No registration found for user {user.username}")
        messages.error(request, "Registration record not found. Please register for the exam.")
        return redirect("exam_register")

    except Exception as e:
        logger.error(f"Error in exam registration success: {str(e)}")
        messages.error(request, "An error occurred. Please try again.")
        return redirect("exam_register")

def generate_hash(data, salt):
    """Generate SHA-512 hash using PayU format."""
    hash_sequence = "|".join([
        data["key"], 
        data["txnid"], 
        str(data["amount"]), 
        data["productinfo"],
        data["firstname"], 
        data["email"], 
        data.get("udf1", ""), 
        data.get("udf2", ""),
        data.get("udf3", ""), 
        data.get("udf4", ""), 
        data.get("udf5", ""),
        "", "", "", "", "",  # Empty fields for udf6-udf10
        salt
    ])
    return hashlib.sha512(hash_sequence.encode("utf-8")).hexdigest().lower()

@csrf_exempt
def initiate_payu_payment(request):
    if request.method == "POST":
        try:
            user_id = request.session.get('user_id')
            if not user_id:
                return JsonResponse({"status": "error", "message": "User not found in session."})

            user = UsersDB.objects.get(id=user_id)
            exam_id = request.session.get('selected_exam_id')
            if not exam_id:
                return JsonResponse({"status": "error", "message": "Exam not selected."})

            exam = Exam.objects.get(id=exam_id)

            payu_mode = getattr(settings, 'PAYU_MODE', 'test')
            payu_url = "https://test.payu.in/_payment" if payu_mode == "test" else "https://secure.payu.in/_payment"
            payu_key = settings.PAYU_KEY
            payu_salt = settings.PAYU_SALT

            txnid = f"TXN{int(time.time())}"
            amount = exam.price
            productinfo = f"Exam Registration: {exam.name}"
            firstname = user.full_name
            email = user.email
            phone = user.phone_number
            scheme = request.is_secure() and "https" or "http"
            host = request.get_host()
            success_url = f"{scheme}://{host}/payu_exam_success/"
            failure_url = f"{scheme}://{host}/payu_exam_failure/"

            payu_data = {
                "key": payu_key,
                "txnid": txnid,
                "amount": amount,
                "productinfo": productinfo,
                "firstname": firstname,
                "email": email,
                "phone": phone,
                "surl": success_url,
                "furl": failure_url,
                "udf1": exam_id,
                "udf2": "",
                "udf3": "",
                "udf4": "",
                "udf5": ""
            }

            payu_data["hash"] = generate_hash(payu_data, payu_salt)

            return render(request, "redirect_to_payu.html", {
                "payu_url": payu_url,
                "payu_data": payu_data
            })

        except Exception as e:
            logger.error(f"Error initiating PayU payment: {str(e)}")
            return JsonResponse({"status": "error", "message": str(e)})

    return JsonResponse({"status": "error", "message": "Invalid request method."})

@csrf_exempt
def payu_exam_success(request):
    if request.method == "POST":
        # Log the request
        logger.info("Received PayU success callback for Exam Payment")
        logger.info(f"PayU Callback Data: {request.POST}")
        
        try:
            txnid = request.POST.get('txnid')
            amount = request.POST.get("amount", "").strip()
            status = request.POST.get('status')
            mihpayid = request.POST.get('mihpayid')
            exam_id = request.POST.get('udf1')

            # Debugging statements
            logger.info(f"Transaction ID: {txnid}")
            logger.info(f"Amount: {amount}")
            logger.info(f"Status: {status}")
            logger.info(f"Payment ID: {mihpayid}")
            logger.info(f"Exam ID: {exam_id}")

            if status.lower() == 'success' and exam_id:
                try:
                    exam = Exam.objects.get(id=exam_id)
                except ObjectDoesNotExist:
                    logger.warning(f"Invalid Exam ID: {exam_id}")
                    return HttpResponse("Invalid Exam ID. Please check the exam details.")

                user_id = request.session.get('user_id')
                if user_id:
                    try:
                        user = UsersDB.objects.get(id=user_id)
                    except ObjectDoesNotExist:
                        logger.warning(f"User not found: {user_id}")
                        return HttpResponse("User not found. Please log in again.")

                    # Register student
                    registration_code = str(uuid.uuid4())[:12]
                    student = StudentsDB.objects.create(
                        user=user,
                        username=user.username,
                        full_name=user.full_name,
                        email=user.email,
                        phone_number=user.phone_number,
                        exam_domain=exam,
                        payment=f"INR {amount}",
                        registration_code=registration_code
                    )
                    
                    # Store payment transaction details
                    PaymentTransaction.objects.create(
                        user=user,
                        exam=exam,
                        subscription_plan=None,
                        order_id=txnid,
                        payment_id=mihpayid,
                        amount=amount,
                        currency="INR",
                        status="success"
                    )

                    messages.success(request, "Payment successful!")
                    return render(request, "exam_payment_success.html", {
                        "message": "Payment successful!",
                        "student_id": student.studentId,
                        "registration_code": registration_code
                    })
                else:
                    logger.error("User session not found.")
                    messages.error(request, "User session not found.")
                    return HttpResponse("Login krle phle")
            else:
                logger.warning(f"Payment status issue: {status}")
                messages.error(request, f"Payment status: {status}")
                return HttpResponse("Status mai dikkat aagye bhai")
        except Exception as e:
            logger.error(f"Error processing PayU success: {str(e)}", exc_info=True)
            messages.error(request, "Error processing payment. Please contact support.")
            return HttpResponse(f"Kuch toh gadbad hai processing mai: {str(e)}")
    else:
        return redirect("exam_home")
    
@csrf_exempt
def payu_exam_failure(request):
    if request.method == "POST":
        error_message = request.POST.get('error_Message', 'Payment failed')
        txnid = request.POST.get('txnid', 'Unknown')
        logger.error(f"PayU payment failed: txnid={txnid}, error={error_message}")
        return render(request, "payment_failure.html", {
            "error": error_message,
            "txnid": txnid
        })

    return redirect("exam_home")