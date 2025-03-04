from django.db import models
from django.contrib.auth.hashers import make_password, check_password

class SuperAdminDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000")
    alt_phone_number = models.CharField(max_length=15, default="0000000000")
    password = models.CharField(max_length=128)  # Length changed to 128 to accommodate hashed passwords
    aadhar_number = models.CharField(max_length=50, blank=True, null=True)
    last_login = models.DateTimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)

    def save(self, *args, **kwargs):
        if not self.username:
            last_user = SuperAdminDB.objects.order_by('-id').first()
            if last_user and last_user.username.startswith("SAD"):
                last_number = int(last_user.username[3:])
                new_id = f"SAD{last_number + 1:05d}"
            else:
                new_id = "SAD00001"
            self.username = new_id
        
        # Check if password is being updated and not already hashed
        if self._state.adding or (
            'password' in kwargs.get('update_fields', []) and 
            not self.password.startswith(('pbkdf2_sha256$', 'bcrypt$', 'argon2'))
        ):
            self.password = make_password(self.password)
            
        super().save(*args, **kwargs)

    def __str__(self):
        return self.username
        
    def check_password(self, raw_password):
        """
        Return a boolean of whether the raw_password was correct. Handles
        hashing formats behind the scenes.
        """
        return check_password(raw_password, self.password)

class AdminDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000")
    alt_phone_number = models.CharField(max_length=15, default="0000000000")
    password = models.CharField(max_length=128)
    aadhar_number = models.CharField(max_length=50, blank=True, null=True)
    superadmin = models.ForeignKey(SuperAdminDB, on_delete=models.SET_NULL, null=True, blank=True, related_name='admins')
    last_login = models.DateTimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)

    def save(self, *args, **kwargs):
        if not self.username:
            last_user = AdminDB.objects.order_by('-id').first()
            if last_user and last_user.username.startswith("ADM"):
                last_number = int(last_user.username[3:])
                new_id = f"ADM{last_number + 1:05d}"
            else:
                new_id = "ADM00001"
            self.username = new_id

        if self._state.adding or not self.password.startswith(('pbkdf2_sha256$', 'bcrypt$', 'argon2')):
            self.password = make_password(self.password)
        
        super().save(*args, **kwargs)

    def __str__(self):
        return self.username

    def check_password(self, raw_password):
        return check_password(raw_password, self.password)

class ManagerDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000")
    alt_phone_number = models.CharField(max_length=15, default="0000000000")
    password = models.CharField(max_length=128)
    aadhar_number = models.CharField(max_length=50, blank=True, null=True)
    admin = models.ForeignKey(AdminDB, on_delete=models.SET_NULL, null=True, blank=True, related_name='managers')
    last_login = models.DateTimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)

    def save(self, *args, **kwargs):
        if not self.username:
            last_user = ManagerDB.objects.order_by('-id').first()
            if last_user and last_user.username.startswith("MGR"):
                last_number = int(last_user.username[3:])
                new_id = f"MGR{last_number + 1:05d}"
            else:
                new_id = "MGR00001"
            self.username = new_id

        if self._state.adding or not self.password.startswith(('pbkdf2_sha256$', 'bcrypt$', 'argon2')):
            self.password = make_password(self.password)
        
        super().save(*args, **kwargs)

    def __str__(self):
        return self.username

    def check_password(self, raw_password):
        return check_password(raw_password, self.password)

class EmployeeDB(models.Model):
    username = models.CharField(max_length=10, unique=True, editable=False)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone_number = models.CharField(max_length=15, default="0000000000")
    alt_phone_number = models.CharField(max_length=15, default="0000000000")
    password = models.CharField(max_length=128)
    aadhar_number = models.CharField(max_length=50, blank=True, null=True)
    manager = models.ForeignKey(ManagerDB, on_delete=models.SET_NULL, null=True, blank=True, related_name='employees')
    last_login = models.DateTimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)

    def save(self, *args, **kwargs):
        if not self.username:
            last_user = EmployeeDB.objects.order_by('-id').first()
            if last_user and last_user.username.startswith("EMP"):
                last_number = int(last_user.username[3:])
                new_id = f"EMP{last_number + 1:05d}"
            else:
                new_id = "EMP00001"
            self.username = new_id

        if self._state.adding or not self.password.startswith(('pbkdf2_sha256$', 'bcrypt$', 'argon2')):
            self.password = make_password(self.password)
        
        super().save(*args, **kwargs)

    def __str__(self):
        return self.username

    def check_password(self, raw_password):
        return check_password(raw_password, self.password)