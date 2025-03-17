from django.db import models

class CounsellingEnquiry(models.Model):
    name = models.CharField(max_length=200)
    phone = models.CharField(max_length=20)
    email = models.EmailField()
    college = models.CharField(max_length=200)
    referral_code = models.CharField(max_length=50, blank=True)
    submitted_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} - {self.email}"
