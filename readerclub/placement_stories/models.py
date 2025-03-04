from django.db import models

# Create your models here.
class PlacementStories(models.Model):
    name = models.CharField(max_length=100,default='Unknown Name')
    description = models.TextField(max_length=1000,default='Unknown Description')
    user_profile_pic = models.ImageField(upload_to='profile_pics', null=True, blank=True)
    hand_written_review = models.ImageField(upload_to='hand_written_review', null=True, blank=True)
    company_name = models.CharField(max_length=100, default='Unknown Company')
    designation = models.CharField(max_length=100, default='Unknown Designation')
    package = models.IntegerField(default=0)
    batch=models.CharField(max_length=100,default='Unknown Batch')
    degree=models.CharField(max_length=100,default='Unknown Degree')
    branch=models.CharField(max_length=100,default='Unknown Branch')
