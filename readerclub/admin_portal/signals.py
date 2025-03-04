from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import SuperAdminDB

@receiver(post_save, sender=User)
def create_superadmin_entry(sender, instance, created, **kwargs):
    if created and instance.is_superuser:  # Only trigger for new superusers
        if not SuperAdminDB.objects.filter(email=instance.email).exists():
            full_name = f"{instance.first_name} {instance.last_name}".strip()  
            
            # If first_name and last_name are missing, use username as full_name
            if not full_name:
                full_name = instance.username  

            super_admin = SuperAdminDB(
                full_name=full_name,  # ✅ Store the correct full name
                email=instance.email,
                password=instance.password,  # ❗ Not recommended, should be hashed
            )
            super_admin.save()  # Username will be auto-generated in save()
