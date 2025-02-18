import datetime
from django.db import models


class Certificate(models.Model):
    STATUS_CHOICES = [
        ('Pending', 'Pending'),
        ('Approved', 'Approved'),
        ('Rejected', 'Rejected')
    ]

    exam_result = models.ForeignKey('examportol.ExamResult', on_delete=models.CASCADE, related_name='certificates')
    name = models.CharField(max_length=255)
    father_name = models.CharField(max_length=255)
    certified_for = models.TextField()
    unique_id = models.CharField(max_length=25, unique=True, blank=True, null=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='Pending')
    created_at = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):
        if not self.unique_id:
            year = datetime.date.today().year
            last_certificate = Certificate.objects.filter(unique_id__startswith=f"CERT{year}").order_by('-id').first()
            if last_certificate and last_certificate.unique_id:
                last_number = int(last_certificate.unique_id.split('-')[-1])
                new_number = last_number + 1
            else:
                new_number = 1
            self.unique_id = f"CERT{year}-{new_number:05d}"
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name} - {self.unique_id} ({self.status})"
