from django.db import models
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
    name = models.CharField(max_length=200)
    email = models.EmailField()
    phone = models.CharField(max_length=20)
    address = models.CharField(max_length=100)
    referral_code = models.CharField(max_length=50, blank=True, unique=True)
    revenue = models.CharField(max_length=50)
    no_of_students = models.CharField(max_length=50)
    submitted_at = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return f"{self.name} - {self.email}"
    class Meta:
        db_table = "AbroadStudiesBtoB"