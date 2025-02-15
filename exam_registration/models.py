from django.db import models
from examportol.models import Category, Subject
import uuid

class StudentsDB(models.Model):
    username = models.CharField(max_length=50, unique=True, editable=False, default=uuid.uuid4().hex[:10])
    full_name = models.CharField(max_length=100, default="Demo")
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, unique=True, blank=True, null=True)
    domain = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    subject = models.ForeignKey(Subject, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    date = models.DateField(auto_now_add=True)
    payment = models.CharField(max_length=20, default="INR 999")

    def __str__(self):
        return f"{self.username} - {self.full_name}"
    
    def save(self, *args, **kwargs):
        if not self.username:
            self.username = uuid.uuid4().hex[:10]
        super().save(*args, **kwargs)
