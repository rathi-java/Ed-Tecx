from django.db import models
from datetime import date

class CollegesDb(models.Model):
    college_name = models.CharField(max_length=255)
    college_location = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.college_name}, {self.college_location}"

class UsersDB(models.Model):
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000", unique=True)
    password = models.CharField(max_length=128)  # Updated max_length for password
    college_name = models.CharField(max_length=255, default="Unknown College")
    dob = models.DateField(default=date(2000, 1, 1))
    referral_code = models.CharField(max_length=50, blank=True, null=True)
    username = models.CharField(max_length=10, unique=True, editable=False)
    last_login = models.DateTimeField(null=True, blank=True)  # Add last_login field

    def update_last_login(self):
        from django.utils import timezone
        self.last_login = timezone.now()
        self.save()
    
    def save(self, *args, **kwargs):
        if not self.username:  # Only generate a username if it's not set
            last_user = UsersDB.objects.order_by('-id').first()
            if last_user and last_user.username.startswith("USR"):
                last_number = int(last_user.username[3:])  # Extract numeric part
                new_id = f"USR{last_number + 1:05d}"  # Increment and format
            else:
                new_id = "USR00001"  # Start with USR00001 if no user exists
            
            self.username = new_id  # Assign username
        
        super().save(*args, **kwargs)  # Save the user after setting username

    def __str__(self):
        return self.username
