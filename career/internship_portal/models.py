from django.db import models
from django.conf import settings

class InternshipCategory(models.Model):
    name = models.CharField(max_length=255, unique=True)
    category_code = models.CharField(max_length=6, unique=True, blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.category_code:
            last_category = InternshipCategory.objects.order_by('-id').first()
            new_id = int(last_category.category_code[1:]) + 1 if last_category and last_category.category_code else 1
            self.category_code = f'I{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'internship_portal_category'


class InternshipCompany(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField()
    email = models.EmailField(unique=True)
    contact_number = models.CharField(max_length=20)
    logo = models.ImageField(upload_to='internship_company_logos/', blank=True, null=True)
    about = models.TextField(max_length=200)
    established_year = models.IntegerField()
    company_code = models.CharField(max_length=6, unique=True, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.company_code:
            last_company = InternshipCompany.objects.order_by('-id').first()
            new_id = int(last_company.company_code[2:]) + 1 if last_company and last_company.company_code else 1
            self.company_code = f'IC{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'internship_portal_company'


class Internship(models.Model):
    internship_id = models.AutoField(primary_key=True)
    category = models.ForeignKey(InternshipCategory, on_delete=models.CASCADE)
    company = models.ForeignKey(InternshipCompany, on_delete=models.CASCADE)
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


class InternshipSeeker(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    phone = models.CharField(max_length=20)
    skills = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.user.email})"

    class Meta:
        db_table = 'internship_portal_seeker'


class InternshipApplication(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    seeker = models.ForeignKey(InternshipSeeker, on_delete=models.CASCADE)
    internship = models.ForeignKey(Internship, on_delete=models.CASCADE)
    skills = models.TextField()
    cover_letter = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.seeker.first_name} {self.seeker.last_name} - {self.internship.role}"

    class Meta:
        db_table = 'internship_portal_application'
