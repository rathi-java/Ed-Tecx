from django.db import models

# Create your models here.
# oauth/models.py (OAuth App)
from django.db import models
from datetime import date, timedelta
from django.utils.timezone import now
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin

class UsersDBManager(BaseUserManager):
    def create_user(self, email, full_name, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, full_name=full_name, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, full_name, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')
        return self.create_user(email, full_name, password, **extra_fields)

def save_google_auth_data(backend, user, response, *args, **kwargs):
    if backend.name == 'google':
        google_id = response.get('sub')
        full_name = response.get('name')
        email = response.get('email')
        # Extract other fields from response as needed

        UsersDB.objects.update_or_create(
            email=email,
            defaults={
                'full_name': full_name,
                'google_id': google_id,
                # Add other fields here as needed
            }
        )

class CollegesDb(models.Model):
    college_name = models.CharField(max_length=255)
    college_location = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.college_name}, {self.college_location}"
class UsersDB(AbstractBaseUser, PermissionsMixin):
    full_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True, null=True, blank=True)
    phone_number = models.CharField(
        max_length=15, 
        unique=True, 
        null=True,  # Allow NULL in database
        blank=True,  # Allow blank in forms
        default=None
    )
    password = models.CharField(max_length=128, null=True, blank=True)
    college_name = models.CharField(max_length=255, default="Unknown College")
    course = models.CharField(max_length=255, default="Unknown Course")
    dob = models.DateField(default=date(2000, 1, 1))
    referral_code = models.CharField(max_length=50, blank=True, null=True)
    username = models.CharField(max_length=10, unique=True, editable=False)
    last_login = models.DateTimeField(null=True, blank=True)
    gender = models.CharField(max_length=10, default='other', null=True, blank=True)
    google_id = models.CharField(max_length=255, blank=True, null=True)
    github_id = models.CharField(max_length=100, blank=True, null=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    groups = models.ManyToManyField(
        'auth.Group',
        related_name='oauth_usersdb_set',
        blank=True,
        help_text='The groups this user belongs to.',
        verbose_name='groups',
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        related_name='oauth_usersdb_set',
        blank=True,
        help_text='Specific permissions for this user.',
        verbose_name='user permissions',
    )
    
    objects = UsersDBManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['full_name']

    def save(self, *args, **kwargs):
        if not self.username:
            last_user = UsersDB.objects.order_by('-id').first()
            if last_user and last_user.username.startswith("USR"):
                last_number = int(last_user.username[3:])
                new_id = f"USR{last_number + 1:05d}"
            else:
                new_id = "USR00001"
            self.username = new_id
        super().save(*args, **kwargs)

    def set_subscription(self, plan):
        """
        Assigns a subscription plan to the user.
        Sets the subscription start to now and calculates the end date based on the plan duration.
        """
        self.subscription_plan = plan
        self.subscription_start = now()
        # Approximate each month as 30 days:
        self.subscription_end = now() + timedelta(days=plan.duration_in_months * 30)
        self.save()

    def is_subscription_active(self):
        """
        Checks if the user's subscription is currently active.
        Returns True if subscription_end is set and in the future.
        """
        if self.is_superuser or self.is_staff:
            return True
        return self.subscription_end and self.subscription_end > now()

    def __str__(self):
        return self.username

    def delete(self, *args, **kwargs):
        super().delete(*args, **kwargs)

class Otpdb(models.Model):
    user = models.OneToOneField(UsersDB, on_delete=models.CASCADE, unique=True)
    otp_count = models.IntegerField(default=1)
    otp = models.IntegerField(null=True, blank=True)
    timestamp = models.DateTimeField(default=now)
    status = models.IntegerField(default=0)  # 0: Unused, 1: Used or Expired

    def update_otp(self, new_otp):
        """Update OTP, timestamp, and count when a new OTP is generated."""
        self.otp = new_otp
        self.timestamp = now()
        self.otp_count += 1
        self.status = 0  # Reset status to unused
        self.save()

    def is_expired(self):
        """Check if the OTP is expired (1 minute limit)."""
        return now() > self.timestamp + timedelta(minutes=1)

    def verify_otp(self, entered_otp):
        """Verify OTP and update status accordingly."""
        if self.is_expired():
            self.status = 1  # Mark expired
            self.save()
            return False, "OTP expired"
        
        if self.otp == entered_otp:
            self.status = 1  # Mark used
            self.save()
            return True, "OTP verified"
        
        return False, "Invalid OTP"

    def __str__(self):
        return f"{self.user.username} - OTP Count: {self.otp_count}"
