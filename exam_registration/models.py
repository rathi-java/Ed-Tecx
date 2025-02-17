from django.db import models
from examportol.models import Category, Subject
import uuid

class StudentsDB(models.Model):
    username = models.CharField(max_length=50, editable=False, unique=True, default=uuid.uuid4)
    full_name = models.CharField(max_length=100, default="Demo")
    email = models.EmailField(max_length=100)
    phone_number = models.CharField(max_length=15,  blank=True, null=True)
    domain = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    subject = models.ForeignKey(Subject, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    date = models.DateField(auto_now_add=True)
    payment = models.CharField(max_length=20, default="INR 999")

    def __str__(self):
        return f"{self.username} - {self.full_name}"

    def save(self, *args, **kwargs):
        if not self.username:
            self.username = uuid.uuid4().hex  # Ensure a long unique UUID
        while StudentsDB.objects.filter(username=self.username).exists():  # Check for uniqueness
            self.username = uuid.uuid4().hex  # Regenerate UUID if not unique
        super().save(*args, **kwargs)
