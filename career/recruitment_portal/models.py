from django.db import models
from django.conf import settings

#   Create your models here.
from django.db import models
from django.conf import settings
from django.contrib.auth.hashers import make_password

class Company(models.Model):
    username = models.CharField(max_length=200, unique=True, blank=True, null=True)
    name = models.CharField(max_length=255)
    address = models.TextField()
    email = models.EmailField(unique=True)
    contact_number = models.CharField(max_length=20)
    logo = models.ImageField(upload_to='company_logos/', blank=True, null=True)
    about = models.TextField(max_length=200)
    working_employees = models.IntegerField()
    established_year = models.IntegerField()
    company_code = models.CharField(max_length=6, unique=True, blank=True, null=True)
    industry_type = models.CharField(max_length=255)
    password = models.CharField(max_length=128)  # Store hashed password
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        # Ensure password is hashed
        if not self.password.startswith('pbkdf2_sha256$'):  # Avoid re-hashing an already hashed password
            self.password = make_password(self.password)

        # Generate unique company code
        if not self.company_code:
            last_company = Company.objects.order_by('-id').first()
            new_id = int(last_company.company_code[2:]) + 1 if last_company and last_company.company_code else 1
            self.company_code = f'CO{new_id:04d}'

        # Generate unique username starting with COM0000
        if not self.username:
            last_company = Company.objects.order_by('-id').first()
            new_id = int(last_company.username[3:]) + 1 if last_company and last_company.username else 1
            self.username = f'COM{new_id:04d}'

        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'recuritment_portal_company_details'

class ApplicantDetail(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)  # OAuth User link
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    phone = models.CharField(max_length=20)
    skills = models.TextField()  # List of skills entered by user
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.user.email})"

    class Meta:
        db_table = 'applicant_details'
# ---------------------------
class ApplicantEducation(models.Model):
    applicant = models.ForeignKey(ApplicantDetail, on_delete=models.CASCADE, related_name="educations")
    degree = models.CharField(max_length=255)  # e.g., "B.Tech", "M.Sc"
    specialization = models.CharField(max_length=255, blank=True, null=True)  # e.g., "Computer Science"
    institution = models.CharField(max_length=255)  # e.g., "MIT", "Stanford University"
    passing_year = models.CharField(max_length=4)  # e.g., "2024"
    score = models.CharField(max_length=50, blank=True, null=True)  # e.g., "85%"

    def __str__(self):
        return f"{self.degree} in {self.specialization} from {self.institution}"

    class Meta:
        db_table = 'applicant_education'


# ---------------------------
# JobSeekerExperience Model (Multiple Work Experiences)
# ---------------------------
class ApplicantExperience(models.Model):
    applicant = models.ForeignKey(ApplicantDetail, on_delete=models.CASCADE, related_name="experiences")
    company = models.CharField(max_length=255)  # Company name as text
    role = models.CharField(max_length=255)  # Role/position held
    start_date = models.DateField()
    end_date = models.DateField(blank=True, null=True)  # Leave null if currently employed
    description = models.TextField(blank=True, null=True)  # Job responsibilities or summary
    achievements = models.TextField(blank=True, null=True)  # Optional: achievements or notable contributions

    def __str__(self):
        return f"{self.role} at {self.company}"

    class Meta:
        db_table = 'applicant_experience'

class Domain(models.Model):
    name = models.CharField(max_length=255)
    domain_code = models.CharField(max_length=5, unique=True, blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.domain_code:
            last_domain = Domain.objects.order_by('-id').first()
            new_id = int(last_domain.domain_code[1:]) + 1 if last_domain and last_domain.domain_code else 1
            self.domain_code = f'D{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'company_domain'

class Category(models.Model):
    name = models.CharField(max_length=255, unique=True)
    category_code = models.CharField(max_length=6, unique=True, blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.category_code:
            last_category = Category.objects.order_by('-id').first()
            new_id = int(last_category.category_code[1:]) + 1 if last_category and last_category.category_code else 1
            self.category_code = f'C{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'job_category'