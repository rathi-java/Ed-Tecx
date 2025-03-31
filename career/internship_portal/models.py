from django.db import models
from django.conf import settings
from recruitment_portal.models import Company, ApplicantDetail, Category



class Internship(models.Model):
    internship_id = models.AutoField(primary_key=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    company = models.ForeignKey(Company, on_delete=models.CASCADE)
    role = models.CharField(max_length=255)
    responsibilities = models.TextField()
    duration = models.CharField(max_length=50)  # Example: '3 Months'
    stipend = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)  # Optional stipend
    required_skills = models.TextField()
    openings = models.IntegerField()
    internship_code = models.CharField(max_length=6, unique=True, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.internship_code:
            last_internship = Internship.objects.last()
            new_id = int(last_internship.internship_code[1:]) + 1 if last_internship and last_internship.internship_code else 1
            self.internship_code = f'I{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.role} at {self.company.name}"

    class Meta:
        db_table = 'internship_portal_internship'



class InternshipApplication(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    applicantdetail = models.ForeignKey(ApplicantDetail, on_delete=models.CASCADE)
    internship = models.ForeignKey(Internship, on_delete=models.CASCADE)
    skills = models.TextField()
    cover_letter = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.applicantdetail.first_name} {self.applicantdetail.last_name} - {self.internship.role}"

    class Meta:
        db_table = 'internship_portal_application'
