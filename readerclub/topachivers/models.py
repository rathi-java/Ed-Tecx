from django.db import models

# Create your models here.

class TopAchiever(models.Model):
    name = models.CharField(max_length=255)
    company = models.CharField(max_length=255)
    designation = models.CharField(max_length=255)
    package = models.CharField(max_length=50)  # e.g., "10 LPA"
    image = models.ImageField(upload_to='achievers/')  # Path to store achiever images
    rank = models.IntegerField(default=0)  # Rank of the achiever
    def __str__(self):
        return f"{self.name} - {self.company}"
