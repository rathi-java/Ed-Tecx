from django.db import models

class SuperAdminDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000")
    alt_phone_number = models.CharField(max_length=15, default="0000000000")
    password = models.CharField(max_length=128)  # Updated max_length for password
    aadhar_number = models.CharField(max_length=50, blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.username:  # Only generate a username if it's not set
            last_user = SuperAdminDB.objects.order_by('-id').first()
            if last_user and last_user.username.startswith("SAD"):
                last_number = int(last_user.username[3:])  # Extract numeric part
                new_id = f"SAD{last_number + 1:05d}"  # Increment and format
            else:
                new_id = "SAD00001"  # Start with USR00001 if no user exists
            
            self.username = new_id  # Assign username
        
        super().save(*args, **kwargs)  # Save the user after setting username

    def __str__(self):
        return self.username

class AdminDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000")
    alt_phone_number = models.CharField(max_length=15, default="0000000000")
    password = models.CharField(max_length=128)  # Updated max_length for password
    aadhar_number = models.CharField(max_length=50, blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.username:  # Generate username only if it's not set
            last_user = AdminDB.objects.order_by('-id').first()  # Fetch from AdminDB
            if last_user and last_user.username.startswith("ADM"):
                last_number = int(last_user.username[3:])  # Extract numeric part
                new_id = f"ADM{last_number + 1:05d}"  # Increment and format
            else:
                new_id = "ADM00001"  # Start with ADM00001 if no admin exists
            
            self.username = new_id  # Assign username
        
        super().save(*args, **kwargs)  # Save the user after setting username

    def __str__(self):
        return self.username

class ManagerDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000")
    alt_phone_number = models.CharField(max_length=15, default="0000000000")
    password = models.CharField(max_length=128)  # Updated max_length for password
    aadhar_number = models.CharField(max_length=50, blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.username:  # Generate username only if it's not set
            last_user = ManagerDB.objects.order_by('-id').first()  # Fetch from ManagerDB
            if last_user and last_user.username.startswith("MGR"):
                last_number = int(last_user.username[3:])  # Extract numeric part
                new_id = f"MGR{last_number + 1:05d}"  # Increment and format
            else:
                new_id = "MGR00001"  # Start with MGR00001 if no manager exists
            
            self.username = new_id  # Assign username
        
        super().save(*args, **kwargs)  # Save the user after setting username

    def __str__(self):
        return self.username
    
class EmployeeDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000")
    alt_phone_number = models.CharField(max_length=15, default="0000000000")
    password = models.CharField(max_length=128)  # Updated max_length for password
    aadhar_number = models.CharField(max_length=50, blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.username:  # Generate username only if it's not set
            last_user = EmployeeDB.objects.order_by('-id').first()  # Fetch from EmployeeDB
            if last_user and last_user.username.startswith("EMP"):
                last_number = int(last_user.username[3:])  # Extract numeric part
                new_id = f"EMP{last_number + 1:05d}"  # Increment and format
            else:
                new_id = "EMP00001"  # Start with EMP00001 if no employee exists
            
            self.username = new_id  # Assign username
        
        super().save(*args, **kwargs)  # Save the user after setting username

    def __str__(self):
        return self.username