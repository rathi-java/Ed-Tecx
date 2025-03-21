from django.db import models
from django.conf import settings
from recruitment_portal.models import Company, ApplicantDetail,Category



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




class JobApplication(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)  # OAuth User
    applicantdetails = models.ForeignKey(ApplicantDetail, on_delete=models.CASCADE)
    job = models.ForeignKey(Job, on_delete=models.CASCADE)
    skills = models.TextField()  # Skills relevant to the job application
    expected_ctc = models.CharField(max_length=50, blank=True, null=True)  # e.g., "8 LPA"
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.applicantdetails.first_name} {self.job_seeker.last_name} - {self.job.role}"

    class Meta:
        db_table = 'jobportal_jobapplication'