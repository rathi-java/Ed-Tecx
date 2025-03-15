from django.db import models
from django.conf import settings

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
        db_table = 'jobportal_category'


class Company(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField()
    email = models.EmailField(unique=True)
    contact_number = models.CharField(max_length=20)
    logo = models.ImageField(upload_to='company_logos/', blank=True, null=True)
    about = models.TextField(max_length=200)
    working_employees = models.IntegerField()
    established_year = models.IntegerField()
    company_code = models.CharField(max_length=6, unique=True, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        # Check and set company_code instead of category_code
        if not self.company_code:
            last_company = Company.objects.order_by('-id').first()
            new_id = int(last_company.company_code[2:]) + 1 if last_company and last_company.company_code else 1
            self.company_code = f'CO{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'jobportal_company'


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
    job_code = models.CharField(max_length=6, unique=True, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.job_code:
            last_job = Job.objects.last() 
            new_id = int(last_job.job_code[1:]) + 1 if last_job and last_job.job_code else 1
            self.job_code = f'J{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.role} at {self.company.name}"

    class Meta:
        db_table = 'jobportal_job'


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
        db_table = 'jobportal_domain'



# ---------------------------
# JobSeeker Model (User Profile)
# ---------------------------
class JobSeeker(models.Model):
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
        db_table = 'jobportal_jobseeker'


# ---------------------------
# JobSeekerEducation Model (Multiple Educations)
# ---------------------------
class JobSeekerEducation(models.Model):
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE, related_name="educations")
    degree = models.CharField(max_length=255)  # e.g., "B.Tech", "M.Sc"
    specialization = models.CharField(max_length=255, blank=True, null=True)  # e.g., "Computer Science"
    institution = models.CharField(max_length=255)  # e.g., "MIT", "Stanford University"
    passing_year = models.CharField(max_length=4)  # e.g., "2024"
    score = models.CharField(max_length=50, blank=True, null=True)  # e.g., "85%"

    def __str__(self):
        return f"{self.degree} in {self.specialization} from {self.institution}"

    class Meta:
        db_table = 'jobportal_jobseeker_education'


# ---------------------------
# JobSeekerExperience Model (Multiple Work Experiences)
# ---------------------------
class JobSeekerExperience(models.Model):
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE, related_name="experiences")
    company = models.CharField(max_length=255)  # Company name as text
    role = models.CharField(max_length=255)  # Role/position held
    start_date = models.DateField()
    end_date = models.DateField(blank=True, null=True)  # Leave null if currently employed
    description = models.TextField(blank=True, null=True)  # Job responsibilities or summary
    achievements = models.TextField(blank=True, null=True)  # Optional: achievements or notable contributions

    def __str__(self):
        return f"{self.role} at {self.company}"

    class Meta:
        db_table = 'jobportal_jobseeker_experience'


# ---------------------------
# JobApplication Model
# ---------------------------
class JobApplication(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)  # OAuth User
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE)
    job = models.ForeignKey(Job, on_delete=models.CASCADE)
    skills = models.TextField()  # Skills relevant to the job application
    expected_ctc = models.CharField(max_length=50, blank=True, null=True)  # e.g., "8 LPA"
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.job_seeker.first_name} {self.job_seeker.last_name} - {self.job.role}"

    class Meta:
        db_table = 'jobportal_jobapplication'