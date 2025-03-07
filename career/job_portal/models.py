from django.db import models

class Category(models.Model):
    name = models.CharField(max_length=255, unique=True)
    category_code = models.CharField(max_length=5, unique=True, blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.category_code:
            last_category = Category.objects.order_by('-id').first()
            new_id = int(last_category.category_code[1:]) + 1 if last_category and last_category.category_code else 1
            self.category_code = f'C{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Company(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField()
    email = models.EmailField(unique=True)
    contact_number = models.CharField(max_length=20)
    logo = models.ImageField(upload_to='company_logos/', blank=True, null=True)
    about = models.TextField(max_length=200)
    working_employees = models.IntegerField()
    established_year = models.IntegerField()
    company_code = models.CharField(max_length=5, unique=True, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.company_code:
            last_company = Company.objects.order_by('-id').first()
            new_id = int(last_company.company_code[2:]) + 1 if last_company and last_company.company_code else 1
            self.company_code = f'CO{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Job(models.Model):
    job_id = models.AutoField(primary_key=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    company = models.ForeignKey(Company, on_delete=models.CASCADE)
    role = models.CharField(max_length=255)
    responsibilities = models.TextField()
    position = models.CharField(max_length=255)
    eligibility = models.TextField()
    job_type = models.CharField(max_length=50, choices=[('Full-time', 'Full-time'), ('Part-time', 'Part-time')])
    salary_per_annum = models.DecimalField(max_digits=10, decimal_places=2)
    required_experience = models.CharField(max_length=255)
    job_description = models.TextField()
    required_skills = models.TextField()
    vacancy = models.IntegerField()
    job_code = models.CharField(max_length=5, unique=True, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.job_code:
            last_job = Job.objects.order_by('-id').first()
            new_id = int(last_job.job_code[1:]) + 1 if last_job and last_job.job_code else 1
            self.job_code = f'J{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.role} at {self.company.name}"

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


