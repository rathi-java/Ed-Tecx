from django.db import models
from examportol.models import Category, Subject  # Import Category & Subject from examportal app

class StudentsDB(models.Model):
    username = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    domain = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    subject = models.ForeignKey(Subject, on_delete=models.SET_NULL, null=True, blank=True, related_name="students")
    date = models.DateField()
    payment = models.CharField(max_length=20, default="INR 999")

    def __str__(self):
        return self.username
