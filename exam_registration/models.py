from django.db import models
from examportol.models import Category, Subject

class StudentsDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000", unique=True)
    domain = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    subject = models.ForeignKey(Subject, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    date = models.DateField()
    payment = models.CharField(max_length=20, default="INR 999")

    def __str__(self):
        return self.username
