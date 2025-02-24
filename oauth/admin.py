from django.contrib import admin
from .models import *

# Define a custom admin class for CollegesDb
class CollegesDbAdmin(admin.ModelAdmin):
    list_display = ('college_name', 'college_location')  # Display the college name and location in the list view
    search_fields = ('college_name', 'college_location')  # Allow searching by college name or location
    list_filter = ('college_location',)  # Filter by location
    ordering = ('college_name',)  # Default ordering by college name

# Define a custom admin class for UserDB
class UserDBAdmin(admin.ModelAdmin):
    list_display = ('username', 'full_name', 'email', 'college_name', 'dob', 'phone_number')  # Display key fields
    search_fields = ('username', 'full_name', 'email', 'college_name')  # Allow searching by key fields
    list_filter = ('college_name', 'dob')  # Filter by college name and DOB
    ordering = ('username',)  # Default ordering by username
    
    # Make the password field not editable in the admin interface for security
    readonly_fields = ('password',)

    # Optional: to customize the user creation form
    def save_model(self, request, obj, form, change):
        # Ensure password is saved as hashed (if you're not already using a hashed field)
        if not obj.pk:  # If creating a new user
            obj.set_password(obj.password)  # Hash the password
        obj.save()

# Register the models and their custom admin classes
admin.site.register(CollegesDb, CollegesDbAdmin)
admin.site.register(UsersDB, UserDBAdmin)
class OtpdbAdmin(admin.ModelAdmin):
    list_display = ('user', 'otp', 'timestamp', 'status')  # Use 'user' instead of 'username'
    readonly_fields = ('user', 'otp', 'timestamp', 'status')  # Remove 'otp_count'
    search_fields = ('user__email',)  # Search by user email if needed

admin.site.register(Otpdb, OtpdbAdmin)
