from django.db import models
from django.contrib.auth.hashers import make_password

class Enquirystatus(models.Model):
    status = models.CharField(max_length=200)
    def __str__(self):
        return self.status
    class Meta:
        db_table = "EnquiryStatus"

class CounsellingEnquiry(models.Model):
    name = models.CharField(max_length=200)
    phone = models.CharField(max_length=20)
    email = models.EmailField()
    college = models.CharField(max_length=200)
    referral_code = models.CharField(max_length=50, blank=True)
    status = models.ForeignKey(Enquirystatus, on_delete=models.SET_NULL, default=1, null=True)
    price = models.CharField(max_length=250)
    submitted_at = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return f"{self.name} - {self.email}"
    class Meta:
        db_table = "CounsellingEnquiries"

class AbroadStudiesBtoB(models.Model):
    username = models.CharField(max_length=200)
    name = models.CharField(max_length=200)
    email = models.EmailField()
    phone = models.CharField(max_length=20)
    address = models.CharField(max_length=100)
    referral_code = models.CharField(max_length=50, blank=True, unique=True)
    revenue = models.CharField(max_length=50)
    no_of_students = models.CharField(max_length=50)
    submitted_at = models.DateTimeField(auto_now_add=True)
    password = models.CharField(max_length=128)  # Increase max_length for hashed passwords
    def __str__(self):
        return f"{self.name} - {self.email}"
    class Meta:
        db_table = "AbroadStudiesBtoB"
    def save(self, *args, **kwargs):
        if self.password and not self.password.startswith('pbkdf2_'):  # Check if password is already hashed
            self.password = make_password(self.password)  # Hash the password
        if not self.username:  # Auto-generate username if not provided
            last_user = AbroadStudiesBtoB.objects.order_by('-id').first()
            if last_user and last_user.username.startswith("ABS"):
                last_number = int(last_user.username[3:])
                new_id = f"ABS{last_number + 1:05d}"
            else:
                new_id = "ABS00001"
            self.username = new_id
        super().save(*args, **kwargs)
