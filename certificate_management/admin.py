from django.contrib import admin
from .models import Certificate

@admin.register(Certificate)
class CertificateAdmin(admin.ModelAdmin):
    list_display = ('name', 'father_name', 'certified_for', 'unique_id', 'status', 'created_at')
    list_filter = ('status', 'created_at')
    search_fields = ('name', 'father_name', 'unique_id', 'certified_for')
    ordering = ('-created_at',)
    actions = ['approve_certificates', 'reject_certificates']

    def approve_certificates(self, request, queryset):
        queryset.update(status='Approved')
        self.message_user(request, "Selected certificates have been approved.")

    approve_certificates.short_description = "Approve selected certificates"

    def reject_certificates(self, request, queryset):
        queryset.update(status='Rejected')
        self.message_user(request, "Selected certificates have been rejected.")

    reject_certificates.short_description = "Reject selected certificates"
