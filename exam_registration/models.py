from django.db import models
from examportol.models import Category, Subject
from oauth.models import UsersDB
import uuid

class StudentsDB(models.Model):
    user = models.ForeignKey(UsersDB, on_delete=models.CASCADE, related_name="students", null=True, blank=True)  # Allow null values temporarily
    username = models.CharField(max_length=100)
    studentId = models.CharField(max_length=50, unique=True, blank=True)  # Remove default
    full_name = models.CharField(max_length=100)
    email = models.CharField(max_length=255, default="default@example.com")
    phone_number = models.CharField(max_length=15)
    domain = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    subject = models.ForeignKey(Subject, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    payment = models.CharField(max_length=20, default="INR 999")
    registration_code = models.CharField(max_length=50, unique=True, editable=False, blank=True)

    def save(self, *args, **kwargs):
        # Generate Student ID if not already assigned
        if not self.studentId or self.studentId == "TEMP_STUDENT_ID":
            last_student = StudentsDB.objects.order_by('-id').first()
            if last_student and last_student.studentId.startswith("STD"):
                last_number = int(last_student.studentId[3:])
                new_id = f"STD{last_number + 1:05d}"
            else:
                new_id = "STD00001"
            
            self.studentId = new_id
        
        # Generate a unique registration code if not already assigned
        if not self.registration_code or self.registration_code == "DEFAULT_REG_CODE":
            self.registration_code = str(uuid.uuid4())[:12]

        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.studentId} - {self.full_name}"
