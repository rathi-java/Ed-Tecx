from django.db import models

class Job(models.Model):
    company_logo = models.ImageField(upload_to='company_logos/')
    profile = models.CharField(max_length=255)
    company_name = models.CharField(max_length=255)
    location_state = models.CharField(max_length=100)
    location_city = models.CharField(max_length=100)
    min_experience = models.IntegerField()  # Minimum experience in years
    max_experience = models.IntegerField()  # Maximum experience in years
    package_min = models.FloatField()  # Minimum salary in LPA
    package_max = models.FloatField()  # Maximum salary in LPA
    employment_types = models.JSONField(default=list)  # Store employment types as a list of strings
    about_job = models.TextField()
    job_id = models.CharField(max_length=10, unique=True, editable=False)  # Auto-generated & not editable
    qualification = models.TextField()
    posted_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    

    def save(self, *args, **kwargs):
        """Auto-generate job_id before saving"""
        if not self.job_id:  # Generate only if job_id is not set
            last_job = Job.objects.order_by('-id').first()
            if last_job and last_job.job_id.startswith("JOB"):
                last_number = int(last_job.job_id[3:])  # Extract numeric part
                new_number = last_number + 1
            else:
                new_number = 1  # First job entry

            self.job_id = f"JOB{new_number:04d}"  # Format as JOB0001, JOB0002, etc.

        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.profile} at {self.company_name} ({self.min_experience}-{self.max_experience} yrs)"
