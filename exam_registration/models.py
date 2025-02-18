from django.db import models
from examportol.models import Category, Subject
from oauth.models import UsersDB  # Import your custom user model
import uuid

class StudentsDB(models.Model):
    # Link each exam registration to a user account
    user = models.ForeignKey(UsersDB, on_delete=models.CASCADE, related_name="exam_registrations")
    
    # These fields can be a snapshot at registration time. 
    # (Alternatively, you can remove them and always reference the user.)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100)
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    
    domain = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    subject = models.ForeignKey(Subject, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    
    # If you want to store the registration date as provided (remove auto_now_add if needed)
    date = models.DateField()  
    payment = models.CharField(max_length=20, default="INR 999")
    
    # Use a registration code (or similar) as a unique identifier for each exam registration.
    registration_code = models.CharField(max_length=50, unique=True, editable=False)

    def __str__(self):
        return f"{self.registration_code} - {self.full_name}"

    def save(self, *args, **kwargs):
        if not self.registration_code:
            self.registration_code = uuid.uuid4().hex
        super().save(*args, **kwargs)

